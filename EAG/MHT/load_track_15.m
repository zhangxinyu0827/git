
if strcmp(other_param.seq,'MOT_Challenge_train')
        trak_file=['output/' img_input_path{1,i}(23:end-14) '.txt'];
 elseif strcmp(other_param.seq,'MOT_Challenge_test')
        trak_file=['output/' img_input_path{1,i}(22:end-14) '.txt'];
end

% trak_file='output/gt.txt';
det_raw=dlmread(trak_file);
track.fr=det_raw(:,1);
track.id=det_raw(:,2);
track.x_hat=det_raw(:,3); 
track.y_hat  =det_raw(:,4);
track.w  =det_raw(:,5);
track.h=det_raw(:,6);

track.x=det_raw(:,3)+track.w; 
track.y  =det_raw(:,4)+track.h;


det.fr=track.fr;

