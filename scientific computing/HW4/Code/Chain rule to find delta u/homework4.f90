program hwk4
  use xycoord   !use the module xycoord to set the mapping 
  implicit none
  integer, parameter :: q = 30
  integer :: nr,ns,i,j,p
  real(kind = 8) :: hr,hs,sum1,sum2,heff
  real(kind = 8), dimension(:), allocatable :: r,s
  real(kind = 8), dimension(:,:), allocatable :: u,ur,us
  real(kind = 8), dimension(:,:), allocatable :: xr,yr,xs,ys
  real(kind = 8), dimension(:,:), allocatable :: rx,ry,sx,sy,tmp1,tmp2,tmp3,J1
  real(kind = 8), dimension(:,:), allocatable :: xc,yc,ux,uy,uxx,uyy,uxr,uxs,uyr,uys
  real(kind = 8), dimension(:,:), allocatable :: uxex,uyex,e2,delta

  do p = 1,q
     nr = 2*p
     ns = 4*p
  
  
  sum1 = 0.d0
  
  ! Allocate memory for various arrays
  allocate(r(0:nr),s(0:ns),u(0:nr,0:ns),ur(0:nr,0:ns),us(0:nr,0:ns))
  allocate(xr(0:nr,0:ns),xs(0:nr,0:ns),yr(0:nr,0:ns),ys(0:nr,0:ns))
  allocate(rx(0:nr,0:ns),sx(0:nr,0:ns),ry(0:nr,0:ns),sy(0:nr,0:ns),J1(0:nr,0:ns))
  allocate(tmp1(1:2,1:2),tmp2(1:2,1:2),tmp3(1:2,1:2))
  allocate(xc(0:nr,0:ns),yc(0:nr,0:ns),ux(0:nr,0:ns),uy(0:nr,0:ns))
  allocate(uxex(0:nr,0:ns),uyex(0:nr,0:ns),e2(0:nr,0:ns),delta(0:nr,0:ns))
  allocate(uxx(0:nr,0:ns),uyy(0:nr,0:ns),uxr(0:nr,0:ns),uxs(0:nr,0:ns),uyr(0:nr,0:ns),uys(0:nr,0:ns))

 
 !!!!!!!!!!!!!!!Find the points' coordinates on the reference plane!!!!!!!!!!!!!!!!!!!!!
  hr = 2.d0/dble(nr)
  hs = 2.d0/dble(ns)
  do i = 0,nr
     r(i) = -1.d0 + dble(i)*hr
  end do
  do i = 0,ns
     s(i) = -1.d0 + dble(i)*hs
  end do
  
!!!!!!!!!!!!!!!Find the points'  coordinates on the real plane (Mapping them in a way we like)!!!!!!!!!!!!!!!!!!!!!
  do j = 0,ns
     do i = 0,nr
        xc(i,j) = x_coord(r(i),s(j))
        yc(i,j) = y_coord(r(i),s(j))
     end do
  end do
  
 !!!!!!!!!!!!!!!Print the points'  coordinates on the matlab figure!!!!!!!!!!!!!!!!!!!!!
  call  printdble2d(xc,nr,ns,'x.txt')
  call  printdble2d(yc,nr,ns,'y.txt')

  !!!!!!!!!!!!!!Find u(i,j) through r and s. This part is also defined by ourselves!!!!!!!!!!!!!!!
  do j = 0,ns
     do i = 0,nr
        u(i,j) = r(i) + s(j)
     end do
  end do
  
  !!!
  ! Differentiate in the r-direction in order to get ur
  do i = 0,ns
     call differentiate(u(0:nr,i),ur(0:nr,i),hr,nr)
  end do
  
  ! Differentiate in the s-direction in order to get us
  do i = 0,nr
     call differentiate(u(i,0:ns),us(i,0:ns),hs,ns)
  end do
