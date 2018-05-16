function is_in=is_in_det_j(tree_del,cur_data_raw_j)
    bx=cur_data_raw_j(3);
    by=cur_data_raw_j(4);
    bw=cur_data_raw_j(5);
    bh=cur_data_raw_j(6);
    ISall=[tree_del{4}(end) tree_del{5}(end) ];
    if  ISall(1)>bx & ISall(2)>by & ...
                    ISall(1)<bx+bw & ...
                    ISall(2)<by+bh & tree_del{14}(end)>0.1 &tree_del{14}(1)>0.1
                is_in=1;
    else
        is_in=0;
    end
                
                

end