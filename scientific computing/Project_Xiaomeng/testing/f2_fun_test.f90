program f2_fun_test
  implicit none
  real(kind = 8) :: x(0:2)=(/1,2,3/), y(0:2)=(/4,5,6/), f2(0:2,0:2)
  real(kind = 8) :: w=10,kx=6,ky=4
  call f2_fun(f2,x,y,w,kx,ky,2,2)
  print *, f2
end program f2_fun_test

