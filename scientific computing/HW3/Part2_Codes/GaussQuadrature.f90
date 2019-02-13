! 
program GaussQuadrature
  
  integer :: n 
  real(kind=8), parameter :: thr1 = 2.5321317147938851d0
  ! when it is pi, use n = 100000000, get theoretical answer 2.5321317147938851d0
  real(kind=8), parameter :: thr2 = 2.4522838556713853d0
  ! when it is pi*pi, use n = 100000000, get theoretical answer 2.4522838556713853d0
  real(kind = 8), parameter :: pi = 3.1415926535897932d0 
  real(kind = 8), dimension(:), allocatable :: x,f,w
  real(kind = 8) :: Integral_value, error
  !allocate(x(0:n),f(0:n),w(0:n))

  do n=2,5000
     allocate(x(0:n),f(0:n),w(0:n))
     call lglnodes(x,w,n)
     !f = exp(cos(pi*pi*x))
     f = exp(cos(pi*x))
     Integral_value = sum(f*w)
     print *, Integral_value
     !error = abs(thr2 - Integral_value)
     error = abs(thr1 - Integral_value)
     print *, n, error
     
     if (error <= 1.0d-10) exit
     deallocate(x,f,w)
  enddo
  
     
 
end program GaussQuadrature


