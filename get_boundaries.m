function [all_boxes, all_boundaries] = get_boundaries(movie_tif, buffer,level)
%get the boundary boxes and boundaries for all images in a movie
%the boundary box is offset from the edge of the boundaries by an offset
%'buffer'

numframes = size(movie_tif,4);

fig = uifigure;
d = uiprogressdlg(fig,'Title','Please Wait',...
        'Message','Computing Boundaries');
    
for k = 1:numframes
    BW = image_thresh(movie_tif(:,:,k),level);
    [all_boxes{k}, all_boundaries{k}] = object_finder(BW, buffer);
    d.Value = k/numframes;
end

close(d)
close(fig)