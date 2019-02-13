subroutine err_calc(s,NX_v)
  implicit none
  integer, intent(in) :: s, NX_v(0:s)
  real :: E(0:s), H(0:s)
  integer :: nx, ny, kk

  !!! loop through NX
  do kk=0,s
   nx=NX_v(kk)
   ny=nx
   print *,"testing ",kk, NX_v(kk)
   call wave2d(E,H,s,kk,nx,ny)
  end do
  print *,"H and E"

end subroutine err_calc
