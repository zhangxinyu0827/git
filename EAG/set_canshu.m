global sceneInfo  seq_i seqLens seqDirs;

% test_seq_flag=15;   
    %9->pets09,15->mot15 train,15.5->MOT15 test,
    %16->mot16 train,16.5->MOT16 test
other_param.use_ss_reid_batch=20;

   
if test_seq_flag==9
    test_seq=[12:16];
elseif test_seq_flag==15
    test_seq=[4:11];
elseif test_seq_flag==15.5
    test_seq=[17:27];
elseif test_seq_flag==16
    test_seq=[28:34];
elseif test_seq_flag==16.5
    test_seq=[35:41];
elseif test_seq_flag==16.1
    test_seq=[36:37];
elseif test_seq_flag==16.6
    test_seq=[41:41];
end