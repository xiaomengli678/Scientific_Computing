! Main program: main.f90
program main
  implicit none
  real(kind=8) :: a,b,c

  a = 1.d0
  call sub1(a,b)
  call sub2(a,b,c)
  print *, c
  
end program main 
