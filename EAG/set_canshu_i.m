
mkdir(['img_file137/' seqDirs{seq_i} ]);
img_file137=(['img_file137/' seqDirs{seq_i} ]);
delete(['img_file137/' seqDirs{seq_i} '/*.mat'])
  sceneInfo = parseScene(['config-mot/' seqDirs{seq_i} '.ini']);

if test_seq_flag==9
elseif test_seq_flag==15
    seqData.inputDetections = fullfile(['data/2DMOT2015/train'],seqDirs{seq_i},'det',[seqDirs{seq_i} '_det_final.txt']);
seqData.inputVideoFile= fullfile(['data/2DMOT2015/train'],seqDirs{seq_i},['img1']);
elseif test_seq_flag==15.5
  seqData.inputVideoFile= fullfile(['data/2DMOT2015/test'],seqDirs{seq_i},['img1']);
    seqData.inputDetections = fullfile(['data/2DMOT2015/test'],seqDirs{seq_i},'det',[seqDirs{seq_i} '_det_final.txt']);
elseif test_seq_flag==16
   seqData.inputVideoFile= fullfile(['data/MOT16/train'],seqDirs{seq_i},['img1']);
    seqData.inputDetections = fullfile(['data/MOT16/train'],seqDirs{seq_i},'det',[seqDirs{seq_i} '_det_final.txt']);
elseif test_seq_flag==16.5
   seqData.inputVideoFile= fullfile(['data/MOT16/test'],seqDirs{seq_i},['img1']);
    seqData.inputDetections = fullfile(['data/MOT16/test'],seqDirs{seq_i},'det',[seqDirs{seq_i} '_det_final.txt']);
end

   cur_data=seqData.inputVideoFile(1:end-5)
   firstFrame=1;
   lastFrame=seqLens(seq_i);
   set_para