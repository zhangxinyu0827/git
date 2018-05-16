clear,clc;
net=ss_reid_init();

other_param.use_ss_reid_batch=10;
batch=other_param.use_ss_reid_batch;
% 02723248 test
% 01758659 train
id=1;
 all_score=[];
for i=1:batch:55558
   if mod(i,10000)==1 && i>1
            save (['mot16det137_train_' num2str(id) '.mat'], 'all_score','-V7.3');
         id=id+1
       
         all_score=[];
   end  
     tmp_j=1;
    for j=i:min(i+batch-1,55558)
        imFile=sprintf('mot16det137/train/%08d.jpg',j);
        im_all{tmp_j}=imread(imFile);
        tmp_j=tmp_j+1;
       
    end
    j
     score_tmp=ss_reid(im_all,net,other_param);
    all_score=[all_score score_tmp];
    
     if mod(i,10000)==0
    
     end   
end
         
  save (['mot16det137_train_' num2str(id) '.mat'], 'all_score','-V7.3');  




       
  
ss_reid_del;