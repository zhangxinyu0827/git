warning off
addpath(genpath('./TSP2Det_20.0'));
addpath(genpath('./utils'))
addpath(genpath('./external'))
addpath(genpath('./nms_merge_nms_for_mot'))
addpath(genpath('./tsp2det_edge'))
addpath(genpath('./MHT'))
addpath(genpath('./reid137'))
addpath(genpath('./get_det_img'))
addpath(genpath('./write_mat'))
%write_mat

% 用于协调数据集的运行
    seqDirs = {'ADL-Rundle-6','ADL-Rundle-8','ETH-Bahnhof','ETH-Pedcross2',...
        'ETH-Sunnyday','KITTI-13','KITTI-17','PETS09-S2L1','TUD-Campus',...
        'TUD-Stadtmitte','Venice-2'  'PETS09-S1L1'   'PETS09-S1L2'  'PETS09-S2L1' ...
        'PETS09-S2L2'  'PETS09-S2L3','ADL-Rundle-1','ADL-Rundle-3','AVG-TownCentre',...
        'ETH-Crossing','ETH-Jelmoli','ETH-Linthescher','KITTI-16','KITTI-19',...
        'PETS09-S2L2','TUD-Crossing','Venice-1',...
        'MOT16-02','MOT16-04','MOT16-05'...
        ,'MOT16-09','MOT16-10','MOT16-11','MOT16-13','MOT16-01','MOT16-03'...
        ,'MOT16-06','MOT16-07','MOT16-08','MOT16-12','MOT16-14'};
seqLens = [525,654,1000,837,354,340,145,795,71,179,600];
seqLens=[seqLens   241  201 795 436 240];
seqLens=[seqLens   500,625,450,219,440,1194,209,1059,436,201,450];
seqLens=[seqLens  600 1050 837 525 654 900 750];
seqLens=[seqLens  450 1500 1194 500 625 900 750];




    
   
