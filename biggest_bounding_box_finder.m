%find the biggest bounding box
%function [min_row, max_row, min_col, max_col] = biggest_bounding_box(file)
file = 'F:\Projects\Sonia_Spitzer\141220_WT_control_II-50_frames.tif';

movie_tif = Movie_import(file);

%find a bounding box for each tif file, and then find the sizes of edges of
%those

boundary_boxes =  [];

for k = 1:size(movie_tif,4)
    BW = image_thresh(movie_tif(:,:,k));
    [bounding_box, boundary] = object_finder(BW, 10);
    boundary_boxes(k,1) = min(bounding_box(:,1));
    boundary_boxes(k,2) = max(bounding_box(:,1));
    boundary_boxes(k,3) = min(bounding_box(:,2));
    boundary_boxes(k,4) = max(bounding_box(:,2));
end

min_row = min(boundary_boxes(:,1));
max_row = max(boundary_boxes(:,2));
min_col = min(boundary_boxes(:,3));
max_col = max(boundary_boxes(:,4));

%end
