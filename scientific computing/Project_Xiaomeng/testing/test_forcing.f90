program helper
  implicit none
  call forcing_test(4)
end program helper

subroutine forcing_test(nx)
  use wave2dh
  implicit none
  integer, intent(in) :: nx
  real(kind = 8) :: x(0:nx), y(0:nx)
  real(kind = 8) :: f(0:nx,0:nx)
  real(kind = 8) :: w=10,kx=6,ky=4,hx,hy,tmp(1)
  integer :: ny,i,j
  ny=nx
  hx=2d0/(nx)
  hy=2d0/(ny)

  do i=0,nx
    x(i)=-1d0+i*hx
  end do
  ! should be equal to y=(-1:hy:1)';
  do i=0,ny
    y(i)=-1d0+i*hy
  end do

  print *, "x =", x
  print *, "y =", y

  do j=0,nx
    do i=0,ny
      call forcing(tmp,0d0,x(i),y(j),w,kx,ky)
      f(j,i)=tmp(1)
    end do
  end do

  print *, "f ="
  do i=0,nx
    print *, f(i,:)
  end do
end subroutine forcing_test

