% 0731zxy

seqs={'MOT16-02' 'MOT16-04' 'MOT16-05' 'MOT16-09' 'MOT16-10' 'MOT16-11' 'MOT16-13' ...
 'MOT16-01' 'MOT16-03' 'MOT16-06' 'MOT16-07' 'MOT16-08' 'MOT16-12' 'MOT16-14' };

if  strcmp(other_param.seq,'MOT_Challenge_train_16')


    for i=1:7
   
    img_input_path{1,i}=['input/MOT16/train/' seqs{i} '/img1/%06d.jpg'];
     det_input_path{i}=['input/mat_mot16/train/' seqs{i} '.mat'];
    %          img_output_path{1,i}=img_output_path{1,i}(27:end);
    %          if ~exist( img_output_path{1,i},'file')
    %              mkdir( img_output_path{1,i});
    %          end

    end
elseif strcmp(other_param.seq,'MOT_Challenge_test_16')

    for i=1:7
         img_input_path{1,i}=['input/MOT16/test/' seqs{i+7} '/img1/%06d.jpg'];
         det_input_path{i}=['input/mat_mot16/test/' seqs{i+7} '.mat'];
        %          img_output_path{1,i}=img_output_path{1,i}(27:end);
        %          if ~exist( img_output_path{1,i},'file')
        %              mkdir( img_output_path{1,i});
        %          end
    end

end