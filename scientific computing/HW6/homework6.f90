program hwk6
  !$ use omp_lib
  use xycoord   !use the module xycoord to set the mapping
  implicit none
  integer :: nr,ns,i,j,minGrid,eChks,l, mweak, timed_loops
  real(kind = 8) :: time1a,time2a
  real(kind = 8), dimension(:), allocatable :: timediff
  real(kind = 8) :: hr,hs, detMat, JacobianMax
  real(kind = 8), dimension(:), allocatable :: r,s,h_eff,errVal
  real(kind = 8), dimension(:,:), allocatable :: u,ur,us,ux,uy,w
  real(kind = 8), dimension(:,:), allocatable :: xc,yc,xr,yr,xs,ys,rx,sx,ry,sy,uxExact,uyExact,Jacobian,integrand

  timed_loops=16
  nr = 30
  ns = 60
  minGrid=30
  eChks=150-minGrid
  ! Allocate memory for various arrays
  allocate(r(0:nr),s(0:ns),u(0:nr,0:ns),ur(0:nr,0:ns),us(0:nr,0:ns))
  allocate(xc(0:nr,0:ns),yc(0:nr,0:ns),xr(0:nr,0:ns),yr(0:nr,0:ns))
  allocate(xs(0:nr,0:ns),ys(0:nr,0:ns),rx(0:nr,0:ns))
  allocate(sx(0:nr,0:ns),ry(0:nr,0:ns),sy(0:nr,0:ns))
  allocate(ux(0:nr,0:ns),uy(0:nr,0:ns),integrand(0:nr,0:ns),w(0:nr,0:ns))
  allocate(uxExact(0:nr,0:ns),uyExact(0:nr,0:ns),Jacobian(0:nr,0:ns))
  allocate(h_eff(0:eChks),errVal(0:eChks))
  allocate(timediff(0:timed_loops-1))

  !Sets up Cartesian Grid
  hr = 2.d0/dble(nr)
  hs = 2.d0/dble(ns)
  !$OMP PARALLEL SHARED(r,s,hr,hs) private(i)
  !$OMP SECTIONS
  !$OMP SECTION
  do i = 0,nr
     r(i) = -1.d0 + dble(i)*hr
  end do
  !$OMP SECTION
  do i = 0,ns
     s(i) = -1.d0 + dble(i)*hs
  end do
  !$OMP END SECTIONS
  !$OMP END PARALLEL

  !Obtains our coordinate values
  !$omp parallel do private(i,j)
  do j = 0,ns
     do i = 0,nr
        xc(i,j) = x_coord(r(i),s(j))
        yc(i,j) = y_coord(r(i),s(j))
     end do
  end do
  !$omp end parallel do

  !Saves the data in text files. 
  call  printdble2d(xc,nr,ns,'x.txt')
  call  printdble2d(yc,nr,ns,'y.txt')

  call setup(u,uxExact,uyExact,xc,yc,ns,nr)
  
  !$OMP PARALLEL shared(u,ur,xc,xr,yc,yr,xs,ys), private(i)
  !$OMP SECTIONS
  !$OMP SECTION
  ! Differentiate in the r-direction
  do i = 0,ns
     call differentiate(u(0:nr,i),ur(0:nr,i),hr,nr)
     call differentiate(xc(0:nr,i),xr(0:nr,i),hr,nr)
     call differentiate(yc(0:nr,i),yr(0:nr,i),hr,nr)
  end do
  !$OMP SECTION
  ! Differentiate in the s-direction
  do i = 0,nr
     call differentiate(u(i,0:ns),us(i,0:ns),hs,ns)
     call differentiate(xc(i,0:ns),xs(i,0:ns),hs,ns)
     call differentiate(yc(i,0:ns),ys(i,0:ns),hs,ns)
  end do
  !$OMP END SECTIONS 
  !$OMP END PARALLEL

  ! I need to leave this part serial because each value is needed for each other.
  ! Calcuates the values for rx, ry, sx, and sy using the determinant
  ! and adjacent values. Also store value for Jacobian.
  JacobianMax = 0d0
  do j = 0, ns
     do i = 0, nr
        detMat = (xr(i,j)*ys(i,j)) - (xs(i,j)*yr(i,j))
        Jacobian(i,j) = detMat
        if (Jacobian(i,j) > JacobianMax) then
           JacobianMax = Jacobian(i,j)
        end if
        rx(i,j) = ys(i,j)/detMat
        sx(i,j) = -(yr(i,j)/detMat)
        ry(i,j) = -(xs(i,j)/detMat)
        sy(i,j) = xr(i,j)/detMat
     end do
  end do

  ! Find the approximate values of ux and uy based on chain rule.
  !$omp parallel do private(i,j)
  do j = 0, ns
     do i = 0, nr
        ux(i,j) = ur(i,j)*rx(i,j) + us(i,j)*sx(i,j)
        uy(i,j) = ur(i,j)*ry(i,j) + us(i,j)*sy(i,j)
     end do
  end do
  !$omp end parallel do

  do l = 1,timed_loops
     !$ call omp_set_num_threads(l)
     !$ time1a = omp_get_wtime()
     !!!!! compute errorValues
     !$OMP PARALLEL DO PRIVATE(i)
     do i = 0,eChks
        h_eff(i)=0
       errVal(i)=0
       call computerError(i+minGrid,i+minGrid,i,h_eff,errVal,eChks)
    end do
    !$OMP END PARALLEL DO 
    !$ time2a = omp_get_wtime()
    !$ timediff(l-1)=time2a-time1a
 end do
 ! this wil print a file where the 1st entry corisponds to 1 thread the 2nd to 2 ...
 !$ call  printdble2d(timediff,timed_loops-1,0,'time.txt')
 call  printdble2d(h_eff,eChks,0,'h_eff.txt')
 call  printdble2d(errVal,eChks,0,'errVal.txt')
 print *, 'Past n=minGrid to maxgrid wrote h_eff.txt and errVal.txt'
 !$ print *, 'also wrote time.txt'

