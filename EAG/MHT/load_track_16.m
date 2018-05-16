
if strcmp(other_param.seq,'MOT_Challenge_train_16')
        trak_file=['output/' img_input_path{1,i}(19:end-14) '.txt'];
% trak_file=[img_input_path{i}(1:end-13) 'gt/gt.txt'];
 elseif strcmp(other_param.seq,'MOT_Challenge_test_16')
        trak_file=['output/' img_input_path{1,i}(18:end-14) '.txt'];
% trak_file=[img_input_path{i}(1:end-13) 'gt/gt.txt'];

end

det_raw=dlmread(trak_file);
% det_raw=det_raw(find(det_raw(:,8)==1),:);
track.fr=det_raw(:,1);
track.id=det_raw(:,2);
track.x_hat=det_raw(:,3); 
track.y_hat  =det_raw(:,4);
track.w  =det_raw(:,5);
track.h=det_raw(:,6);

track.x=det_raw(:,3)+track.w; 
track.y  =det_raw(:,4)+track.h;


det.fr=track.fr;

