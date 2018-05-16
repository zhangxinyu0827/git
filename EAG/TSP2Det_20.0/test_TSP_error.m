% % 用于查看，TSP 建树出错的原因

clear all,clc;
%设置参数
set_para;
global g_para;
global sceneInfo;

ce_k=527;
% % %画框
% 
% i=1;
% for k = firstFrame:lastFrame
%      if k==1
%         kk=1;
%         read_det;
%      end
%     if mod(k,45)== 6&&k~=6 
%         kk=6;
%         read_det;    
%     end
%     if k==ce_k
%         im1 = imread(sprintf(img_input_path, i)); %% read an image
% 
%         ndet=length(detections(kk).sc);
%         for dd=1:ndet
%             bx=detections(kk).bx(dd);by=detections(kk).by(dd);bh=detections(kk).ht(dd);bw=detections(kk).wd(dd);
%             im1(max(1,by):min(by+2,sceneInfo.imgHeight),max(1,bx):min(bx+bw,sceneInfo.imgWidth),:)=255;
%             im1(max(1,by+bh):min(by+bh+2,sceneInfo.imgHeight),max(1,bx):min(bx+bw,sceneInfo.imgWidth),:)=255;
%             im1(max(1,by):min(by+bh,sceneInfo.imgHeight),max(1,bx):min(bx+2,sceneInfo.imgWidth),:)=255;
%              im1(max(1,by):min(by+bh,sceneInfo.imgHeight),max(1,bx+bw):min(bx+bw+2,sceneInfo.imgWidth),:)=255;
%         end
%         imshow(im1);
%         break;
%     end
%     kk=kk+1;
%     i=i+1;   
% end

detFile=sceneInfo.detFile;
detRaw=dlmread(detFile);
im1 = imread(sprintf(img_input_path, ce_k)); %% read an image
ce_raw=detRaw(detRaw(:,1)==ce_k,:);
for kk=1:length(ce_raw(:,3));
%     im1 = imread(sprintf(img_input_path, ce_k)); %% read an image
    bx=ce_raw(kk,3);
    by=ce_raw(kk,4);
    bw=ce_raw(kk,5);
    bh=ce_raw(kk,6);
    sc=ce_raw(kk,7);
    
    im1(max(1,by):min(by+2,sceneInfo.imgHeight),max(1,bx):min(bx+bw,sceneInfo.imgWidth),:)=255;
    im1(max(1,by+bh):min(by+bh+2,sceneInfo.imgHeight),max(1,bx):min(bx+bw,sceneInfo.imgWidth),:)=255;
    im1(max(1,by):min(by+bh,sceneInfo.imgHeight),max(1,bx):min(bx+2,sceneInfo.imgWidth),:)=255;
    im1(max(1,by):min(by+bh,sceneInfo.imgHeight),max(1,bx+bw):min(bx+bw+2,sceneInfo.imgWidth),:)=255;
    
    imshow(im1);
    text(max(1,bx),max(1,by),num2str(sc),'fontsize',20);
    zanting=1;
end

for kk=1:length(ce_raw(:,3));
%     im1 = imread(sprintf(img_input_path, ce_k)); %% read an image
    bx=ce_raw(kk,3);
    by=ce_raw(kk,4);
   
    sc=ce_raw(kk,7);
    text(max(1,bx),max(1,by),num2str(sc),'fontsize',20);
end

% 
% % 找某一帧开头的
% for i=1:length(tree_table_del)
%     if(tree_table_del{i}{3}(1)==527)
%         i
%     end
% end

