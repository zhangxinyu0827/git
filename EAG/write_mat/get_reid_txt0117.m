function cnndata=get_reid_txt(reid_mat_f,start_i,end_i)
cnndata=[];

    
    reid_file_s=ceil(start_i/10000);
    reid_file_e=ceil(end_i/10000);
    for i=reid_file_s:reid_file_e
        load([reid_mat_f num2str(i) '.mat']);
      
        if i==reid_file_s         
             cnndata=[cnndata all_score(:,1:end)];
        elseif i==reid_file_e &  i~=reid_file_s                   
            cnndata=[cnndata all_score(:,1:end)];
        else
            cnndata=[cnndata all_score];
        end

    end
    
    

