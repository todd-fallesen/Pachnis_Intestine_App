function image_diameter = Make_kymo(numframes, min_col, max_col, all_boundaries)
%get the diameter of the guy across all columns in the image, using the min
%and max detected by the boundary detector.


num_cols = max_col-min_col;
fig = uifigure;
image_diameter = zeros(numframes, num_cols+1); %there is one row per frame, across all columns of the image
d = uiprogressdlg(fig,'Title','Please Wait',...
        'Message','Making the kymo');
for k = 1:numframes
    image_diameter(k,:) = find_diameter(min_col, max_col,all_boundaries{k});
    d.Value = k/numframes;
end

close(d)
close(fig)


end