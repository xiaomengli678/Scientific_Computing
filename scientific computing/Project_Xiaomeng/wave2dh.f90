module wave2dh
  implicit none
  real(kind=8) :: t_, x_, y_, w_, kx_, ky_
  real(kind=8) :: tmp_(1)
  real(kind = 8) :: hx_, hy_
  integer :: nx_,ny_
save
contains
  subroutine u_exact(tmp_,t_,x_,y_,w_,kx_,ky_)
    implicit none
    real(kind=8) , intent(in) :: t_, x_, y_, w_, kx_, ky_
    real(kind=8) , intent(out) :: tmp_(1)
    tmp_=sin(w_*t_-kx_*x_)*sin(ky_*y_)
  end subroutine u_exact
  subroutine f2_fun(tmp_,x_,y_,w_,kx_,ky_)
    implicit none
    real(kind=8) , intent(in) :: x_, y_, w_, kx_, ky_
    real(kind=8) , intent(out) :: tmp_(1)
    tmp_=w_*cos(kx_*x_)*sin(ky_*y_)
  end subroutine f2_fun
  subroutine forcing(tmp_,t_,x_,y_,w_,kx_,ky_)
    implicit none
    real(kind=8) , intent(in) :: t_, x_, y_, w_, kx_, ky_
    real(kind=8) , intent(out) :: tmp_(1)
    tmp_=-(w_**2-kx_**2-ky_**2)*sin(w_*t_-kx_*x_)*sin(ky_*y_)
  end subroutine forcing
  subroutine laplac(L,u,hx_,hy_,nx_,ny_)
    implicit none
    integer :: j,i
    integer , intent(in) :: nx_,ny_
    real(kind = 8), intent(out) :: L(0:nx_,0:ny_)
    real(kind = 8), intent(in) :: u(0:nx_,0:ny_), hx_, hy_
    do j=1,ny_-1
      do i=1,nx_-1
        L(j,i)=(1d0/hx_**2)*u(j,i+1)+(1d0/hx_**2)*u(j,i-1)+(1d0/hy_**2)*u(j+1,i)
        L(j,i)=L(j,i)+(1d0/hy_**2)*u(j-1,i)-((2d0/hx_**2)+(2d0/hx_**2))*u(j,i)
      end do
    end do
  end subroutine laplac
end module wave2dh
