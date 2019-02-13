subroutine opt(x,y,nodes)
  implicit none
  integer,intent(in) :: nodes
  integer,intent(out) :: x,y
  integer :: tmp
  do tmp=floor(sqrt(dble(nodes))),1,-1
    if (mod(nodes,tmp) == 0) then
      y=tmp
      x=nodes/tmp
      return
    end if
  end do
end subroutine opt
