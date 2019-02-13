subroutine differentiate(u,ux,h,n)
  implicit none
  integer, intent(in) :: n
  real(kind = 8), intent(in) :: u(0:n),h
  real(kind = 8), intent(out) :: ux(0:n)
  integer :: i,j
  real(kind = 8) :: diff_weights(1:3,1:3)
  
  ! Set up weights for a 3-point finite difference stencil
  ! In the interior we use a centered stencil
  diff_weights(1:3,1) = (/-0.5d0,0.d0,0.5d0/)
  ! To the left we use a biased stencil
  diff_weights(1:3,2) = (/-1.5d0,2.d0,-0.5d0/)
  ! To the right we use a biased stencil too
  diff_weights(1:3,3) = (/1.5d0,-2.d0,0.5d0/)
  ! scale by 1/h
  diff_weights = diff_weights/h
  
  ! Differentiate
  ! To the left is a special case
  ux(0) = 0.d0
  do j = 1,3
     ux(0) = ux(0) + diff_weights(j,2)*u(j-1)
  end do
  ! Now interior points
  do i = 1,n-1
     ux(i) = diff_weights(1,1)*u(i-1) &
          + diff_weights(2,1)*u(i) &
          + diff_weights(3,1)*u(i+1)
  end do
  ! Finally, special case to the right
  ux(n) = 0.d0
  do j = 1,3
     ux(n) = ux(n) + diff_weights(j,3)*u(n-(j-1))
  end do

end subroutine differentiate
