close all;
clear all,clc;

%%注意在切换数据级时，有一个参数对应的MOT和pets是不同的
% 注意有无选用appSel，有无选用三维数据在setOtherParameters
warning off;
addpath(genpath('external'));
%0805zxy
addpath(genpath('CLEAR'));
setKalmanParameters;
setOtherParameters;
for training =[ 1 0]
    if training==0
        other_param.seq = 'MOT_Challenge_test';
    else
        other_param.seq = 'MOT_Challenge_train';
    end
        
setPathVariables;

% 0731zxy
if strcmp(other_param.seq,'PETS2009')  
  
elseif strcmp(other_param.seq,'MOT_Challenge_train')
%     img_input_path{1,1}='input/2DMOT2015/train/ADL-Rundle-6/img1/%06d.jpg';
    for i=1:11
        img_input_path{1,i}=['input/' img_input_path{1,i}(56:end)];
         img_output_path{1,i}=img_output_path{1,i}(27:end);
         if ~exist( img_output_path{1,i},'file')
             mkdir( img_output_path{1,i});
         end
       
    end
elseif strcmp(other_param.seq,'MOT_Challenge_test')
%     img_input_path{1,1}='input/2DMOT2015/train/ADL-Rundle-6/img1/%06d.jpg';
    for i=1:11
        img_input_path{1,i}=['input/' img_input_path{1,i}(56:end)];
         img_output_path{1,i}=img_output_path{1,i}(27:end);
         if ~exist( img_output_path{1,i},'file')
             mkdir( img_output_path{1,i});
         end
    end
        
    end

    tmp_result_all=[];
%    nmsThreshold=0.6;
    for i =[  1:11]
    % for i =[1:3 5:11]
        % set a null hypothesis likelihood
        adjustOtherParameters;
        other_param.dummyNumberTH = 20;   
         other_param.minDetScore=0.3';
        
        % load detections
%          det = loadDet(det_input_path{i}, other_param);
        load_det;
        % observation=det;
        % setVariables;
        % % bb=observation;
        % %  [observation] = detectionHeightFilter(observation, other_param)
        % writt_cur_det;

    % %     % run MHT
%     for min_det_score = 0:5:30
%             other_param.minDetScore=min_det_score;
        track = MHT(det, kalman_param, other_param);

    %     
        if strcmp(other_param.seq,'PETS2009')  
            tmp_mat_file=det_input_path{i}(16:end);
           tmp_seq_name= img_input_path{i}(7:17);
        elseif strcmp(other_param.seq,'MOT_Challenge_train')
            tmp_mat_file=det_input_path{i}(27:end);
            tmp_seq_name=tmp_mat_file(1:end-3);
        elseif strcmp(other_param.seq,'MOT_Challenge_test')
            tmp_mat_file=det_input_path{i}(26:end);
            tmp_seq_name=tmp_mat_file(1:end-3);
        end

%         save(tmp_mat_file, 'track');
        write_txt;

    %     save tracking output into image
%         load(tmp_mat_file);
        if  strcmp(other_param.seq,'MOT_Challenge_train')
            eval_CLEAR;

            result_mot=metrics2d(1:14);
            tmp_result_all=[tmp_result_all; result_mot];
        end

    %      visTracks(track, other_param, img_input_path{i}, img_output_path{i}, max(det.fr));
        %0731zxy看一个视频的结果
        zanting=1;
%     end
     end
     if  strcmp(other_param.seq,'MOT_Challenge_train')
        tmp_txt_name='res_mot.txt';
        fid=fopen(tmp_txt_name,'a+');
        tmp_seq_name='***********all*****';
%         fprintf(fid,'\n%s\n',  tmp_seq_name);
%         fprintf(fid,'\n%s\n',  'Rcll| Prcn|FAR||GT|MT|PT|ML||FP|FN|IDs|FM||MOTA|MOTP|MOYAL');
        sum_res= sum(tmp_result_all);
        fprintf(fid,'%.1f,%.1f,%.2f,%d,%d,%d,%d,%d,%d,%d,%d,%.1f,%.1f,%.1f,\n\n',sum_res(1:14));
        gt=43138;
        fp=sum_res(8);fn=sum_res(9);ids=sum_res(10);
        mota=1-(fp+fn+ids)/gt
        fprintf(fid,'%.6f\n\n',mota);
        fclose(fid);
 
   end
end

% eval_yuanban;
% recall= (61380-32547)/61380






