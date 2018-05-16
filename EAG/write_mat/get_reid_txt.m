function cnndata=get_reid_txt(training,start_i,end_i)
cnndata=[];
if training==1
    
    reid_file_s=ceil(start_i/10000);
    reid_file_e=ceil(end_i/10000);
    for i=reid_file_s:reid_file_e
        load(['mot16/train/mot16det137_train_' num2str(i) '.mat']);
        if i==reid_file_s
            start_tmp=mod(start_i,10000);
            if start_tmp==0
                start_tmp=10000;
            end
             cnndata=[cnndata all_score(:,start_tmp:10000)];
        elseif i==reid_file_e
            end_tmp=mod(end_i,10000);
            if end_tmp==0
                end_tmp=10000;
            end
            cnndata=[cnndata all_score(:,1:end_tmp)];
        else
            cnndata=[cnndata all_score];
        end

    end
    
    
    
else
    
     reid_file_s=ceil(start_i/10000);
    reid_file_e=ceil(end_i/10000);
    for i=reid_file_s:reid_file_e
        load(['mot16/test/mot16det137_test_' num2str(i) '.mat']);
        if i==reid_file_s
            start_tmp=mod(start_i,10000);
            if start_tmp==0
                start_tmp=10000;
            end
             cnndata=[cnndata all_score(:,start_tmp:10000)];
        elseif i==reid_file_e
            end_tmp=mod(end_i,10000);
            if end_tmp==0
                end_tmp=10000;
            end
            cnndata=[cnndata all_score(:,1:end_tmp)];
        else
            cnndata=[cnndata all_score];
        end
    
    end
end