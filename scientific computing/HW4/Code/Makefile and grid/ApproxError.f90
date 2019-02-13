subroutine ApproxError(ux,uy,ux_exact,uy_exact,f)
  implicit none
  integer :: nx,ny
  real(kind = 8), intent(in) :: ux,uy,ux_exact,uy_exact 
  real(kind = 8), intent(out) :: f
  f = ux + uy - ux_exact - uy_exact 
  
end subroutine  ApproxError
