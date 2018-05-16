function last_tsp_now=getLast_tsp_now(tree_table_i)
for i=1:length(tree_table_i)
    last_tsp_now(i)=tree_table_i{i}(end);
end

end