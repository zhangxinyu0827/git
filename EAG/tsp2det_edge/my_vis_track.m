%追踪的视觉展示
%by  Xinyu  Zhang , 20170315
%zhangxinyu0827@buaa.edu.cn


clear all,clc;


clear,clc;
% flow_ceshi;
% 用于协调11个数据集的运行
    seqDirs = {'ADL-Rundle-6','ADL-Rundle-8','ETH-Bahnhof','ETH-Pedcross2',...
        'ETH-Sunnyday','KITTI-13','KITTI-17','PETS09-S2L1','TUD-Campus',...
        'TUD-Stadtmitte','Venice-2'  'PETS09-S1L1'   'PETS09-S1L2'  'PETS09-S2L1' ...
        'PETS09-S2L2'  'PETS09-S2L3','ADL-Rundle-1','ADL-Rundle-3','AVG-TownCentre',...
        'ETH-Crossing','ETH-Jelmoli','ETH-Linthescher','KITTI-16','KITTI-19',...
        'PETS09-S2L2','TUD-Crossing','Venice-1'};
    warning off
mkdir('output');


for i=[ 9]
    
    
     stateInfo = my_swSegTracker('scene',['config-mot/' seqDirs{i} '.ini'],'params','config-mot/params.ini');
   movefile('output',['output-' seqDirs{i}]);

end
