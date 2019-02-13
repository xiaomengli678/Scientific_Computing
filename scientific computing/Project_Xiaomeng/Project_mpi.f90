program Project
  use mpi
  implicit none
  integer :: ierr, nprocs, myid, s=4, NX_v(0:4)=(/20, 40, 80, 160, 320/)
  real(kind=8) :: mpi_t0, mpi_t1, mpi_dt

  call mpi_init(ierr)
  call mpi_comm_size(MPI_COMM_WORLD, nprocs, ierr)
  call mpi_comm_rank(MPI_COMM_WORLD, myid, ierr)

  call MPI_BARRIER(MPI_COMM_WORLD,ierr)
  mpi_t0=mpi_wtime()

  ! %an increasing sequence of the number of grid points
  call err_calc(s,NX_v,ierr, nprocs, myid)

  !figure
  !surf(x,y,u2); shading interp

  !figure
  !loglog(H,E,'o-',H,H.^2,'r')
  !legend('\epsilon(h)','h^2')
  !xlabel('h')
  call mpi_finalize(ierr)
end program Project
subroutine err_calc(s,NX_v,ierr, nprocs, myid)
  use printble
  use mpi
  implicit none
  integer, intent(in) :: s, NX_v(0:s)
  real(kind = 8) :: E(0:s), H(0:s)
  integer :: nx, ny, kk,ierr,nprocs,myid

  !!! loop through NX
  do kk=0,s
    nx=NX_v(kk)
    ny=nx
    call wave2d(E,H,s,kk,nx,ny,ierr, nprocs, myid)
  end do
  call printdble1d(H,s,"H.txt")
  call printdble1d(E,s,"E.txt")

end subroutine err_calc
subroutine wave2d(E,H,s,kk,nx,ny,ierr, nprocs, myid)
  use printble
  use wave2dh
  use mpi
  implicit none
  integer, intent(in) :: nx,ny,s,kk
  real(kind=8) :: hx,hy
  real(kind=8), intent(out) :: E(0:s),H(0:s)
  integer :: px,ix_off ! the x-proc index and the offset
  integer :: p_left,p_right,px_max
  integer :: nxl       !this is the local size
  integer :: remx
  real(kind=8) :: mpi_t0, mpi_t1, mpi_dt
  integer :: ierr,nprocs,myid
  integer :: int_sum, nx1

  !%equal number of grid points in x and y directions
  hx=2d0/(nx)
  !%grid length in x direction
  hy=2d0/(ny)

  ! Label the processes from 1 to px_max
  px = myid + 1
  px_max = nprocs
  nx1 = nx/px_max

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

  call allocate_via_subroutine(E,H,nx1+1,ny,s,kk,ix_off)

end subroutine wave2d
subroutine allocate_via_subroutine(E,H,nx,ny,s,kk,ix_off)
  integer, intent(in) :: nx,ny,s,kk
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
  real(kind=8) :: mpi_t0, mpi_t1, mpi_dt
  integer :: i,j,k,nt,ierr,nprocs,myid,ix_off

  H(kk)=hx
  
  ! should be equal to x=(-1:hx:1);
  do i=1,nx
    x(i)=-1d0+dble(i-1+ix_off)*hx
  end do
  ! should be equal to y=(-1:hy:1)';
  do i=0,ny
    y(i)=-1d0+i*hy
  end do

  t_final=1
  dt=0.5d0*hx
  nt=floor(t_final/dt)+1
  dt=t_final/nt

  !%Set up initial data and obtain u0 and u1

  do i=0,ny
    do j=1,nx
      call u_exact(tmp,0d0,x(i),y(j),w,kx,ky)
      ! j,i so I get the transpose
      u0(j,i)=tmp(1)
    end do
  end do

  do j=0,ny
    do i=1,nx
      call f2_fun(tmp,x(i),y(j),w,kx,ky)
      f2(j,i)=tmp(1)
    end do
  end do

  do j=1,nx
    do i=0,ny
      call forcing(tmp,0d0,x(i),y(j),w,kx,ky)
      f(j,i)=tmp(1)
    end do
  end do

  call laplac(L,u0,hx,hy,nx,ny)

  do i=1,nx
    do j=0,ny
      u1(i,j)=u0(i,j)+dt*f2(i,j)+0.5d0*(dt**2d0)*(L(i,j)+f(i,j))
    end do
  end do

  ! %update BC
  !
  ! I need to create column and row functions to get what I need here
  !

  ! converted u1(1,:)=u_exact(dt,x,-1,w,kx,ky);
  do i=1,ny
    call u_exact(tmp,dt,x(i),-1d0,w,kx,ky)
    u1(0,i)=tmp(1)
  end do
  ! converted u1(ny,:)=u_exact(dt,x,1,w,kx,ky);
  do i=1,ny
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
end subroutine allocate_via_subroutine

