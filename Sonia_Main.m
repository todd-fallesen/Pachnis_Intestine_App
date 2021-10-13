%Main script to call Functions for Sonia's project
clear all
clc



image_file = '141220_WT_control_II-1.tif';
I = imread(image_file);
I_gray = I;

I_thresh = image_thresh(I_gray);

BW=I_thresh;


[bounding_box, boundary] = object_finder(BW, 10);
imshow(BW)
hold on
plot(boundary(:,2), boundary(:,1), 'g', 'LineWidth', 2);
plot(bounding_box(:,2), bounding_box(:,1), 'r', 'LineWidth', 2);