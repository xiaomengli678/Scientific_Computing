program hwk4
  use xycoord   !use the module xycoord to set the mapping 
  implicit none
  integer :: nr,ns,i,j
  real(kind = 8) :: hr,hs,sum1
  real(kind = 8), dimension(:), allocatable :: r,s
  real(kind = 8), dimension(:,:), allocatable :: u,ur,us
  real(kind = 8), dimension(:,:), allocatable :: xr,yr,xs,ys
  real(kind = 8), dimension(:,:), allocatable :: rx,ry,sx,sy,tmp1,tmp2,tmp3,J1
  real(kind = 8), dimension(:,:), allocatable :: xc,yc

  nr = 300
  ns = 600
  sum1 = 0.d0
  ! Allocate memory for various arrays
  allocate(r(0:nr),s(0:ns),u(0:nr,0:ns),ur(0:nr,0:ns),us(0:nr,0:ns))
  allocate(xr(0:nr,0:ns),xs(0:nr,0:ns),yr(0:nr,0:ns),ys(0:nr,0:ns))
  allocate(rx(0:nr,0:ns),sx(0:nr,0:ns),ry(0:nr,0:ns),sy(0:nr,0:ns),J1(0:nr,0:ns))
  allocate(tmp1(1:2,1:2),tmp2(1:2,1:2),tmp3(1:2,1:2))
  allocate(xc(0:nr,0:ns),yc(0:nr,0:ns))
  
  hr = 2.d0/dble(nr)
  hs = 2.d0/dble(ns)
  do i = 0,nr
     r(i) = -1.d0 + dble(i)*hr
  end do
  do i = 0,ns
     s(i) = -1.d0 + dble(i)*hs
  end do

  do j = 0,ns
     do i = 0,nr
        xc(i,j) = x_coord(r(i),s(j))
        yc(i,j) = y_coord(r(i),s(j))
     end do
  end do
  
  call  printdble2d(xc,nr,ns,'x.txt')
  call  printdble2d(yc,nr,ns,'y.txt')
  
  do j = 0,ns
     do i = 0,nr
        u(i,j) = r(i)*r(i) + s(j)*s(j)
     end do
  end do
  
  ! Differentiate in the r-direction
  do i = 0,ns 
     call differentiate(xc(0:nr,i),xr(0:nr,i),hr,nr)
  end do
   do i = 0,ns
     call differentiate(yc(0:nr,i),yr(0:nr,i),hr,nr)
  end do
  
  ! Differentiate in the s-direction
  do i = 0,nr
     call differentiate(xc(i,0:ns),xs(i,0:ns),hs,ns)
  end do
   do i = 0,nr
     call differentiate(yc(i,0:ns),ys(i,0:ns),hs,ns)
  end do

  ! Find out rx, ry, sx, sy
  do j = 0,ns
     do i = 0,nr
        tmp1(1,1) = xr(i,j)
        tmp1(2,1) = xs(i,j)
        tmp1(1,2) = yr(i,j)
        tmp1(2,2) = ys(i,j)

        tmp2(1,1) = tmp1(2,2) 
        tmp2(2,1) = -tmp1(2,1)
        tmp2(1,2) = -tmp1(1,2)
        tmp2(2,2) = tmp1(1,1) 

        J1(i,j) =  tmp1(1,1)*tmp1(2,2) -  tmp1(1,2)* tmp1(2,1)
        
        tmp3 = 1/(J1(i,j))*tmp2
        rx(i,j) =  tmp3(1,1)
        ry(i,j) =  tmp3(2,1)
        sx(i,j) =  tmp3(1,2)
        sy(i,j) =  tmp3(2,2)
     end do
  end do

  !trapezoidal rule
  u = u * J1
  sum1 = sum1 +  hr * hs /4.d0 * (u(0,0) + u(0,ns) + u(nr,0) + u(nr,ns))
  do j = 1,(ns-1)
     sum1 = sum1 + hr * hs/2.d0 * (u(0,j) + u(nr,j))
  end do
  
  do i = 1,(nr-1)
     sum1 = sum1 + hr * hs/2.d0 * (u(j,0) + u(j,ns))
  end do
 
   do j = 1,(ns-1)
      do i = 1,(nr-1)
         sum1 = sum1 + hr * hs * u(i,j)
      end do
   end do
  
   print *, sum1
         
end program hwk4
