function write_mat_main(img_file137,seq_i,seqData,seqDirs)
reid_mat_f=[img_file137 '/det137_train_' ];  
off=0;
        for i=[seq_i]
            detFile=seqData.inputDetections;
            detRaw=dlmread(detFile);
            det_tmp=detRaw;
            keep=find(detRaw(:,5)>0 & detRaw(:,6)>0);

            if size(detRaw,1)~=length(keep)
                detRaw=detRaw(keep,:);
                fprintf([detFile '有删除\n'])
            end
            %conf_hobj;
            cnndata=get_reid_txt0117(reid_mat_f,off+1,off+length(keep));
            off=off+length(keep);
          
            cnndata=cnndata';
            det.bx=detRaw(:,3);
            det.by=detRaw(:,4);
            det.w=detRaw(:,5);
            det.h=detRaw(:,6);
            det.x=det.bx;
            det.y=det.by;
            det.r=detRaw(:,7);
            det.r_old=det_tmp(:,7);
            det.fr=detRaw(:,1);
           % det.flag=detRaw(:,11);
            det.cnn=cnndata;

              save ( [['data/'] seqDirs{seq_i} '.mat'], 'det','-V7.3');
   
% off
        end
    end


