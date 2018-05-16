close all;
clear all,clc;

%%注意在切换数据级时，有一个参数对应的MOT和pets是不同的
% 注意有无选用appSel，有无选用三维数据在setOtherParameters
warning off;
addpath(genpath('external'));
%0805zxy
addpath(genpath('CLEAR'));      
% for dddd=1:2
for training=[ 1 0 ]
    setKalmanParameters;
    setOtherParameters_16;
    if training==0
    other_param.seq = 'MOT_Challenge_test_16';
    else
        other_param.seq = 'MOT_Challenge_train_16';
    end
    setPathVariables_16;



    tmp_result_all=[];
    %for tmp_tsp_s=[0.05 0.1:0.1:1 2 3]
%     other_param.tsp_sc=0;
aa=[];bb=[];
    for i =[1:7]
        % set a null hypothesis likelihood
        adjustOtherParameters_16;
        tmp_max=0;
other_param.dummyNumberTH = 20;   
    % load detection
        load_det;
  
%         other_param.minDetScore=30;
% 注意我的方法和嘉慧的在这有差异,高度优化
% aa=[aa length(det.x)/max(det.fr)]
% bb=[bb sum(det.w.*det.h)/max(det.fr)]
% cc=bb./aa
% observation=det;
% setVariables;
% % bb=observation;
% %  [observation] = detectionHeightFilter(observation, other_param)
% writt_cur_det;
% 
        track = MHT(det, kalman_param, other_param);

    %     
        if  strcmp(other_param.seq,'MOT_Challenge_train_16')
            tmp_mat_file=det_input_path{i}(23:end);

        elseif strcmp(other_param.seq,'MOT_Challenge_test_16')
            tmp_mat_file=det_input_path{i}(22:end);

        end

        %save(tmp_mat_file, 'track');


    %     save tracking output into image
    %    load(tmp_mat_file);
         if  strcmp(other_param.seq,'MOT_Challenge_train_16')
            eval_CLEAR_16;
            result_mot=metrics2d(1:14);
            tmp_result_all=[tmp_result_all; result_mot];
           
         end
%         if tmp_max< metrics2d(12)
             write_txt
%         end
    %      visTracks(track, other_param, img_input_path{i}, img_output_path{i}, max(det.fr));
        %0731zxy看一个视频的结果
        zanting=1;
    end
    if  strcmp(other_param.seq,'MOT_Challenge_train_16')
        tmp_txt_name='res_mot16.txt';
        fid=fopen(tmp_txt_name,'a+');
        sum_res= sum(tmp_result_all);
        fprintf(fid,'%.1f,%.1f,%.2f,%d,%d,%d,%d,%d,%d,%d,%d,%.1f,%.1f,%.1f,\n\n',sum_res(1:14));
        gt=1.1041e+05;
        fp=sum_res(8);fn=sum_res(9);ids=sum_res(10);
        mota=1-(fp+fn+ids)/gt
        fprintf(fid,'%.6f\n\n',mota);
        fclose(fid);
        
    end
end
%end

% recall=(182250-87565)/182250



