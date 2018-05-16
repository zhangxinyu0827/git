function tree_table_del=delTree(tree_table)

global g_para;
tree_table_del=[];
tree_table_del_i=0;
for t_i=1:size(tree_table,2)
    tree_i=tree_table{t_i};
    tsp_label=tree_i{1}{1}(1);
    tsp_fre=tree_i{1}{3}(1);
    sr_tree_i=0;%记录具有相同根节点的记录的数量
    sr_tree=[];
    for t_i_i=1:size(tree_i,2)
%         对每个起始的根节点的树保留一棵
      
%         else
%% 统计
            sr_tree_i=sr_tree_i+1;
            sr_tree{sr_tree_i}=tree_i{t_i_i};
%         end
        
    end
    
    
end
%   if tree_i{t_i_i}{1}(1)~=tsp_label | tree_i{t_i_i}{3}(1)~=tsp_fre
%% del
            tsp_label=tree_i{t_i_i}{1}(1);
            tsp_fre=tree_i{t_i_i}{3}(1);
            tree_table_del_i=tree_table_del_i+1;    
%             对相同根节点的记录进行删减
            [tree_table_del{tree_table_del_i} score_i]=GetDel2(sr_tree);
            tree_table_del_s(tree_table_del_i)=score_i;
%             清空重新开始
            sr_tree_i=0;%记录具有相同根节点的记录的数量
            sr_tree=[];
            sr_tree_i=sr_tree_i+1;
            sr_tree{sr_tree_i}=tree_i{t_i_i};
% 
% [tree_table_del_s_val tree_table_del_s_ind]=sort(tree_table_del_s);
% for ii=1:floor(length(tree_table_del_s_val)*g_para.del_keep)
%     tree_table_del_tmp{ii}=tree_table_del{tree_table_del_s_ind(ii)};
% end
% tree_table_del=tree_table_del_tmp;
% save tree_table_del tree_table_del;


% if g_para.is_mot
%  save ([g_para.cur_data(23:end) '-tree_table_del.mat'], 'tree_table_del','-V7.3');
% else
%   save ([g_para.cur_data(7:end) '-tree_table_del.mat'], 'tree_table_del','-V7.3');
% 
% end
% save ([g_para.cur_data(7:end) '-tree_table_del.mat'], 'tree_table_del');


end