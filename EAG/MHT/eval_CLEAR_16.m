% clear all,clc;
% gtFile='CLEAR/gt.txt';

img_input_path=g_para.img_input_path;
gtFile=[img_input_path(1:end-13) 'gt/gt.txt'];






cameraconffile = 'CLEAR/View_001.xml';
sceneInfo.camFile=cameraconffile;
sceneInfo.gtFile=gtFile;
gtInfo=convertTXTToStruct(gtFile);
sceneInfo.camPar = parseCameraParameters(sceneInfo.camFile);
 if strcmp(other_param.seq,'PETS2009')  
    if ~isfield(gtInfo, 'Xgp') || ~isfield(gtInfo, 'Ygp')%获取了世界坐标系
        [gtInfo.Xgp gtInfo.Ygp] = projectToGroundPlane(gtInfo.X, gtInfo.Y, sceneInfo);
    end
 end
 [mm nn]=size(gtInfo.W);
 frameNum=mm;
 %% 可以通过mat文件计算  0831
%  track_tmp=load('s1l1_new8.mat');
%  track=track_tmp.track;
%%
% bboxes_tracked = dres2bboxes(track, frameNum); 

allTrack= unique(track.id);
allTrack=allTrack';
stateInfo.X=zeros(frameNum,length(allTrack));
stateInfo.Y=zeros(frameNum,length(allTrack));
stateInfo.Xi=zeros(frameNum,length(allTrack));
stateInfo.Yi=zeros(frameNum,length(allTrack));
stateInfo.W=zeros(frameNum,length(allTrack));
stateInfo.H=zeros(frameNum,length(allTrack));
stateInfo.Xgp=zeros(frameNum,length(allTrack));
stateInfo.Ygp=zeros(frameNum,length(allTrack));
tr_t=1;
for tr=allTrack
    tr_ind=find(track.id==tr);
    tr_fr=track.fr(tr_ind);
    stateInfo.W(tr_fr,tr_t)=track.w(tr_ind);
    stateInfo.H(tr_fr,tr_t)=track.h(tr_ind);

    stateInfo.Xi(tr_fr,tr_t)=track.x_hat(tr_ind);
    stateInfo.Yi(tr_fr,tr_t)=track.y_hat(tr_ind);

    tr_t=tr_t+1;
end
% stateInfo.Xi=stateInfo.Xi(1:837,:);
% stateInfo.Yi=stateInfo.Yi(1:837,:);
% stateInfo.W=stateInfo.W(1:837,:);
% stateInfo.H=stateInfo.H(1:837,:);

stateInfo.Xi=stateInfo.Xi+(stateInfo.W)/2;
stateInfo.Yi=stateInfo.Yi+(stateInfo.H);
if strcmp(other_param.seq,'PETS2009')  
    [stateInfo.X,stateInfo.Y]=projectToGroundPlane(stateInfo.Xi, stateInfo.Yi, sceneInfo);
    stateInfo.Xgp=stateInfo.X;
    stateInfo.Ygp=stateInfo.Y;
     options.eval3d=1;

    [metrics3d, metrNames3d]=CLEAR_MOT_HUN(gtInfo,stateInfo,options);
    fprintf('\n  Rcll| Prcn|FAR||GT|MT|PT|ML||FP|FN|IDs|FM||MOTA|MOTP|MOYAL\n');
    printMetrics(metrics3d,metrNames3d,0,[1:14]);
    tmp_txt_name='res_mot.txt';
     fid=fopen(tmp_txt_name,'a+');
     tmp_seq_name=tmp_mat_file(1:end-3);
%      fprintf(fid,'\n%s\n',  tmp_seq_name);
%      fprintf(fid,'\n%s\n',  'Rcll| Prcn|FAR||GT|MT|PT|ML||FP|FN|IDs|FM||MOTA|MOTP|MOYAL');
     fprintf(fid,'%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,\n', metrics3d(1:14));
     fclose(fid);
else
     stateInfo.X=stateInfo.Xi;
     stateInfo.Y=stateInfo.Yi;
     
    [metrics2d, metricsInfo2d, addInfo2d]=CLEAR_MOT_HUN(gtInfo,stateInfo);
    fprintf('\n  Rcll| Prcn|FAR||GT|MT|PT|ML||FP|FN|IDs|FM||MOTA|MOTP|MOYAL\n');
    printMetrics(metrics2d,metricsInfo2d,0,[1:14]);
    tmp_txt_name='res_mot16.txt';
     fid=fopen(tmp_txt_name,'a+');

%      fprintf(fid,'\n%s\n',  tmp_seq_name);
%      fprintf(fid,'\n%s\n',  'Rcll| Prcn|FAR||GT|MT|PT|ML||FP|FN|IDs|FM||MOTA|MOTP|MOYAL');
%      fprintf(fid,'%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,\n', metrics2d(1:14));
     fprintf(fid,'%.1f,%.1f,%.2f,%d,%d,%d,%d,%d,%d,%d,%d,%.1f,%.1f,%.1f,\n',metrics2d(1:14));
        
     fclose(fid);
end