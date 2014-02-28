## Copyright (C) 2014 Phillip Nordwall
## 
## This program is free software; you can redistribute it and/or modify it
## under the terms of the GNU General Public License as published by
## the Free Software Foundation; either version 3 of the License, or
## (at your option) any later version.
## 
## This program is distributed in the hope that it will be useful,
## but WITHOUT ANY WARRANTY; without even the implied warranty of
## MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
## GNU General Public License for more details.
## 
## You should have received a copy of the GNU General Public License
## along with this program.  If not, see <http://www.gnu.org/licenses/>.

## -*- texinfo -*- 
## @deftypefn {Function File} {@var{ret_mat} =} frame_context (@var{mat_frames}
## , @var{boundary_frames})
##
## @seealso{}
## @end deftypefn

## Author: Phillip Nordwall <quest@den>
## Created: 2014-02-12

function [ret_mat] = frame_context (mat_frames, boundary_frames)
  [nRows, nCols] = size(mat_frames);
  
  % preinitialize the matrices to be the proper size and type
  tmpMat = zeros(nRows, nCols + 2*boundary_frames, class(mat_frames));
  ret_mat = zeros(2*boundary_frames*nRows+nRows, nCols, class(mat_frames));
  % initialize the non-zero tmpBat entries
  tmpMat(:,1+boundary_frames:end-boundary_frames) = mat_frames;
  cntr=boundary_frames*nRows;
  cntr_end=cntr+nRows;
  
  ret_mat(cntr+1:cntr+nRows,:) = ...
    tmpMat(:,boundary_frames+1:end-boundary_frames);
  for boundary = 1:boundary_frames
    offset=nRows*boundary;
    ret_mat(cntr+1-offset:cntr_end-offset,:) = ...
      shift(tmpMat,boundary,2)(:,boundary_frames+1:end-boundary_frames);
    ret_mat(cntr+1+offset:cntr_end+offset,:) = ...
      shift(tmpMat,-1*boundary,2)(:,boundary_frames+1:end-boundary_frames);
  endfor
endfunction

