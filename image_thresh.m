function [threshold_image] = image_thresh(image, level)
%This function is to threshold the image of the intenstine.  It may well be
%able to be replaced by a single line command, but we shall see. Image
%should be grayscale

%level = graythresh(image); %get threshold value
%level=0.57; %for temp subsetting
BW_image = imbinarize(image, level);  %perform simple threshold.  
threshold_image = bwareafilt(BW_image, 1);

end