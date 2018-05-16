function find_next=getNext(ISall_now,first_tsp_now,last_tsp_now)
% for lab,compute use [0,1],save old
find_next=[];
global g_para;
dist_thresh=g_para.dist_thresh;
Lab_dist_thresh=g_para.Lab_dist_thresh;
max_next=g_para.max_next;
dist_nearest=g_para.dist_nearest;
Lab_first=first_tsp_now(6:8);


% 用于标准化
Lab_tmp=[Lab_first ;ISall_now(:,6:8)];
Lab_tmp=(Lab_tmp - repmat(min(Lab_tmp),size(Lab_tmp,1),1)) ./ repmat(max(Lab_tmp)-min(Lab_tmp),size(Lab_tmp,1),1);
Lab_first=Lab_tmp(1,:);
% ISall_now(:,6:8)=Lab_tmp(2:end,:);
%1102zxy tmp cur lab
 Lab_tmp=Lab_tmp(2:end,:);
 
last_fre=last_tsp_now(3);
last_xy=last_tsp_now(4:5);
%寻找在下一帧的
keep_next_ind=find(ISall_now(:,3)==last_fre+1);
keep_next=ISall_now(keep_next_ind,:);

%1102zxy tmp cur lab
keep_next_lab=Lab_tmp(keep_next_ind,:);

%在下一帧中找距离的前几个
dist=sqrt((keep_next(:,4)-last_xy(1)).^2+(keep_next(:,5)-last_xy(2)).^2);
[d_val d_ind]=sort(dist);
if isempty(dist)
    return;
end
keep_d=keep_next(d_ind(1:dist_thresh),:);
% % Lab_all=[Lab_first;keep_d(:,6:8)];
% % %巧妙的运用了平铺技术实现了标准化，暂时不使用标准化
% % featmat=(featmat - repmat(min(featmat),size(featmat,1),1)) ./ repmat(max(featmat)-min(featmat),size(featmat,1),1);
% % 计算Lab距离
% Lab_dist_tmp=keep_d(:,6:8) - repmat(Lab_first,size(keep_d(:,6:8) ,1),1);
% Lab_dist=sqrt(sum(Lab_dist_tmp.^2,2));
% 
% keep_l_ind=find(Lab_dist<Lab_dist_thresh);
% %若没有小于阈值的，则取最小的
% if  isempty(keep_l_ind)
%     [tmp_null keep_l_ind]=min(Lab_dist);
% end
% if  ~isempty(keep_l_ind)
%     if length (keep_l_ind)>max_next
%         [tmp_null sort_ind]=sort(Lab_dist);
%         keep_l_ind=sort_ind(1:max_next);
%     end
% end
%   find_next=keep_d(keep_l_ind,:);
if g_para.is_Lab
        % 计算Lab距离
    Lab_dist_tmp=keep_next_lab - repmat(Lab_first,size(keep_next_lab ,1),1);
    Lab_dist=sqrt(sum(Lab_dist_tmp.^2,2));
        %LAB 距离和空间距离 的加权
    dist_p_L=g_para.Lab_pa*Lab_dist+(1-g_para.Lab_pa)*dist-...
        (keep_next(:,1)==first_tsp_now(1))-keep_next(:,14);

    [d_val d_ind]=sort(dist_p_L);
    keep_d=keep_next(d_ind(1:max_next),:);


% 
% %         %1124zxy LAB 距离 和光流的加权
% %计算光流
%     keep_next_flow=ISall_now(:,9:10);
%     Flow_dist_tmp=keep_next_flow - repmat(first_tsp_now(9:10),size(keep_next_flow ,1),1);
%     Flow_dist=sqrt(sum(Flow_dist_tmp.^2,2));

%     keep_dist=keep_next(d_ind(1:dist_nearest),:);
%     keep_dist_Lab=Lab_dist(d_ind(1:dist_nearest),:);
%     keep_dist_Flow=Flow_dist(d_ind(1:dist_nearest),:);
%     dist_F_L=g_para.Lab_pa*keep_dist_Lab+(1-g_para.Lab_pa)*keep_dist_Flow;
%     [d_val d_ind]=sort(dist_F_L);
%  keep_d=keep_dist(d_ind(1:max_next),:);
    
    find_next=keep_d;
else
    find_next=keep_d;
end


end