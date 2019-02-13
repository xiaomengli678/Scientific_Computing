subroutine x_manip(x,z)
implicit none
integer :: i,j
integer, intent(in) :: z
integer :: x(0:z,0:z)
do i=0,z
do j=0,z
x(i,j)=x(i,j)-1
end do
end do

end subroutine x_manip
