subroutine x_creator(z)
implicit none
integer :: i,j
integer, intent(in) :: z
integer :: x(0:z,0:z)

do i=0,z
do j=0,z
x(i,j)=i+j
end do
end do
print *,"x_creator ", x
call x_manip(x,z)
print *,"after x_manip ", x

end subroutine x_creator
