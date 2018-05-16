close all;
clear all,clc;

%%注意在切换数据级时，有一个参数对应的MOT和pets是不同的
% 注意有无选用appSel，有无选用三维数据在setOtherParameters
warning off;
addpath(genpath('external'));
%0805zxy
addpath(genpath('CLEAR'));
% for dddd=1:2
for training=1
setKalmanParameters;
setOtherParameters_16;
if training==0
other_param.seq = 'MOT_Challenge_test_16';
else
    other_param.seq = 'MOT_Challenge_train_16';
end
setPathVariables_16;


for dd=1:2
for i =[7:7]
% for i =[1:3 5:11]
    % set a null hypothesis likelihood
    adjustOtherParameters_16;
    tmp_max=0;
other_param.confscHeight = 0;
other_param.scForTrain = 0;

    other_param.confscTH = -0.3; 
    other_param.minDetScore = -0.5; 

% 注意我的方法和嘉慧的在这有差异
%         load_det;
 det=loadDet(det_input_path{i}, other_param);
  

%         other_param.minDetScore=30;

    track = MHT(det, kalman_param, other_param);

%     
    if  strcmp(other_param.seq,'MOT_Challenge_train_16')
        tmp_mat_file=det_input_path{i}(23:end);
        
    elseif strcmp(other_param.seq,'MOT_Challenge_test_16')
        tmp_mat_file=det_input_path{i}(22:end);

    end
    
%     save(tmp_mat_file, 'track');


%     save tracking output into image
%    load(tmp_mat_file);
     if  strcmp(other_param.seq,'MOT_Challenge_train_16')
    eval_CLEAR_16;
     end
    if tmp_max< metrics2d(12)
        write_txt
    end
%      visTracks(track, other_param, img_input_path{i}, img_output_path{i}, max(det.fr));
    %0731zxy看一个视频的结果
    zanting=1;
end
end
end



