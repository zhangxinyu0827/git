function crops_data = prepare_image(im)
% ------------------------------------------------------------------------
% caffe/matlab/+caffe/imagenet/ilsvrc_2012_mean.mat contains mean_data that
% is already in W x H x C with BGR channels
CROPPED_DIM_H = 144;
CROPPED_DIM_W = 56;

% Convert an image returned by Matlab's imread to im_data in caffe's data
% format: W x H x C with BGR channels
im_data = im(:, :, [3, 2, 1]);  % permute channels from RGB to BGR
im_data = permute(im_data, [2, 1, 3]);  % flip width and height
im_data = double(im_data);  % convert from uint8 to single
% im_data = imresize(im_data, [ CROPPED_DIM_W CROPPED_DIM_H], 'bilinear');  % resize im_data


% oversample (4 corners, center, and their x-axis flips)
crops_data = zeros([ CROPPED_DIM_W, CROPPED_DIM_H,3, 1] , 'double');
crops_data(:,:,:,1)=im_data;
%crops_data(:,:,:,2)=im_data;
end                        
