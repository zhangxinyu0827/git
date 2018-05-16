%% % del
    sr_tree=tree_table{1};
    sr_tree_len=size(sr_tree,2);
    all_s=[];
    for sr_tree_i=1:sr_tree_len
        cur_bra=sr_tree{sr_tree_i};%当前分支
      
        %为当前分支打分
    %ID switch记录了准换了多少次
    id_s=length( find(diff(cur_bra{1})));%1*1,记录转换次数
    Lab_s=std([cur_bra{6}' cur_bra{7}' cur_bra{8}']);%1*3
    
    %相当于记录了加速度，有加速度说明位置变化明显
    x_dist_s=sum(abs(diff(diff(cur_bra{4}))));
    y_dist_s=sum(abs(diff(diff(cur_bra{5}))));
   
    %光流作为加分项
    flow_s=[sum(abs(cur_bra{9})) sum(abs(cur_bra{10}))];%1*2
    Lab_s=([sum(abs(cur_bra{6}-cur_bra{6}(1))) sum(abs(cur_bra{7}-cur_bra{7}(1))) ...
         sum(abs(cur_bra{8}-cur_bra{8}(1))) ]);%1*3  dist(lab,lab_first) 
  
        
    id_s=id_s/length(cur_bra{1});
    Lab_s=Lab_s/(10*length(cur_bra{1}));
     flow_s=flow_s/(10*length(cur_bra{1}));
     x_dist_s=x_dist_s/length(cur_bra{1});
     y_dist_s=y_dist_s/length(cur_bra{1});
     fore_sc=sum(cur_bra{14})/length(cur_bra{1});
    all_s_i=[id_s Lab_s  -flow_s x_dist_s y_dist_s  -fore_sc ];%last fore score
        
        all_s(sr_tree_i)=sum(all_s_i);
    end
    [tmp_val tmp_ind]=min(all_s);%min score is good
 
    tree_del=sr_tree{tmp_ind};
