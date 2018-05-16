%for LIBAO main function
%by  Xinyu  Zhang , 20180116

%xinyu.zhang@buaa.edu.cn

%before use this please run installSegTracker.m,  installs all necessary dependencies
clear all,clc;
set_chushi;

for test_seq_flag=[ 16 15.5 16.5]
    set_canshu;   
    for seq_i=test_seq
        set_canshu_i
         try
             movefile( ['tmp-' seqDirs{seq_i}],  'tmp'    );
         catch
            fprintf('no ISall,need compute\n');
            mkdir('tmp');
         end
         %clear sceneInfo;
        try

             %     量化到0.5--1
             re_conf(sceneInfo,seqDirs,seq_i);
             sceneInfo.detFile=[sceneInfo.detFile(1:end-7)  seqDirs{seq_i} '_det.txt'];
             %       缓存ISall
        %      stateInfo = swSegTracker_for_ISall('scene',['config-mot/' seqDirs{seq_i} '.ini'],'params','config-mot/params.ini');
        % % % %      背景建模
        %       fore_background_model(sceneInfo,seqDirs,seqLens,seq_i);


            movefile('tmp',['tmp-' seqDirs{seq_i}]);

        catch
            movefile('tmp',['tmp-' seqDirs{seq_i}]);
             fprintf('ISall fore-background  fail\n');
        end
    % try
          aaam_tsp2det(sceneInfo,seqDirs,seqLens,seq_i);
    % catch
          fprintf('new det fail\n');
    % end

    % try
        main_for_nms_fusion(sceneInfo,seqDirs,seqLens,seq_i);
    % catch
          fprintf('fusion fail\n');
    % end
        aaa_det_TSP_edge0117
        get_det_img_main(seqData,img_file137,seq_i);
        REID_MAIN_0116(img_file137,other_param);

        write_mat_main(img_file137,seq_i,seqData,seqDirs);
        set_mht_canshu;
        mht_main0107(other_param,seq_i,seqDirs,kalman_param,g_para);


    end
end
%