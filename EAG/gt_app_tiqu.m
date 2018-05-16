%for LIBAO main function
%by  Xinyu  Zhang , 20180116

%xinyu.zhang@buaa.edu.cn

%before use this please run installSegTracker.m,  installs all necessary dependencies
clear all,clc;
set_chushi;

test_seq_flag=16
    set_canshu;   
    for seq_i=test_seq
        set_canshu_i
        seqData.inputDetections=[seqData.inputDetections(1:26) 'gt/gt.txt'];
% 
%         get_det_img_main(seqData,img_file137,seq_i);
%         REID_MAIN_0116(img_file137,other_param);

        write_mat_main_gt(img_file137,seq_i,seqData,seqDirs);
       

    end

%