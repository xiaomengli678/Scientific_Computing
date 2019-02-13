module xycoord
  real(kind = 8), parameter :: pi = acos(-1.d0)
  save
  contains
  
  real(kind=8) function x_coord(r,s)
    implicit none
    real(kind=8) r,s
    ! x_coord = (6.5d0+r+5.d0*s)*cos(4.d0*s)
    !x_coord = (2.d0+r+0.2*sin(5.d0*pi*s))*cos(0.5d0*pi*s)
    x_coord = r+0.1d0*s
    !x_coord = r
  end function x_coord

  real(kind=8) function y_coord(r,s)
    implicit none
    real(kind=8) r,s
    !y_coord = (6.5d0+r+5.d0*s)*sin(4.d0*s)
    !y_coord = (2.d0+r+0.2*sin(5.d0*pi*s))*sin(0.5d0*pi*s)
    y_coord = s
    !y_coord = s + s*r**2
  end function y_coord

  subroutine setup (u,uxExact,uyExact,xc,yc,ns,nr)
  real(kind = 8), dimension(:,:),allocatable, intent (in):: xc,yc
  integer , intent (in):: nr,ns
  real(kind = 8), intent (out):: u(0:nr,0:ns),uxExact(0:nr,0:ns),uyExact(0:nr,0:ns)
  integer :: i,j
  !Sets up our values for u.
  !$omp parallel do private(i,j)
  do j = 0,ns
     do i = 0,nr
        !u(i,j) = sin(r(i))*cos(s(j))
        !u(i,j) = 1d0
        !uxExact(i,j) = 0d0
        !uyExact(i,j) = 0d0
        !Trig Function 1
        !u(i,j) = sin(xc(i,j))*cos(yc(i,j))
        !uxExact(i,j) = cos(xc(i,j))*cos(yc(i,j))
        !uyExact(i,j) = (-sin(xc(i,j)))*sin(yc(i,j))
        !Exponential Function
        u(i,j) = sin(xc(i,j)) * cos(yc(i,j))
        uxExact(i,j) = cos(xc(i,j)) * cos(yc(i,j)) !Derivative is the same
        uyExact(i,j) = -sin(xc(i,j)) * sin(yc(i,j)) !Derivative is the same
        !Quadratic Function
        !u(i,j) = xc(i,j)**2 + yc(i,j)**2
        !uxExact(i,j) = 2*xc(i,j)
        !uyExact(i,j) = 2*xc(i,j)
     end do
  end do
  !$omp end parallel do
end subroutine setup

end module xycoord
