function [bounding_box, boundary] = object_finder(image, buffer)
%This function is written to find the coordinates around the intenstine in
%Sonia Spitzers work, May 2021.  That is it's original purpose. --Todd,
%Calm Facility, Crick
%https://uk.mathworks.com/help/images/ref/bwboundaries.html#d123e27426
  %n =number of objects to keep
% BW = bwareafilt(image,1);
BW = image;
[B,L,N,A] = bwboundaries(BW); %get the boundaries of the object

%%B is the boundary, but we can make a new box around it, enclosing the
%%area

boundary = B{1};
% imshow(BW);
% hold on;
% plot(boundary(:,2), boundary(:,1),...
%      'g','LineWidth',2);
 
 
 
xmin = min(boundary(:,2)) - buffer;  %get the coordinates of the bounding box, and make it a bit wider than the original, by a set buffer
xmax = max(boundary(:,2)) + buffer;
ymin = min(boundary(:,1)) - buffer;
ymax = max(boundary(:,1)) + buffer;

h1 = [ymin:ymax]';  %h1 is the left short leg
h1(:,2) = xmin;

h2 = [ymin:ymax]'; %h2 is the right short leg
h2(:,2) = xmax;

w1(:,2) = [xmin:xmax]'; %w1 is top long leg
w1(:,1) = ymin;

w2(:,2) = [xmin:xmax]'; %w2 is bottom long leg
w2(:,1) = ymax;

bounding_box = [h1;w1;h2;w2];

%plot(bounding_box(:,2), bounding_box(:,1), 'r','LineWidth',2)
 
end
