subroutine wave2d(E,H,s,kk,nx,ny)
  implicit none
  integer, intent(in) :: nx,ny,s,kk
  real(kind = 8), intent(out) :: E(0:s),H(0:s)
  real(kind = 8) :: x(0:nx), y(0:ny)
  real(kind = 8) :: t, t_final, dt, w, kx, ky, t_real
  real(kind = 8) :: u0(0:nx,0:ny)
  real(kind = 8) :: u1(0:nx,0:ny)
  real(kind = 8) :: u2(0:nx,0:ny)
  real(kind = 8) :: u_ex_final(0:nx,0:ny)
  real(kind = 8) :: f2(0:nx,0:ny), L(0:nx,0:ny), f(0:nx,0:ny)
  integer :: i,j,k,nt
  real(kind = 8) :: hx,hy
  character(len=1024) :: pre_filename
  character(len=1024) :: post_filename
  write (pre_filename, "(A6,I1,A4)") "pre_x_", kk, ".txt"
  write (post_filename, "(A7,I1,A4)") "post_x_", kk, ".txt"

  !%equal number of grid points in x and y directions
  hx=2d0/(nx-1)
  !%grid length in x direction
  hy=2d0/(ny-1)
  print *, hx
  H(kk)=hx


  ! should be equal to x=(-1:hx:1);
  do i=0,nx
    x(i)=-1d0+i*hx
  end do
  ! should be equal to y=(-1:hy:1)';
  do i=0,ny
    y(i)=-1d0+i*hy
  end do

  t_final=1
  dt=0.5d0*hx
  nt=floor(t_final/dt)+1
  dt=t_final/nt

  w=10d0
  kx=6d0
  ky=4d0

  do i=0,nx
    do j=0,ny
     u0(i,j)=i+j
    end do
  end do
!  print *,"wave2d", u0
  call printdble2d(u0,nx,ny,pre_filename)
  call x_manip(u0,nx)
  call printdble2d(u0,nx,ny,post_filename)

end subroutine wave2d
