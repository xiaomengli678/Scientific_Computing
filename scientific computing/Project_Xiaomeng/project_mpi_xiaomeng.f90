program Project
  use mpi
  implicit none
  integer :: ierr, nprocs, myid, s=4, NX_v(0:4)=(/20, 40, 80, 160, 320/)
  real(kind=8) :: mpi_t0, mpi_t1, mpi_dt
  integer :: status(MPI_STATUS_SIZE)
  integer :: px,ix_off ! the x-proc index and the offset
  integer :: p_left,p_right,px_max,int_sum

  integer, parameter :: nx = 200
  real(kind = 8) :: t_final = 2.d0
  integer :: i,j,nt,it
  integer :: nxl       !this is the local size
  integer :: remx

  call mpi_init(ierr)
  call mpi_comm_size(MPI_COMM_WORLD, nprocs, ierr)
  call mpi_comm_rank(MPI_COMM_WORLD, myid, ierr)

  call MPI_BARRIER(MPI_COMM_WORLD,ierr)
  mpi_t0=mpi_wtime()

  ! Label the processes from 1 to px_max
  px = myid + 1
  px_max = nprocs
  
  ! Split up the grid in the x-direction
  nxl = nx/px_max
  remx = nx-nxl*px_max
  if (px .le. remx) then
     nxl = nxl + 1
     ix_off = (px-1)*nxl
  else
     ix_off = (remx)*(nxl+1) + (px-(remx+1))*nxl
  end if
  call MPI_BARRIER(MPI_COMM_WORLD,ierr)
  call MPI_Reduce(nxl,int_sum,1,&
       MPI_INTEGER,MPI_SUM,&
       0,MPI_COMM_WORLD,ierr)
  if(myid == 0) then
     if (nx .ne. int_sum) then
        write(*,*) 'Something is wrong with the number of points in x-direction: ',&
             nx,int_sum
     end if
  end if

! Determine the neighbours of processor px
  p_left  = px-1 - 1
  p_right = px+1 - 1
  if (px .eq. px_max) p_right = MPI_PROC_NULL
  if (px .eq. 1) p_left = MPI_PROC_NULL  

  ! %an increasing sequence of the number of grid points
  call err_calc(s,NX_v,ierr,nprocs,myid,nxl,p_left,p_right,px_max,mpi_t0,mpi_t1,mpi_dt,px,ix_off,remx)

  !figure
  !surf(x,y,u2); shading interp

  !figure
  !loglog(H,E,'o-',H,H.^2,'r')
  !legend('\epsilon(h)','h^2')
  !xlabel('h')

  call MPI_BARRIER(MPI_COMM_WORLD,ierr)
  mpi_t1=mpi_wtime()
  mpi_dt=mpi_t1-mpi_t0
  if(myid.eq.0) write(*,*) "With", nprocs, "  processors the wall clock time = ", mpi_dt, " sec."

  call mpi_finalize(ierr)
end program Project

subroutine err_calc(s,NX_v,ierr,nprocs,myid,nxl,p_left,p_right,px_max,mpi_t0,mpi_t1,mpi_dt,px,ix_off,remx)
  use printble
  use mpi
  implicit none
  integer, intent(in) :: s, NX_v(0:s),nxl
  real(kind = 8) :: E(0:s), H(0:s)
  integer :: nx, ny, kk,ierr,nprocs,myid
  integer, intent(in) :: remx,px,ix_off
  integer, intent(in) :: p_left,p_right,px_max
  real(kind=8), intent(in) :: mpi_t0, mpi_t1, mpi_dt 
  !!! loop through NX
  do kk=0,s
    nx=NX_v(kk)
    ny=nx
    call wave2d(E,H,s,kk,nx,ny,nprocs,myid,nxl,ierr,nprocs,ierr,p_left,p_right,px_max,mpi_t0,mpi_t1,mpi_dt,px,ix_off,remx)
  end do
  call printdble1d(H,s,"H.txt")
  call printdble1d(E,s,"E.txt")
end subroutine err_calc
 
