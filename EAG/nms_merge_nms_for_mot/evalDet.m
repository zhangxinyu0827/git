function result=evalDet(gtData,detData)
%(gtData,detData, 每行代表一个记录
gtData=[gtData zeros(length(gtData),1)];%gt中可以匹配的目录
detData=[detData zeros(length(detData),1)];%det中可以匹配的目录
%NMS
%  keep=nmsFilterDetections(detData,0.5);
% detData=detData(find(keep),:);

%计算
for gt_i=1:length(gtData)
%         det_fri=detData(find(detData(:,1)==gt_i),:);
    tmp_det=[];%用于记录此次匹配的det的下标值，取匹配度最高的，避免1gt--》多个det
    tmp_val=[];%用于记录缓存值
    for det_i=1:size(detData,1)
        if detData(det_i,1)==gtData(gt_i,1);
            if ~detData(det_i,end)
                iou=boxiou(gtData(gt_i,3),gtData(gt_i,4),gtData(gt_i,5),gtData(gt_i,6),detData(det_i,3),...
                    detData(det_i,4),detData(det_i,5),detData(det_i,6));
                if iou>0.5
                    gtData(gt_i,end)=1;
                    detData(det_i,end)=1;
                    tmp_det=[tmp_det det_i];
                    tmp_val=[tmp_val iou];
                end
            end
        end
    end
    if length(tmp_det)>1
        [ max_val max_ind]=max(tmp_val);

        detData(tmp_det,end)=0;
        detData(tmp_det(max_ind),end)=1;
    end
end

TP = sum( detData(:,end));
FP=length(detData)-TP;
FN=length(gtData)-TP;
Rcll=TP/(TP+FN);
Prcn=TP/(TP+FP);

fprintf('\nRcll  |  Prcn  |  TP  |  FP  |  FN  \n');
fprintf('\n%.2f,    %.2f,    %d,     %d    ,%d\n', [Rcll  Prcn  TP  FP  FN ]);%
% 
% tmp_txt_name='res_eval_det.txt';
% fid=fopen(tmp_txt_name,'a+');
% fprintf(fid,'\nRcll  |  Prcn  |  TP  |  FP  |  FN  \n');
% fprintf(fid,'\n%.2f,    %.2f,    %d,     %d    ,%d\n', [Rcll  Prcn  TP  FP  FN ]);%
% fclose(fid);

result=[Rcll  Prcn  TP  FP  FN ];
end