program hwk4
  use xycoord   !use the module xycoord to set the mapping 
  implicit none
  integer :: nr,ns,i,j
  real(kind = 8) :: hr,hs
  real(kind = 8), dimension(:), allocatable :: r,s
  real(kind = 8), dimension(:,:), allocatable :: u,ur,us
  
  real(kind = 8), dimension(:,:), allocatable :: xc,yc

  nr = 30
  ns = 60
  
  ! Allocate memory for various arrays
  allocate(r(0:nr),s(0:ns),u(0:nr,0:ns),ur(0:nr,0:ns),us(0:nr,0:ns))
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
        u(i,j) = sin(r(i))*cos(s(j))
     end do
  end do
  
  ! Differentiate in the r-direction
  do i = 0,ns
     call differentiate(u(0:nr,i),ur(0:nr,i),hr,nr)
  end do
  
  ! Differentiate in the s-direction
  do i = 0,nr
     call differentiate(u(i,0:ns),us(i,0:ns),hs,ns)
  end do

end program hwk4
