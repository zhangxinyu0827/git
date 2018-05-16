function mht_main0107(other_param,seq_i,seqDirs,kalman_param,g_para)
load_det;
det_tmp=detection;
track = MHT(det_tmp, kalman_param, other_param);

        write_txt;

    %     save tracking output into image
%         load(tmp_mat_file);
        if  strcmp(other_param.seq,'MOT_Challenge_train')
            eval_CLEAR_16;

           
        end
      if  strcmp(other_param.seq,'MOT_Challenge_train_16')
            eval_CLEAR_16;
           
         end
   