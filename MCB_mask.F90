module MCB_mask
use netcdf
use shr_kind_mod,   only: r8=>shr_kind_r8
use ppgrid,         only: pcols
use phys_grid,      only: get_lon_all_p, get_lat_all_p
use pmgrid,     only : plon, plat

implicit none
private
save

public :: read_MCB_mask, get_MCB_mask

character(len=*), parameter :: mask_file = '/glade/work/walkerl/MCB_masks/mask_ENSO_JJASONDJF_off_on.nc'
real(r8), save :: mask2D(plon, plat, 12, 2)

contains

subroutine read_MCB_mask
       implicit none
  
       integer :: ncid, varid, status
       
       status = nf90_open(mask_file, nf90_nowrite, ncid)
       status = nf90_inq_varid(ncid, 'mask', varid)
       status = nf90_get_var(ncid, varid, mask2D)
       status = nf90_close(ncid)
end subroutine read_MCB_mask

!++ MCB namelist
!subroutine get_MCB_mask(lchnk, ncol, mask)
subroutine get_MCB_mask(lchnk, ncol, mask, MCB_seeding_amt)
!-- MCB namelist
       use time_manager,       only: get_curr_date
       use cam_history,        only: outfld

       integer, intent(in) :: lchnk
       integer, intent(in) :: ncol
!++ MCB namelist
       real(r8), intent(in) :: MCB_seeding_amt
!-- MCB namelist
       real(r8), intent(out) :: mask(pcols)

       integer :: yr, mon, day, ncsec, i
       integer :: lons(pcols), lats(pcols)
!++ MCB namelist
       integer :: amt_id ! this is the index of the 4-D mask to select
!-- MCB namelist

       mask = 0._r8
       call get_curr_date(yr, mon, day, ncsec)

       call get_lon_all_p(lchnk,ncol,lons)
       call get_lat_all_p(lchnk,ncol,lats)      

       do i=1,ncol
!++ MCB namelist
          !mask(i) = mask2D(lons(i), lats(i), mon)
          amt_id = MCB_seeding_amt + 1
          mask(i) = mask2D(lons(i), lats(i), mon, amt_id)
!-- MCB namelist
       end do
      
       call outfld('MCB_mask', mask, pcols, lchnk) 

end subroutine get_MCB_mask

end module MCB_mask
