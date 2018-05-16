other_param.det_mat_input_path = [['data/'] seqDirs{seq_i} '.mat'];
other_param.tsp_det=[['data/'] seqDirs{seq_i} '-tsp_det_edge.mat']


detection = loadDet(other_param.det_mat_input_path, other_param);
tsp_det=load(other_param.tsp_det);
global cur_tsp_cost;
global cur_mask;
global cur_tsp_gap;
cur_mask=tsp_det.det_tsp_e.mask;
cur_tsp_cost=tsp_det.det_tsp_e.tr_sc;
cur_tsp_gap=tsp_det.det_tsp_e.gap;
clear tsp_det;
% detections=[detection.fr detection.r detection.bx detection.by detection.h detection.w];
%  keep_ind =  nmsFilterDetections(detections,nmsThreshold);
%  keep_ind=find(keep_ind);
%  detection.bx=detection.bx(keep_ind);
% detection.by=detection.by(keep_ind);
% detection.w=detection.w(keep_ind);
% detection.h=detection.h(keep_ind);
% detection.x=detection.x(keep_ind);
% detection.y=detection.y(keep_ind);
% detection.r=detection.r(keep_ind);
% detection.fr=detection.fr(keep_ind);
% detection.cnn=detection.cnn(keep_ind,:);
% detection.mask=tsp_det_mask;
% detection.tsp_cost=tsp_det_cost;
% detection.tsp_gap=tsp_det.det_tsp_e.gap;
detection.g_id=1:length(detection.bx);
detection.g_id=detection.g_id';

keep_ind=find(detection.r>0);
detection.bx=detection.bx(keep_ind);
detection.by=detection.by(keep_ind);
detection.w=detection.w(keep_ind);
detection.h=detection.h(keep_ind);
detection.x=detection.x(keep_ind);
detection.y=detection.y(keep_ind);
% detection.r=eps+(detection.r(keep_ind)-min(detection.r(keep_ind)))/(max(detection.r(keep_ind))-min(detection.r(keep_ind)));
 detection.r=detection.r(keep_ind);
detection.fr=detection.fr(keep_ind);
detection.cnn=detection.cnn(keep_ind,:);
detection.g_id=detection.g_id(keep_ind);
try
detection.flag=detection.flag(keep_ind,:);
catch
    
end
try
%detection.mask=detection.mask(keep_ind,:);
%detection.mask=detection.mask(:,keep_ind);
% global cur_tsp_cost;
% global cur_mask;
% global cur_tsp_gap;
% cur_mask=detection.mask;
% cur_tsp_cost=detection.tsp_cost-min(tsp_det.det_tsp_e.tr_sc(:));
% cur_tsp_gap=detection.tsp_gap;
other_param.base_tsp_cost=10;
catch
    
end