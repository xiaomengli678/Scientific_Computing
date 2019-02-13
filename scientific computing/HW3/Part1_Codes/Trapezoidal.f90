program Trapezoidal
 
   interface linspace
        function linspace(a,b,n)
          real(kind=8), intent(in) :: a,b
          integer, intent(in) :: n
          real(kind=8) :: linspace(n)
          real(kind=8) :: h
          integer :: i
        end function linspace
     end interface linspace

     integer :: n
      real(kind=8), allocatable, dimension(:) :: x
  real(kind=8) :: a,b,w1,w2,error
  real(kind=8) :: sum1
  real(kind=8) :: sum2
  real(kind=8), parameter :: thr1 = 2.5321317147938851d0
  ! when it is pi, use n = 100000000, get theoretical answer 2.5321317147938851d0
  real(kind=8), parameter :: thr2 = 2.4522838556713853d0
  ! when it is pi*pi, use n = 100000000, get theoretical answer 2.4522838556713853d0
  real(kind = 8), parameter :: pi = 3.1415926535897932d0 
  !integer, parameter :: n=10
  integer :: k
  !real(kind=8), dimension(n) :: x
  


  do n=2,100000
     allocate(x(1:n))
     a=-1.d0
     b=1.d0
     sum1 = 0.0d0
     sum2 = 0.0d0
  x = linspace(a,b,n)
  h=(b-a)/(n-1)

  !write(*,*) "x = ", shape(x)

  !write(*,*) "Number of Divisions =  ", n
  do k = 2,n-1
     w1 = exp(cos(pi*x(k)))
     w2 = exp(cos(pi*pi*x(k)))
     sum1 = sum1 + w1
     sum2 = sum2 + w2
  enddo
 
  sum1 = h* ((exp(cos(pi*x(1))) + exp(cos(pi*x(n)))) / 2.d0 + sum1)
  sum2 = h * ((exp(cos(pi*pi*x(1))) + exp(cos(pi*pi*x(n)))) / 2.d0 + sum2)
  !print *, sum1,sum2
  !error = abs(thr1 - sum1)
  error = abs(thr2 - sum2)
  print*, n, error
  if (error <= 1.0d-10) exit
  deallocate(x)
enddo

  
end program Trapezoidal

! This is the function linspace which is given by Professor.
function linspace(a,b,n)
  real(kind=8), intent(in) :: a,b
  integer, intent(in) :: n
  real(kind=8) :: linspace(n)
  real(kind=8) :: h
  integer :: i
  h=(b-a)/(n-1)
  !print *,h
  linspace=a+h*(/(i,i=0,n-1)/)
end function linspace

