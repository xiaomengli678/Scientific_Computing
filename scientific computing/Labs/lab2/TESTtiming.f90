! Timing in Fortran using the built-in cpu_time subroutine
program timings

    implicit none
    integer, parameter :: ntests = 20  ! no. of runs
    integer :: n   ! the size of square matrices (n x n)
    real(kind=8), allocatable, dimension(:,:) :: a,b,c
    real(kind=8) :: t1, t2, elapsed_time
    integer :: i,j,k,itest

    print *, "Multiply n by n matrices, input n: "
    read *, n

    allocate(a(n,n), b(n,n), c(n,n))

    ! fill a and b with 1's and 2's just for demo purposes:
    a = 1.d0
    b = 2.d0

    call cpu_time(t1)   ! start cpu timer
    do itest=1,ntests
        do j = 1,n
            do i = 1,n
                c(i,j) = 0.d0
                do k=1,n
                    c(i,j) = c(i,j) + a(i,k)*b(k,j)
                enddo
            enddo
        enddo
    enddo

    call cpu_time(t2)   ! end cpu timer
    
    elapsed_time = t2-t1
        
    print 10, ntests, elapsed_time
 10 format("Performed ",i4, " matrix multiplications: CPU time = ",f12.8, " seconds")

    deallocate(a,b,c)
    
end program timings
