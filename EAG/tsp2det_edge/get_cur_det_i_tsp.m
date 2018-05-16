function cur_det_i_tsp=get_cur_det_i_tsp(cur_data_raw_i,cur_isall)
    ISall=cur_isall;
    kk=cur_data_raw_i(1);
    bx=cur_data_raw_i(3);
    by=cur_data_raw_i(4);
    bw=cur_data_raw_i(5);
    bh=cur_data_raw_i(6);
    tmp__inside_ind=find( ISall(:,3)==kk& ...
                    ISall(:,4)>bx & ISall(:,5)>by & ...
                    ISall(:,4)<bx+bw & ...
                    ISall(:,5)<by+bh);
                cur_det_i_tsp=ISall(tmp__inside_ind,:);

end