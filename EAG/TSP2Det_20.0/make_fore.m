% %用差分进行背景建模

% 选取检测框外的超像素建立树（轨迹）
clear all,clc;
%设置参数
cur_data_all={'input/PETS09-S1L1';'input/PETS09-S1L2';'input/PETS09-S2L1';...
    'input/PETS09-S2L2';'input/PETS09-S2L3'};
lastFrame_all=[241 201 795 436 240];
for data_i= 1:5
    
    cur_data=cur_data_all{data_i};
% 0802zxy用于小规模调试
    firstFrame=1;
    lastFrame=lastFrame_all(data_i);
    % s1l1  241  201
    % s2 795 436 240


    set_para;
global g_para;
global sceneInfo;
firstFrame=g_para.firstFrame;
lastFrame=g_para.lastFrame;
i=1;
mkdir(['fore_im/' cur_data(7:end) ]);
for frame = firstFrame:lastFrame-1
    
     im= imread(sprintf(img_input_path, frame)); %% read an image
    if size(im,3) > 1,
        im = rgb2gray(im);
    end
    [height, width, nB] = size(im);
    %% Detection part
    if frame == 1
        continue;
    end
    if frame == 2,
        rgb = imread(sprintf(img_input_path, frame-1)); %% read an image
        %rgb = imread(strcat(video_path,'Cali_',num2str(frame+interval-1),'.png'));
        hsv = rgb2hsv(rgb);
        prev_img = hsv(:, :, 3);
        
        rgb = imread(sprintf(img_input_path, frame)); %% read an image
        hsv = rgb2hsv(rgb);
        cur_img = hsv(:, :, 3);
        
        diff_img_prev = abs(cur_img - prev_img);
        diff_thres1 = max(max(diff_img_prev))/10 ;
    else
        prev_img = cur_img;
        cur_img = next_img;
        diff_img_prev = diff_img_next;
        diff_thres1 = diff_thres2;
    end;
  
% read next image
    rgb = imread(sprintf(img_input_path, frame+1)); %% read an image
    %rgb = imread(strcat(video_path,'Cali_',num2str(frame+interval+1),'.png'));
    hsv = rgb2hsv(rgb);
    next_img = hsv(:, :, 3);
 % get the next differental image
    diff_img_next = abs(next_img - cur_img);
    diff_thres2 = max(max(diff_img_next))/10 ;
    diff_thres = diff_thres1 * diff_thres2;
    %============== Option 2:  product
    diff_img_bright_product = diff_img_prev .* diff_img_next ;
    %============== Option 3:  product & thresholding
    diff_img_bright = diff_img_prev .* (diff_img_bright_product>diff_thres);
    new_img = diff_img_bright;
 new_img(new_img>0)=1;
        imwrite(new_img, ['fore_im/' cur_data(7:end)  sprintf('/%0.6d', frame) '.jpg']); %%write the output image  
 
        
      
 
end
end