subroutine wave2d(E,H,s,kk,nx,ny,nprocs,myid,nxl,ierr,p_left,p_right,px_max,mpi_t0, mpi_t1,mpi_dt,px,ix_off,remx)
  use printble
  use wave2dh
  use mpi
  implicit none
  integer, intent(in) :: ierr, nprocs, myid, nxl, remx,px,ix_off 
  integer :: status(MPI_STATUS_SIZE)

  integer, intent(in) :: nx,ny,s,kk,p_left,p_right,px_max
  real(kind=8), intent(in) :: mpi_t0, mpi_t1, mpi_dt
  real(kind=8), intent(out) :: E(0:s),H(0:s)
  real(kind=8) :: x(0:nx), y(0:ny)
  real(kind=8) :: t, t_final, dt, w=10, kx=6, ky=4, t_real, hx, hy
  ! to get the results from each function
  real(kind=8) :: tmp(1)
  real(kind=8) :: u0(0:nx,0:ny)
  real(kind=8) :: u1(0:nx,0:ny)
  real(kind=8) :: u2(0:nx,0:ny)
  real(kind=8) :: u_ex_final(0:nx,0:ny)
  real(kind=8) :: f2(0:nx,0:ny), L(0:nx,0:ny), f(0:nx,0:ny), tmptbl(0:nx,0:ny)
  
  integer :: i,j,k,nt
 
  !%equal number of grid points in x and y directions
  hx=2d0/(nx)
  !%grid length in x direction
  hy=2d0/(ny)
