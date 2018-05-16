%无用，为避免冲突而设计 
%选取检测框外的超像素建立树（轨迹）
clear all,clc;
%设置参数
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

for i=1:11
    cur_data_all{i}=['data/2DMOT2015/train/' seqDirs{i}];
end
for i=17:27
    cur_data_all{i}=['data/2DMOT2015/test/' seqDirs{i}];
end
for i=[28 29 30 34 35 36 37]
    cur_data_all{i}=['data/MOT16/train/' seqDirs{i}];
end
for i=[31 32 33 38:41]
    cur_data_all{i}=['data/MOT16/test/' seqDirs{i}];
end
 lastFrame_all = seqLens;
 %%  是否mot  data 
  is_mot=2;
for data_i=[1:11 17:27]

    cur_data=cur_data_all{data_i};
% 0802zxy用于小规模调试
    firstFrame=1;
    lastFrame=lastFrame_all(data_i);


    sceneInfo = parseScene(['config-mot/' seqDirs{data_i} '.ini']);
    seq_i=data_i;
    set_para;
    
%% 计算新det部分
    try
%             load([g_para.cur_data(23:end) '-ISall_all.mat']);
        load([ sceneInfo.imgFolder sceneInfo.sequence '-ISall_all.mat']);   
    catch
        ISall_all=ReadData();
    end
    
    g_para.detFile=[g_para.detFile(1:end-7) seqDirs{data_i} '_det_final.txt'];
    %超像素是否在检测中需要重新判断，因为加了新框
    data_raw=dlmread(g_para.detFile);
    det_tsp_e.gap=sparse(size(data_raw,1),size(data_raw,1));%标记时间距离
    det_tsp_e.mask=sparse(size(data_raw,1),size(data_raw,1));%标记连接
    det_tsp_e.num=sparse(size(data_raw,1),size(data_raw,1));%标记连接个数
    det_tsp_e.fore=sparse(size(data_raw,1),size(data_raw,1));%标记前景分数和
    det_tsp_e.tr_sc=sparse(size(data_raw,1),size(data_raw,1));%标记最优树的分数
    for isall_i=1:size(ISall_all,2)
        cur_isall=ISall_all{isall_i};
        toframe=min(45*isall_i,g_para.lastFrame);
        if isall_i==size(ISall_all,2)
            toframe=g_para.lastFrame;
        end
        for fram_i=(45*(isall_i-1)+1):toframe
            cur_data_raw=data_raw(find(data_raw(:,1)==fram_i),:);
            cur_data_raw_ind=find(data_raw(:,1)==fram_i);
            
            for det_i=1:size(cur_data_raw,1)
                fprintf('%d\n',cur_data_raw(det_i,1));
                for det_j=1:size(data_raw,1)
                    
                    if data_raw(det_j,1)-cur_data_raw(det_i,1)>0 && data_raw(det_j,1)-cur_data_raw(det_i,1)<4
                        cur_data_raw_i=cur_data_raw(det_i,:);
                        cur_data_raw_j=data_raw(det_j,:);
                        cur_det_i_tsp=get_cur_det_i_tsp(cur_data_raw_i,cur_isall);
                        
                        g_para.ex_next= data_raw(det_j,1)-cur_data_raw(det_i,1)+1;
                             min_tmp_val=10000;
                        %     last_tsp_now为一个超像素节点所有信息
                        %ISall_now是扩展用的
                        for cur_det_i_tsp_i=1:size(cur_det_i_tsp,1)
                            last_tsp_now=cur_det_i_tsp(cur_det_i_tsp_i,:);
                            ISall_now=getIsall( ISall_all,last_tsp_now);
                            ex_for_det_tsp_edg;
                            del_for_det_tsp_edg;
                            if is_in_det_j(tree_del,cur_data_raw_j)==1
                                 if tmp_val<min_tmp_val
                                    min_tmp_val=tmp_val;
                                end
                                det_tsp_e.gap(cur_data_raw_ind(det_i), det_j)=data_raw(det_j,1)-cur_data_raw(det_i,1);
                                det_tsp_e.mask(cur_data_raw_ind(det_i), det_j)=1;
                                det_tsp_e.num(cur_data_raw_ind(det_i), det_j)=det_tsp_e.num(cur_data_raw_ind(det_i), det_j)+1;
                                det_tsp_e.fore(cur_data_raw_ind(det_i), det_j)=det_tsp_e.fore(cur_data_raw_ind(det_i), det_j)+tree_del{14}(end);
                                det_tsp_e.tr_sc(cur_data_raw_ind(det_i), det_j)=min_tmp_val;
                            end
                        end
                        
                    else
                        continue;
                    end 
                end
            end
        end
    end

    save ([seqDirs{data_i} '-tsp_det_edge.mat'], 'det_tsp_e','-V7.3');

    end