!!!!!!!!!!!!!!!!!!!!!!Strong Scaling: when we want to calculate n=20!!!!!!!!!!!!
  !! Srong scaling n=20
!$ eChks = 0
!$ do l = 1,timed_loops
!$   call omp_set_num_threads(l)
!$   time1a = omp_get_wtime()
!!!!! compute errorValues
     !$OMP PARALLEL DO PRIVATE(i)     
!$   do i = 0,eChks
!$     h_eff(i)=0
!$     errVal(i)=0
!$     call computerError(20,20,i,h_eff,errVal,eChks)
!$   end do
     !$OMP END PARALLEL DO 
!$ time2a = omp_get_wtime()
!$ timediff(l-1)=time2a-time1a
!$ end do
!!!!! this wil print a file where the 1st entry corisponds to 1 thread the 2nd to 2 ...
!$ call  printdble2d(timediff,timed_loops-1,0,'strong_small.txt')
!$ print *, 'Past n=20 wrote strong_small.txt'


!!!!!!!!!!!!!!!!!!!!!!Strong Scaling: when we want to calculate n=800!!!!!!!!!!! 
!$ eChks = 0
!$ do l = 1,timed_loops
     !$ call omp_set_num_threads(l)
     !$ time1a = omp_get_wtime()
!!!!!  compute errorValues
      !$OMP PARALLEL DO PRIVATE(i)
!$     do i = 0,eChks
!$        h_eff(i)=0
!$       errVal(i)=0
!$       call computerError(800,800,i,h_eff,errVal,eChks)
!$    end do
     !$OMP END PARALLEL DO 
!$    time2a = omp_get_wtime()
!$    timediff(l-1)=time2a-time1a
!$  end do
!!!!! this wil print a file where the 1st entry corisponds to 1 thread the 2nd to 2 ...
!$ call  printdble2d(timediff,timed_loops-1,0,'strong_large.txt')
!$ print *, 'Past n=800 wrote strong_large.txt'


!!!!!!!!!!!!!!!!!!!!!!!!Weak Scaling: when we have n=200!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!$ eChks = 0 
!$ do l = 1,timed_loops
!$   call omp_set_num_threads(l)
!$   time1a = omp_get_wtime()
!$   mweak = int(200*sqrt(l*1d0))
!!!!!     compute errorValues
    !$OMP PARALLEL DO PRIVATE(i)
!$     do i = 0,eChks
!$        h_eff(i)=0
!$        errVal(i)=0
!$       call computerError(mweak,mweak,i,h_eff,errVal,eChks)
!$    end do
    !$OMP END PARALLEL DO 
    !$ time2a = omp_get_wtime()
    !$ timediff(l-1)=time2a-time1a
!$ end do
!!!!!  this wil print a file where the 1st entry corisponds to 1 thread the 2nd to 2 ...
!$ call  printdble2d(timediff,timed_loops-1,0,'weak.txt')
!$ print *, 'Past n=200 wrote weak.txt'
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!


 
  deallocate(r,s,u,ur,us)
  deallocate(xc,yc,xr,yr)
  deallocate(xs,ys,rx)
  deallocate(sx,ry,sy)
  deallocate(ux,uy,integrand,w)
  deallocate(uxExact,uyExact,Jacobian)
  deallocate(h_eff,errVal)
print *, 'finnished successfully'
end program hwk6
