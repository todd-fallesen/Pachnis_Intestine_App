%Script to load movie
function [tif_movie, numframes] = Movie_import(filename)


info = imfinfo(filename);
numframes = length(info);
fig = uifigure;
d = uiprogressdlg(fig,'Title','Please Wait',...
        'Message','Opening the image');
for K = 1 : numframes
    tif_movie(:,:,:,K) = imread(filename, K);
    d.Value = K/numframes;
end

close(d)
close(fig)


end