setKalmanParameters;

if test_seq_flag==9
elseif test_seq_flag==15
    setOtherParameters;
    other_param.minDetScore=0.3';
    
    other_param.seq = 'MOT_Challenge_train';
elseif test_seq_flag==15.5
   setOtherParameters;
   other_param.minDetScore=0.3';
    
    other_param.seq = 'MOT_Challenge_test';
elseif test_seq_flag==16
    setOtherParameters_16;
    other_param.minDetScore=0.1';
    other_param.seq = 'MOT_Challenge_train_16';
elseif test_seq_flag==16.5
    setOtherParameters_16;
       other_param.minDetScore=0.1';
    other_param.seq = 'MOT_Challenge_test_16';
end

other_param.det_mat_input_path = [['data/'] seqDirs{seq_i} '.mat'];
other_param.tsp_det=[['data/'] seqDirs{seq_i} '-tsp_det_edge.mat']

 other_param.dummyNumberTH = 20;   
         
 if strcmp(other_param.seq,'PETS2009')  
  
elseif strcmp(other_param.seq,'MOT_Challenge_train')
    Vc = [1920*1080 1920*1080 640*480 640*480 640*480 1242*375 1224*370 768*576 640*480 640*480 1920*1080];
    other_param.pFalseAlarm = 1/Vc(seq_i);    
elseif strcmp(other_param.seq,'MOT_Challenge_test')
    Vc = [1920*1080 1920*1080 1920*1080 640*480 640*480 640*480 1224*370 1238*374 768*576 640*480 1920*1080];
    other_param.pFalseAlarm = 1/Vc(seq_i-16);    
elseif strcmp(other_param.seq,'MOT_Challenge_train_16')
    Vc = [1920*1080 1920*1080 640*480 1920*1080 1920*1080 1920*1080 1920*1080]; 
    other_param.pFalseAlarm = 1/Vc(seq_i-27);    
elseif strcmp(other_param.seq,'MOT_Challenge_test_16')
     Vc = [1920*1080 1920*1080 640*480 1920*1080 1920*1080 1920*1080 1920*1080];
    other_param.pFalseAlarm = 1/Vc(seq_i-34);    

end

 other_param.seqs=seqDirs(seq_i);


    