!  print *, hx, hy
  H(kk)=hx
  
  ! should be equal to x=(-1:hx:1);
  do i=0,nx
    x(i)=-1d0+i*hx
  end do
  call MPI_Sendrecv(x(1),1,MPI_DOUBLE_PRECISION,p_left,123,&
       x(nxl+1),1,MPI_DOUBLE_PRECISION,p_right,123,MPI_COMM_WORLD,status,ierr)
  ! send to right recieve from left
  call MPI_Sendrecv(x(nxl),1,MPI_DOUBLE_PRECISION,p_right,125,&
       x(0),1,MPI_DOUBLE_PRECISION,p_left,125,MPI_COMM_WORLD,status,ierr)
  call MPI_BARRIER(MPI_COMM_WORLD,ierr)

  ! should be equal to y=(-1:hy:1)';
  do i=0,ny
    y(i)=-1d0+i*hy
  end do
  call MPI_Sendrecv(y(1),1,MPI_DOUBLE_PRECISION,p_left,123,&
       x(nxl+1),1,MPI_DOUBLE_PRECISION,p_right,123,MPI_COMM_WORLD,status,ierr)
  ! send to right recieve from left
  call MPI_Sendrecv(y(nxl),1,MPI_DOUBLE_PRECISION,p_right,125,&
       x(0),1,MPI_DOUBLE_PRECISION,p_left,125,MPI_COMM_WORLD,status,ierr)
  call MPI_BARRIER(MPI_COMM_WORLD,ierr)

  t_final=1
  dt=0.5d0*hx
  nt=floor(t_final/dt)+1
  dt=t_final/nt

  !%Set up initial data and obtain u0 and u1

  do i=0,ny
    do j=0,nx
      call u_exact(tmp,0d0,x(i),y(j),w,kx,ky)
      ! j,i so I get the transpose
      u0(j,i)=tmp(1)
    end do
  end do

  do j=0,ny
    do i=0,nx
      call f2_fun(tmp,x(i),y(j),w,kx,ky)
      f2(j,i)=tmp(1)
    end do
  end do

  do j=0,nx
    do i=0,ny
      call forcing(tmp,0d0,x(i),y(j),w,kx,ky)
      f(j,i)=tmp(1)
    end do
  end do

  call laplac(L,u0,hx,hy,nx,ny)

  do i=0,nx
    do j=0,ny
      u1(i,j)=u0(i,j)+dt*f2(i,j)+0.5d0*(dt**2d0)*(L(i,j)+f(i,j))
    end do
  end do

  ! %update BC
  !
  ! I need to create column and row functions to get what I need here
  !

  ! converted u1(1,:)=u_exact(dt,x,-1,w,kx,ky);
  do i=0,ny
    call u_exact(tmp,dt,x(i),-1d0,w,kx,ky)
    u1(0,i)=tmp(1)
  end do
  ! converted u1(ny,:)=u_exact(dt,x,1,w,kx,ky);
  do i=0,ny
    call u_exact(tmp,dt,x(i),1d0,w,kx,ky)
    u1(nx,i)=tmp(1)
  end do
  ! converted u1(:,1)=u_exact(dt,-1,y,w,kx,ky);
  do i=0,nx
    call u_exact(tmp,dt,-1d0,y(i),w,kx,ky)
    u1(i,0)=tmp(1)
  end do
  ! converted u1(:,nx)=u_exact(dt,1,y,w,kx,ky);
  do i=0,nx
    call u_exact(tmp,dt,1d0,y(i),w,kx,ky)
    u1(i,ny)=tmp(1)
  end do

  call printdble2d(u1,nx,ny,naming("post_",kk))



  do k=0,(nt-2)
      ! Communicate between processors
     ! send to left recieve from right
  
    t=(k+1)*dt;
    ! %obtin right hand side

    do j=0,nx
      do i=0,ny
        call forcing(tmp,t,x(i),y(j),w,kx,ky)
        f(j,i)=tmp(1)
      end do
    end do

    call laplac(L,u1,hx,hy,nx,ny)
    ! %March in time
    call MPI_Sendrecv(u2(0,0),1,MPI_DOUBLE_PRECISION,p_left,123,&
          u2(nx,ny),1,MPI_DOUBLE_PRECISION,p_right,123,MPI_COMM_WORLD,status,ierr)
     ! send to right recieve from left                                                                                                  
     call MPI_Sendrecv(u2(nx,ny),1,MPI_DOUBLE_PRECISION,p_right,125,&
          u2(0,0),1,MPI_DOUBLE_PRECISION,p_left,125,MPI_COMM_WORLD,status,ierr)
     call MPI_BARRIER(MPI_COMM_WORLD,ierr)

    do i=0,nx
      do j=0,ny
        u2(i,j)=2*u1(i,j)-u0(i,j)+(dt**2)*(L(i,j)+f(i,j))
      end do
    end do
    ! %update BC
    ! converted u2(1,:)=u_exact(t+dt,x,-1,w,kx,ky);
    do i=0,ny
      call u_exact(tmp,t+dt,x(i),-1d0,w,kx,ky)
      u2(0,i)=tmp(1)
    end do
    ! converted u2(ny,:)=u_exact(t+dt,x,1,w,kx,ky);
    do i=0,ny
      call u_exact(tmp,t+dt,x(i),1d0,w,kx,ky)
      u2(nx,i)=tmp(1)
    end do
    ! converted u2(:,1)=u_exact(t+dt,-1,y,w,kx,ky);
    do i=0,nx
      call u_exact(tmp,t+dt,-1d0,y(i),w,kx,ky)
      u2(i,0)=tmp(1)
    end do
    ! converted u2(:,nx)=u_exact(t+dt,1,y,w,kx,ky);
    do i=0,nx
      call u_exact(tmp,t+dt,1d0,y(i),w,kx,ky)
      u2(i,ny)=tmp(1)
    end do
    ! %switch solution at different time levels
    do i=0,nx
      do j=0,ny
        u0(i,j)=u1(i,j)
        u1(i,j)=u2(i,j)    
      end do
    end do
  end do
  !%compute the error
  do i=0,ny
    do j=0,nx
      call u_exact(tmp,t_final,x(i),y(j),w,kx,ky)
      ! j,i so I get the transpose
      u_ex_final(j,i)=tmp(1)
    end do
  end do
  call printdble2d(u2,nx,ny,naming("U2_",kk))
  call printdble2d(u_ex_final,nx,ny,naming("UE_",kk))
  E(kk)=maxval(abs(u2(0:nx,0:ny)-u_ex_final(0:nx,0:ny)))
end subroutine wave2d
