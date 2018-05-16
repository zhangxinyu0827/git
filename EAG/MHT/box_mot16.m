warning  off
  setOtherParameters_16;
for training =[ 0 1]
    
    if training==0
        other_param.seq = 'MOT_Challenge_test_16';
    else
        other_param.seq = 'MOT_Challenge_train_16';
    end
        
    setPathVariables_16;

    % 0731zxy
    if strcmp(other_param.seq,'PETS2009')  

    elseif strcmp(other_param.seq,'MOT_Challenge_train_16')
    %     img_input_path{1,1}='input/2DMOT2015/train/ADL-Rundle-6/img1/%06d.jpg';
        for i=1:7
           
             img_output_path{1,i}=['box_result/Mot16/train/' img_input_path{1,i}(19:end-14) '/'];
             if ~exist( img_output_path{1,i},'file')
                 mkdir( img_output_path{1,i});
             end

        end
    elseif strcmp(other_param.seq,'MOT_Challenge_test_16')
    %     img_input_path{1,1}='input/2DMOT2015/train/ADL-Rundle-6/img1/%06d.jpg';
        for i=1:7
           
             img_output_path{1,i}=['box_result/Mot16/test/' img_input_path{1,i}(18:end-14) '/'];
             if ~exist( img_output_path{1,i},'file')
                 mkdir( img_output_path{1,i});
             end
        end

    end
 for i =[1:7]

  
 
        load_det_box_15;
%         det = loadDet(det_input_path{i}, other_param);

%注意滤波，0.1
       print_box15_i; 
 
    end
end