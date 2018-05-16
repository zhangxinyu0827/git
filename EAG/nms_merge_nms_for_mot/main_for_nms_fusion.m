function main_for_nms_fusion(sceneInfo,seqDirs,seqLens,seq_i)


write_flag=[0 0 1];
nms_thtesh=0.42
conf_thtesh=0.43
%%

detData=dlmread( [sceneInfo.imgFolder(1:end-5) 'det/'  seqDirs{seq_i} '_det_all.txt']);
nFrames = max(detData(:,1));
%NMS 重新排序
[ind_val,ind_ind]= sort(detData(:,1),'ascend');
detData=detData( ind_ind,:);
for f = 1:nFrames

    detsThisFrame = detData(detData(:,1) == f,:);
    %zxy0827
    [tmp_wuyong,order] = sort(detsThisFrame(:,7),'descend');
    detsThisFrame = detsThisFrame(order,:);
    detData(detData(:,1) == f,:)=detsThisFrame;

end
keep=nmsFilterDetections1(detData,nms_thtesh);

detData=detData(find(keep),:);
detData=detData(:,1:10);
detData=detData(detData(:,7)>=conf_thtesh,:);
if write_flag(1)==1
    fid=fopen([sceneInfo.imgFolder(1:end-5) 'det/'  seqDirs{seq_i} '_det_all_nms.txt'],'w+');
    for ii=1:size(detData,1)

      fprintf(fid,'%d,%d,%.2f,%.2f,%.2f,%.2f,%.6f,%d,%d,%d\n', detData(ii,:));

    end
    fclose(fid);
end
%         end

%%  merge

% cur_data_xml_data  detection by detector
cur_data_xml_data=dlmread( [sceneInfo.detFile ]);


cur_data_xml_data=[cur_data_xml_data(:,1:10) ones(size(cur_data_xml_data,1),1)];

detData=[detData(:,1:10)  0*ones(size(detData,1),1)];
detData=[cur_data_xml_data;detData];

if write_flag(2)==1
    fid=fopen([sceneInfo.imgFolder(1:end-5) 'det/'  seqDirs{seq_i} '_det_all_nms_merge.txt'],'w+');
    for ii=1:size(detData,1)

        fprintf(fid,'%d,%d,%.2f,%.2f,%.2f,%.2f,%.6f,%d,%d,%d,%d\n', detData(ii,:));%

    end
    fclose(fid); 
end
%         end

%% nms
nFrames = max(detData(:,1));
%NMS 重新排序
[ind_val,ind_ind]= sort(detData(:,1),'ascend');
detData=detData( ind_ind,:);
for f = 1:nFrames

    detsThisFrame = detData(detData(:,1) == f,:);
    %zxy0827
    [tmp_wuyong,order] = sort(detsThisFrame(:,7),'descend');
    detsThisFrame = detsThisFrame(order,:);
    detData(detData(:,1) == f,:)=detsThisFrame;

end

keep=mynmsFilterDetections(detData,nms_thtesh);

detData=detData(find(keep),:);
detData=detData(:,1:11);

%% 排序
[ind_val,ind_ind]= sort(detData(:,1),'ascend');
detData=detData( ind_ind,:);
for f = 1:nFrames

    detsThisFrame = detData(detData(:,1) == f,:);
    %zxy0827
    [tmp_wuyong,order] = sort(detsThisFrame(:,7),'descend');
    detsThisFrame = detsThisFrame(order,:);
    detData(detData(:,1) == f,:)=detsThisFrame;

end
%%

if write_flag(3)==1
    fid=fopen([sceneInfo.imgFolder(1:end-5) 'det/'  seqDirs{seq_i} '_det_final.txt'],'w+');
    for ii=1:size(detData,1)

        fprintf(fid,'%d,%d,%.2f,%.2f,%.2f,%.2f,%.6f,%d,%d,%d,%d\n', detData(ii,:));%

    end
    fclose(fid);
end
%%  用于调试参数
try
cur_data_gt_data=dlmread(sceneInfo.gtFile );
% detData=cur_data_xml_data;
gt_data=cur_data_gt_data;
% fprintf('********  %d  %.2f  %.2f ******\n',data_i,nms_thtesh,conf_thtesh);
% print_init;
% detData=cur_data_xml_data;%不注释则评价原始框和gt
result=evalDet(gt_data,detData);
fid=fopen('eval_det.txt','a+');
fprintf(fid,'%d,%.2f,%.2f,%.2f,%.2f,%d,%d,%d\n',[seq_i nms_thtesh conf_thtesh result]);%
fclose(fid);

catch
fprintf(' gt missing\n')
end
