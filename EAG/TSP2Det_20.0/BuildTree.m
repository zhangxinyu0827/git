function tree_table_del=BuildTree(fore_TSP,ISall_all)
% 建立树，每50/45帧建立一个表，为了内存不溢出,还未实行
% load fore_TSP;
global g_para;
global sceneInfo;
fore_TSP_all=[];
for fore_TSP_i=1:length(fore_TSP)
   fore_TSP_all=[fore_TSP_all;fore_TSP{fore_TSP_i}];
end
% 去冗余
fore_TSP_all_keep=del_occ(fore_TSP_all(:,[1 3 14]));
fore_TSP_all=fore_TSP_all(fore_TSP_all_keep,:);
tree_table{1}=[];
tree_table_len_now=1;
fore_TSP_all_len=length(fore_TSP_all);
for fore_TSP_all_i=1:fore_TSP_all_len
%    tree_table_i_len_now= length(tree_table{tree_table_len_now});
% %    避免单个数组太大
%     if tree_table_i_len_now>10000
%         tree_table_len_now=tree_table_len_now+1;
%         tree_table{tree_table_len_now}=[];
%     end
if mod(fore_TSP_all_i,10)==1
fprintf('%d/%d\n',fore_TSP_all_i,fore_TSP_all_len)
end
    tree_table{1}=[];
    tree_table_i_len_now= length(tree_table{tree_table_len_now});
%     扩张
% 分别记录全部树表，当前分树表id，当前分树表中元素个数，所有漏检超像素，当前漏检超像素id
    tree_table=fore_TSP_all_i_ex(tree_table,tree_table_len_now,tree_table_i_len_now,fore_TSP_all,fore_TSP_all_i,ISall_all);
    tmp_del=  delTree(tree_table);
    tree_table_del{fore_TSP_all_i}=tmp_del{1};
    zanting=1;
    
end
% save tree_table tree_table;
% if g_para.is_mot
%    save ([g_para.cur_data(23:end) '-tree_table.mat'], 'tree_table','-V7.3');
% else
%     save ([g_para.cur_data(7:end) '-tree_table.mat'], 'tree_table','-V7.3');
% end

save ([sceneInfo.imgFolder sceneInfo.sequence '-tree_table_del.mat'], 'tree_table_del','-V7.3');

% % save ([g_para.cur_data(7:end) '-tree_table.mat'], 'tree_table');
end