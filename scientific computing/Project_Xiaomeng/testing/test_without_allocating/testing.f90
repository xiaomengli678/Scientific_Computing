subroutine testing(s,e)
implicit none
integer :: i
integer, intent(in) :: s, e(0:s)
do i=0,s
print *,"testing ",i, e(i)
call x_creator(e(i))
end do
end subroutine testing
