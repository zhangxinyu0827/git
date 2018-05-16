%for LIBAO main function
%by  Xinyu  Zhang , 20170315

%zhangxinyu0827@buaa.edu.cn

%before use this please run installSegTracker.m,  installs all necessary dependencies
clear all,clc;
% 用于协调数据集的运行
    seqDirs = {'ADL-Rundle-6','ADL-Rundle-8','ETH-Bahnhof','ETH-Pedcross2',...
        'ETH-Sunnyday','KITTI-13','KITTI-17','PETS09-S2L1','TUD-Campus',...
        'TUD-Stadtmitte','Venice-2'  'PETS09-S1L1'   'PETS09-S1L2'  'PETS09-S2L1' ...
        'PETS09-S2L2'  'PETS09-S2L3','ADL-Rundle-1','ADL-Rundle-3','AVG-TownCentre',...
        'ETH-Crossing','ETH-Jelmoli','ETH-Linthescher','KITTI-16','KITTI-19',...
        'PETS09-S2L2','TUD-Crossing','Venice-1','MOT16-04','MOT16-11','MOT16-13'...
        ,'MOT16-03','MOT16-12','MOT16-14','MOT16-02','MOT16-05','MOT16-09'...
        ,'MOT16-10','MOT16-01','MOT16-06','MOT16-07','MOT16-08'};
seqLens = [525,654,1000,840,354,340,145,795,71,179,600];
seqLens=[seqLens   241  201 795 436 240];
seqLens=[seqLens   500,625,450,219,440,1194,209,1059,436,201,450];
seqLens=[seqLens  1050 900 750 ];
seqLens=[seqLens  1500 900 750 ];
seqLens=[seqLens  600 837 525 654 ];
seqLens=[seqLens  450 1194 500 625 ];


warning off
addpath(genpath('./TSP2Det_20.0'));
addpath(genpath('./utils'))
addpath(genpath('./external'))
addpath(genpath('./nms_merge_nms_for_mot'))
seq_i=1;

global sceneInfo  seq_i seqLens seqDirs;



for seq_i=[28:33]
    mkdir('tmp');
     sceneInfo = parseScene(['config-mot/' seqDirs{seq_i} '.ini']);
   
     re_conf(sceneInfo,seqDirs,seq_i);
     sceneInfo.detFile=[sceneInfo.detFile(1:end-7)  seqDirs{seq_i} '_det.txt'];
     %       缓存ISall
      stateInfo = swSegTracker_for_ISall_sp1200('scene',['config-mot/' seqDirs{seq_i} '.ini'],'params','config-mot/params.ini');
  seq_i
 movefile('tmp',['tmp-' seqDirs{seq_i}]);
end
