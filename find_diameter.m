function diameter = find_diameter(min_col,max_col, boundary)
%find the diameter of the intenstine from the bounding box
%the diameter will be a number between zero and some max, in pixels.
%we can use the max of the 'red' rectangular bounding boxes to make an
%array size
%the difference between the top and bottom of the 'green' bounding box for 
%each pixel in the 'x' axis will be the diameter
%boundary is the green
%bounding box is red


%x_positions = unique(bounding_box(:,2)); %get the positions from the red box
x_positions = min_col:max_col;

for x = 1:length(x_positions) %run the positions over the green box
    edges = boundary(boundary(:,2)== x_positions(x));
    if ~isempty(edges)
        min_edge=min(edges);
        max_edge=max(edges);
        diameter(x) = max_edge - min_edge;
    else
        diameter(x)=0;
    end
end
 
end