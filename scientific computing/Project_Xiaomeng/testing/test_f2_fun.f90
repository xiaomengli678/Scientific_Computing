program helper
  implicit none
  call u_exact_test(4)
end program helper

subroutine u_exact_test(nx)
  use wave2dh
  implicit none
  integer, intent(in) :: nx
  real(kind = 8) :: x(0:nx), y(0:nx), f2(0:nx,0:nx)
  real(kind = 8) :: w=10,kx=6,ky=4,hx,hy,tmp(1)
  integer :: i,j, ny
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
  print *, "w =", w
  print *, "kx =", kx
  print *, "ky =", ky

  do j=0,ny
    do i=0,nx
      call f2_fun(tmp,x(i),y(j),w,kx,ky)
      f2(j,i)=tmp(1)
    end do
  end do

!  print *, "hx =", hx
!  print *, "hy =", hy

  print *, "f2 ="
  do i=0,nx
    print *, f2(i,:)
  end do
end subroutine u_exact_test

