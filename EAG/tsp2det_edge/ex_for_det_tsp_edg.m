 
%% % % %     ex
tree_table{1}=[];
tree_table_len_now=1;
tree_table{1}=[];
tree_table_i_len_now= length(tree_table{tree_table_len_now});
tree_table_i_len_now0=tree_table_i_len_now;
tree_table_i_len_now=tree_table_i_len_now+1;

% 记录当前首/尾节点信息
last_tsp_now= last_tsp_now;
first_tsp_now=last_tsp_now;
% 初始化
for i=1:length(last_tsp_now)
    tree_table{tree_table_len_now}{tree_table_i_len_now}{i}=last_tsp_now(i);
end

ex_i=1;ex_next=g_para.ex_next;
    while ex_i<ex_next
    %     ,每次扫描tree_table_i_len_now0到tree_table_i_len_now_i
    %     tree_table_i_len_now_i记录了在当前深度的最大下标数，
    % 在此次迭代中不进行加减，下次迭代时更新
        tree_table_i_len_now_i=tree_table_i_len_now;
        for scan_i=tree_table_i_len_now0+1:tree_table_i_len_now_i
            last_tsp_now=getLast_tsp_now(tree_table{tree_table_len_now}{scan_i});
            find_next=getNext_for_tsp_edge(ISall_now,first_tsp_now,last_tsp_now);
            % 根据找到的进行扩张,并更新tree_table_i_len_now
            if isempty(find_next)
                continue;
            end
            %如果找到大于一个，先增加后面的，为了计算方便
            for find_i=2:size(find_next,1)
              tree_table_i_len_now=tree_table_i_len_now+1;
              tree_table{tree_table_len_now}{tree_table_i_len_now}=tree_table{tree_table_len_now}{scan_i};
              for i=1:length(last_tsp_now)
                tree_table{tree_table_len_now}{tree_table_i_len_now}{i}=...
                    [tree_table{tree_table_len_now}{tree_table_i_len_now}{i} , find_next(find_i,i)];
              end
            end
            for i=1:length(last_tsp_now)
                tree_table{tree_table_len_now}{scan_i}{i}=...
                    [tree_table{tree_table_len_now}{scan_i}{i} , find_next(1,i)];
            end


        end

        ex_i=ex_i+1;
    end