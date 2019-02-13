subroutine sub1(a,b)
  implicit none
  real(kind = 8), intent(in)  :: a
  real(kind = 8), intent(out) :: b
  b =  exp(a)
end subroutine sub1
