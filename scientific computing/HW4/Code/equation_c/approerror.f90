subroutine approerror(ux,uy,uxex,uyex,nr,ns,hr,hs,J1,sum2,maxerror)
 !The subroutine to compute error. 
  implicit none
  integer,  intent(in) :: nr,ns
  integer :: i,j
  real(kind = 8), intent(in) :: hr,hs
  real(kind = 8), intent(out) :: sum2,maxerror
  ! this is the term computed after trapezoidal rule
  real(kind = 8), intent(in)  :: ux(0:nr,0:ns),uy(0:nr,0:ns),uxex(0:nr,0:ns),uyex(0:nr,0:ns),J1(0:nr,0:ns)
  real(kind = 8), dimension(:,:), allocatable :: e2
  ! the is the matrix which comes from ux + uy - uexactx - uexacty
  e2 = ux+uy -uxex-uyex 


  ! First take the square of every element
 
   
  
  !same J(r,s)
  !e2 = e2 * e2
  e2 = e2 * J1
  e2 = e2 * e2
  e2 = sqrt(e2)
  maxerror = maxval(e2)
  
  
  
  !trapezoidal rule
  sum2 = 0.d0
  sum2 = sum2+(hr*hs/4.d0) * (e2(0,0)+e2(0,ns)+e2(nr,0)+e2(nr,ns))
  
  do j = 1,(ns-1)
     sum2 = sum2+(hr*hs/2.d0)*(e2(0,j)+e2(nr,j))
  end do
  
  do i = 1,(nr-1)
     sum2 = sum2+(hr*hs/2.d0)*(e2(i,0)+e2(i,ns))
  end do

   do j = 1,(ns-1)
      do i = 1,(nr-1)
         sum2 = sum2+hr*hs*e2(i,j)
      end do
   end do
   
  !sum2 = sqrt(sum2)
   ! square root at last
   
   deallocate(e2)
end subroutine approerror
