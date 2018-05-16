setKalmanParameters;
setOtherParameters;
addpath(genpath('external'));
%0805zxy
addpath(genpath('CLEAR'));
for training =[  0]
    
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
             img_output_path{1,i}=['vis_result/Mot15/train/' img_output_path{1,i}(56:end-5) '/'];
             if ~exist( img_output_path{1,i},'file')
                 mkdir( img_output_path{1,i});
             end

        end
    elseif strcmp(other_param.seq,'MOT_Challenge_test')
    %     img_input_path{1,1}='input/2DMOT2015/train/ADL-Rundle-6/img1/%06d.jpg';
        for i=1:11
            img_input_path{1,i}=['input/' img_input_path{1,i}(56:end)];
             img_output_path{1,i}=['vis_result/Mot15/test/' img_output_path{1,i}(55:end-5) '/'];
             if ~exist( img_output_path{1,i},'file')
                 mkdir( img_output_path{1,i});
             end
        end

    end

    
    for i =[1:11]

        adjustOtherParameters;
       
        load_track_15;

        visTracks(track, other_param, img_input_path{i}, img_output_path{i}, max(det.fr));           
 
    end
end
   