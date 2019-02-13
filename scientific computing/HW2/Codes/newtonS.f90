!
! A simple example: solving an equation f(x) = 0
! using Newton's method
!
! This is the template file used for the scripted version  
!
program newton
  
  implicit none
  double precision :: f,fp,x,dx,xn,Eabsplus1,Eabs,a,b
  integer :: iter
  
  ! Here we try to find the solution to f(x) = 0
  x = -0.5d0
  Eabs = 1.0d0
  xn = x + 1
  iter = 1
  do while (abs(xn - x) > 1.0d-15)
     Eabsplus1 = abs(xn - x)
     f = ffun(x)
     fp = fpfun(x)
     dx = -f/fp
     xn = x
     x = x + dx
     a = Eabsplus1 / Eabs
     b = Eabsplus1 / (Eabs * Eabs)
     write(*,'(A18,I2.2,2(E24.16))') ' sin(x)+cos(x*x) ', iter, x, dx, a, b
     Eabs = Eabsplus1
     iter = iter + 1
  end do

contains

  double precision function ffun(x)
    implicit none
    double precision :: x

    ffun = sin(x)+cos(x*x)

  end function ffun

  double precision function fpfun(x)
    implicit none
    double precision :: x

    fpfun = cos(x)-2.d0*x*sin(x*x)

  end function fpfun

end program newton
