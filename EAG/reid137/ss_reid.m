function all_score=ss_reid(im_all,net,other_param)
%实时reid特征提取
all_score=[];
CROPPED_DIM_H = 144;
CROPPED_DIM_W = 56;
% fprintf('dummy %d \n',length(im_all));
  batch = ceil(length(im_all)/ other_param.use_ss_reid_batch);
  input_data= zeros([ CROPPED_DIM_W, CROPPED_DIM_H,3, other_param.use_ss_reid_batch ] , 'single');
  for i=1:batch
      for j=1:other_param.use_ss_reid_batch
          if (i-1)*other_param.use_ss_reid_batch+j<length(im_all)+1
            input_data(:,:,:,j) = prepare_image(im_all{(i-1)*other_param.use_ss_reid_batch+j});     
          else
                input_data(:,:,:,j) = prepare_image(im_all{end});  
        
          end
      end
      net.forward({input_data});
      scores=net.blobs('fc7_bn').get_data();%获得某一层的数据
      all_score=[all_score scores];
  end

end


