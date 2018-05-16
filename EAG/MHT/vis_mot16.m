addpath(genpath('external'));
%0805zxy
addpath(genpath('CLEAR'));
for training=[  1 0  ]
    setKalmanParameters;
    setOtherParameters_16;
    if training==0
    other_param.seq = 'MOT_Challenge_test_16';
    else
        other_param.seq = 'MOT_Challenge_train_16';
    end
    setPathVariables_16;
    if strcmp(other_param.seq,'MOT_Challenge_train_16')
    %     img_input_path{1,1}='input/2DMOT2015/train/ADL-Rundle-6/img1/%06d.jpg';
        for i=1:7
            
             img_output_path{1,i}=['vis_result/Mot16/train/' img_input_path{1,i}(19:end-14) '/'];
             if ~exist( img_output_path{1,i},'file')
                 mkdir( img_output_path{1,i});
             end

        end
    elseif strcmp(other_param.seq,'MOT_Challenge_test_16')
    %     img_input_path{1,1}='input/2DMOT2015/train/ADL-Rundle-6/img1/%06d.jpg';
        for i=1:7
           
             img_output_path{1,i}=['vis_result/Mot16/test/' img_input_path{1,i}(18:end-14) '/'];
             if ~exist( img_output_path{1,i},'file')
                 mkdir( img_output_path{1,i});
             end
        end
    end

    for i =[1:7]
        adjustOtherParameters_16;
        load_track_16;
        visTracks(track, other_param, img_input_path{i}, img_output_path{i}, max(det.fr)); 
    end
end


