%%重命名和标定置信度

%% 初始化参数
clear all,clc;
%设置参数

    seqDirs = {'ADL-Rundle-6','ADL-Rundle-8','ETH-Bahnhof','ETH-Pedcross2',...
        'ETH-Sunnyday','KITTI-13','KITTI-17','PETS09-S2L1','TUD-Campus',...
        'TUD-Stadtmitte','Venice-2'  'PETS09-S1L1'   'PETS09-S1L2'  'PETS09-S2L1' ...
        'PETS09-S2L2'  'PETS09-S2L3'};
for i=1:11
    cur_data_all{i}=['input/2DMOT2015/train/' seqDirs{i}];
end
 lastFrame_all = [525,654,1000,837,354,340,145,795,71,179,600];
 %%  是否mot  data 
  is_mot=1;
 for data_i= 1:11

    cur_data=cur_data_all{data_i};
% 0802zxy用于小规模调试
    firstFrame=1;
    lastFrame=lastFrame_all(data_i);
    % s1l1  241  201
    % s2 795 436 240


    set_para;

%% 重命名部分
  detData=dlmread( g_para.detFile);
  detData=detData(:,1:10);
%   detData(:,7)=.01*detData(:,7);
ss_tmp=g_para.detFile;
     fid=fopen([ss_tmp(1:end-7) seqDirs{data_i} '_det.txt'],'w+');
     for ii=1:size(detData,1)
            fprintf(fid,'%d,%d,%.2f,%.2f,%.2f,%.2f,%.6f,%d,%d,%d\n', detData(ii,:));%
     end
     fclose(fid);
     
% aaa_tmp=g_para.gtFile;
%       fid=fopen([aaa_tmp(1:end-6) seqDirs{data_i} '_gt.txt'],'w+');
%      for ii=1:size(gtData,1)
%             fprintf(fid,'%d,%d,%.2f,%.2f,%.2f,%.2f,%.6f,%d,%d,%d\n', gtData(ii,:));%
%      end
%      fclose(fid);


% %% 重新标定置信度
%   detData=detData(:,1:10);
%   tmp_s=detData(:,7);
%   detData(:,7)=((tmp_s-min(tmp_s))/(max(tmp_s)-min(tmp_s)))*0.5+0.5;
% ss_tmp=g_para.detFile;
%      fid=fopen(ss_tmp,'w+');
%      for ii=1:size(detData,1)
%             fprintf(fid,'%d,%d,%.2f,%.2f,%.2f,%.2f,%.6f,%d,%d,%d\n', detData(ii,:));%
%      end
%      fclose(fid);
     
     
 end