program opt_test
integer x,y,nodes
do nodes=25,1,-1
call opt(x,y,nodes)
print *, "-------"
print *, "nodes=", nodes
print *, "x=", x
print *, "y=", y
end do
end program opt_test