!!!
  
  ! Differentiate in the r-direction in order to get xr and yr
  do i = 0,ns 
     call differentiate(xc(0:nr,i),xr(0:nr,i),hr,nr)
  end do
   do i = 0,ns
     call differentiate(yc(0:nr,i),yr(0:nr,i),hr,nr)
  end do
  
  ! Differentiate in the s-direction in order to get xs and ys
  do i = 0,nr
     call differentiate(xc(i,0:ns),xs(i,0:ns),hs,ns)
  end do
   do i = 0,nr
     call differentiate(yc(i,0:ns),ys(i,0:ns),hs,ns)
  end do

  ! Find out rx, ry, sx, sy
  do j = 0,ns
     do i = 0,nr
        !! temporarily put the four elements I want to find inverse matrix for in tmp1 - setp(1)
        tmp1(1,1) = xr(i,j)
        tmp1(2,1) = xs(i,j)
        tmp1(1,2) = yr(i,j)
        tmp1(2,2) = ys(i,j)
       !! temporarily put the four elements I want to find inverse matrix for in tmp2 - step(2)
        tmp2(1,1) = tmp1(2,2) 
        tmp2(2,1) = -tmp1(2,1)
        tmp2(1,2) = -tmp1(1,2)
        tmp2(2,2) = tmp1(1,1) 
        !!! Finding J(r,s) through 2 by 2 matrix inverse equation
        J1(i,j) =  tmp1(1,1)*tmp1(2,2) -  tmp1(1,2)* tmp1(2,1)
        !! temporarily put the four elements I want to use in tmp3- step(3)
        tmp3 = tmp2/(J1(i,j))
        !! formally return elements in tmp3 to rx, ry, sx, sy
        rx(i,j) =  tmp3(1,1)
        ry(i,j) =  tmp3(2,1)
        sx(i,j) =  tmp3(1,2)
        sy(i,j) =  tmp3(2,2)
     end do
  end do

  !trapezoidal rule
  !!!!!!! There are three parts: four corners, four boundary lines and the rest in the center area
  u = u*J1
  !!!!!!! Ones on the four corners (1/4)
  sum1 = sum1 +  hr * hs /4.d0 * (u(0,0) + u(0,ns) + u(nr,0) + u(nr,ns))
  
  !!!!!!! Ones on the four boundary lines (1/2)
  do j = 1,(ns-1)
     sum1 = sum1 + hr * hs/2.d0 * (u(0,j) + u(nr,j))
  end do
  
  do i = 1,(nr-1)
     sum1 = sum1 + hr * hs/2.d0 * (u(j,0) + u(j,ns))
  end do
  
  !!!!!!! Ones in the center area (1)
   do j = 1,(ns-1)
      do i = 1,(nr-1)
         sum1 = sum1 + hr * hs * u(i,j)
      end do
   end do
   
  !!!!!!!! Use the formal equation to find ux, uy
    do j = 0,ns
     do i = 0,nr
        ux(i,j) = ur(i,j)*rx(i,j) + us(i,j)*sx(i,j)
        uy(i,j) = ur(i,j)*ry(i,j) + us(i,j)*sy(i,j) 
     end do
  end do
  
!!!!!!!!!!!!!!!!!!!!!!!!!!!!! Bring in ux in u's position to get uxx !!!!!!!!!!!!!!!!!!!!!!!!!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!! Bring in uy in u's position to get uyy !!!!!!!!!!!!!!!!!!!!!!!!!
  !!!!!!!!!!!!!!!!!! First find uxr, uyr, uxs, uys !!!!!!!!!!!!!!!!!!!!
  ! Differentiate in the r-direction
  do i = 0,ns 
     call differentiate(ux(0:nr,i),uxr(0:nr,i),hr,nr)
  end do
   do i = 0,ns
     call differentiate(uy(0:nr,i),uyr(0:nr,i),hr,nr)
  end do
  
  ! Differentiate in the s-direction
  do i = 0,nr
     call differentiate(ux(i,0:ns),uxs(i,0:ns),hs,ns)
  end do
   do i = 0,nr
     call differentiate(uy(i,0:ns),uys(i,0:ns),hs,ns)
  end do

!!!!!!!!!!!!!!!!!!!!!!!!!!!!! Use the standard equation to find uxx, uyy !!!!!!!!!!!!!!!!!!!!!!!!!
   do j = 0,ns
     do i = 0,nr
        uxx(i,j) = uxr(i,j)*rx(i,j) + uxs(i,j)*sx(i,j)
        uyy(i,j) = uyr(i,j)*ry(i,j) + uys(i,j)*sy(i,j) 
     end do
  end do
  delta = uxx + uyy
  
!Find exact values for ux, uy (This is the part defined by ourselves)
  do j = 0,ns
     do i = 0,nr
        uxex(i,j) = 1.d0
        uyex(i,j) = 1.d0 
     end do
  end do
  
  
  !!!!!!!! call the subroutine to get error !!!!!!!!!
  call ApproError(ux,uy,uxex,uyex,nr,ns,hr,hs,J1,sum2)
  heff = sqrt(hr * hs * maxval(J1))
  print *, heff, ',', sum2

  deallocate(r,s,u,ur,us)
  deallocate(xr,xs,yr,ys)
  deallocate(rx,sx,ry,sy,J1)
  deallocate(tmp1,tmp2,tmp3)
  deallocate(xc,yc,ux,uy)
  deallocate(uxex,uyex,e2,delta)
  deallocate(uxx,uyy,uxr,uxs,uyr,uys)
  
end do

end program hwk4
