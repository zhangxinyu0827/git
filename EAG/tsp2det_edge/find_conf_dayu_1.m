 %查找检测中Conf是否有大于1的异常值
%by  Xinyu  Zhang , 20170315

%zhangxinyu0827@buaa.edu.cn  


seqDirs = {'ADL-Rundle-6','ADL-Rundle-8','ETH-Bahnhof','ETH-Pedcross2',...
        'ETH-Sunnyday','KITTI-13','KITTI-17','PETS09-S2L1','TUD-Campus',...
        'TUD-Stadtmitte','Venice-2'  'PETS09-S1L1'   'PETS09-S1L2'  'PETS09-S2L1' ...
        'PETS09-S2L2'  'PETS09-S2L3'};
    warning off
    for i=1:11
        detFile=['data/2DMOT2015/train/' seqDirs{i} '/det/det.txt'];
        detRaw=dlmread(detFile);
        find(detRaw(:,7)>1)
        1
    end