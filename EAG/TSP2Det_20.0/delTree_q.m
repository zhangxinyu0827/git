function tree_table_del=delTree_q(tree_table)

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
        if tree_i{t_i_i}{1}(1)~=tsp_label | tree_i{t_i_i}{3}(1)~=tsp_fre
            tsp_label=tree_i{t_i_i}{1}(1);
            tsp_fre=tree_i{t_i_i}{3}(1);
            tree_table_del_i=tree_table_del_i+1;    
%             对相同根节点的记录进行删减
         [tree_table_del{tree_table_del_i} score_i]=GetDel1(sr_tree);
            tree_table_del_s(tree_table_del_i)=score_i;
%             清空重新开始
            sr_tree_i=0;%记录具有相同根节点的记录的数量
            sr_tree=[];
            sr_tree_i=sr_tree_i+1;
            sr_tree{sr_tree_i}=tree_i{t_i_i};
        else
            sr_tree_i=sr_tree_i+1;
            sr_tree{sr_tree_i}=tree_i{t_i_i};
        end
        
    end
    
    
end
tree_table_del_q=tree_table_del;
% save tree_table_del_q tree_table_del_q;

if g_para.is_mot
save ([g_para.cur_data(23:end) '-tree_table_del_q.mat'], 'tree_table_del_q','-V7.3');
else
  save ([g_para.cur_data(7:end) '-tree_table_del_q.mat'], 'tree_table_del_q','-V7.3');

end

% % save ([g_para.cur_data(7:end) '-tree_table_del_q.mat'], 'tree_table_del_q');


end
