%Sonia project walk through for movie, without the app functionality
%Late july, 2021. Last modified August 3, 2021
%August 20th, making the script run loopable so multiple movies can be run
%without restarting
close all
clear all
clc

%%

%%File list will be the list of all the files that are the movies.  They
%%need to be tif files seperated by commas. If you want to put them on
%%seperate lines, you can use the ',...' notation and put each movie on the
%%next line
movie_list = {'F:\Projects\Sonia_Spitzer\141220_WT_control_II.tif',...
                'F:\Projects\Sonia_Spitzer\141220_WT_highNaCl_II.tif'};

save_directory = 'C:\path_to_save_in';
%%
%Parameters for kymographing

buffer = 10; % number of pixels around the edge of the maximum extents of the object in question (here, an intenstine) that we keep as an image buffer.  They will show as black edge on the kymograph
                %the buffer will be the red box away from the green outline
                %of the intestine, if the images are shown on the screen

kymo_reduction = 16.7; %ratio that we downsample the original image for the kymograph. If the number is 10, then we block average every 10 pixels of the original kymograph and express them as a single value




%%Main loop

for k = 1:length(movie_list)
    close all
    movie_file = movie_list{k};  %load the movie file
    [file, number_frames] = Movie_import(movie_file);
    
    
    %%%Threshold setting%%%%%
    level = graythresh(file(:,:,1));
    %level = 0.52;
    %%%%%%%%%%%%%%%%%%%%%%%%%
    
    %%
    
    
    [all_boxes, all_boundaries] = get_boundaries(file, buffer,level);       %find the bounding boxes around the gut for each time point.  This is a custom function
    [min_row, max_row, min_col, max_col] = biggest_bounding_box(all_boxes); %find the maximum extent of the bounding boxes (i.e. whats the furthers points out in all directions that the intenstine reaches in the movie).

    num_cols = max_col-min_col;                                             %get the number of columns in the image that the instenstine reaches across.

    image_diameter = zeros(number_frames, num_cols+1);                      %there is one row per frame, across all columns of the image

    for k = 1:number_frames
        image_diameter(k,:) = find_diameter(min_col, max_col,all_boundaries{k});  %find the diameter of the intestine for each column in the image, and get that value. This will be expressed as a gray scale value in the kymo.
    end

    figure(1)
    imshow(image_diameter, []) %show the image
    
    fun=@(block_struct) mean(block_struct.data(:));
    Im_reduced = blockproc(image_diameter, [kymo_reduction,1], fun);        %makes a reduced kymograph depending on the ratio kymo_reduced.
    figure(2)
    imshow(Im_reduced, [])
    
    %make a block to check to see if the directory to save in exists, and
    %if so save the images there, if not, make the directory
   if ~exist(save_directory, 'dir')
       mkdir(save_directory)
   end
    
   %add a block to save the images with the kymo ratio at the end.
   %construct file names and save
  [filepath,name,ext] = fileparts(movie_file); %get file name and extension of movie of interest
  save_file_full= strcat(save_directory, filesep,name, '_full_kymo',ext);
  save_file_reduced_kymo=strcat(save_directory, filesep,name, '_',num2str(kymo_reduction),'_reduced_kymo',ext);
  save_file_csv = strcat(save_directory,filesep, name, '_full_table.csv');

    if max(max(image_diameter)) < 255
        kymo_full = uint8(image_diameter);
        kymo_small = uint8(Im_reduced);
    else
        kymo_full = uint16(image_diameter);
        kymo_small = uint16(Im_reduced);
    end

  
  imwrite(kymo_full,save_file_full);           %save the full kymograph
  imwrite(kymo_small, save_file_reduced_kymo);      %save the reduced kymograph
  writematrix(image_diameter,save_file_csv);        %save the diameter table.
  
    

end