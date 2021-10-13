%find the biggest bounding box
function [min_row, max_row, min_col, max_col] = biggest_bounding_box(all_boxes)

%Find the furthest extents of the bounding boxes for each frame in the
%movie, and then find the furthest extents of the bounding boxes over the
%entire movie. A bounding box with the corners at the extents found here
%will contain all bounding boxes.

boundary_boxes =  [];

for k = 1:length(all_boxes)
    boundary_boxes(k,1) = min(all_boxes{k}(:,1)); %min row for each box
    boundary_boxes(k,2) = max(all_boxes{k}(:,1)); %max row for each box
    boundary_boxes(k,3) = min(all_boxes{k}(:,2)); %min column for each box
    boundary_boxes(k,4) = max(all_boxes{k}(:,2)); %max column for each box
end

min_row = min(boundary_boxes(:,1)); %minimum of the minimum of rows 
max_row = max(boundary_boxes(:,2)); %max of the max of rows
min_col = min(boundary_boxes(:,3)); %min of the min of columns
max_col = max(boundary_boxes(:,4)); %max of the max of columns

end
