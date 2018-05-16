function REID_MAIN_0116(img_file137,other_param)
net=ss_reid_init();


batch=other_param.use_ss_reid_batch;
% 02723248 test
% 01758659 train
id=1;
 all_score=[];
 dir_output=dir(img_file137);

 im_det_num=length(dir_output)-2;
 
 
 
for i=1:batch:im_det_num
   if mod(i,10000)==1 && i>1
            save ([img_file137 '/det137_train_' num2str(id) '.mat'], 'all_score','-V7.3');
         id=id+1
       
         all_score=[];
   end  
     tmp_j=1;
    for j=i:min(i+batch-1,im_det_num)
        
        imFile_tmp=sprintf('/%08d.jpg',j);
        imFile=[img_file137 imFile_tmp];
        im_all{tmp_j}=imread(imFile);
        tmp_j=tmp_j+1;
       
    end
    j
     score_tmp=ss_reid(im_all,net,other_param);
    all_score=[all_score score_tmp];
    
     if mod(i,10000)==0
    
     end   
end
         
  save ([img_file137 '/det137_train_' num2str(id) '.mat'], 'all_score','-V7.3');  




       
  
ss_reid_del;