% %画框
 warning off;
global g_para;
global sceneInfo;
firstFrame=g_para.firstFrame;
lastFrame=g_para.lastFrame;
% fore_thresh=g_para.fore_thresh;
% flow_thresh=g_para.fore_thresh;
% spfile=g_para.spfile;

% close all;
% clear all,clc;
% % 存的为左上角
% cur_data='input/PETS09-S2L1';
% % 0802zxy用于小规模调试
% firstFrame=1;
% lastFrame=95;
% 
% %% load TSP0805zxy
% sp_lb_file=[cur_data '/sp-K800.mat'];
% load(sp_lb_file);
%    
% %0805zxy
% 
% cameraconffile = 'input/View_001.xml';
% camPar = parseCameraParameters(cameraconffile);
% %    
% 
% % %0806zxy
% im_file=[cur_data '/img1/000001.jpg'];
% img_input_path=[cur_data '/img1/%06d.jpg'];
% im=imread(im_file);
% sceneInfo.imgHeight=size(im,1);
% sceneInfo.imgWidth=size(im,2);
% % lastFrame=837;
%  sceneInfo.detFile=[cur_data '/det/det.txt'];
% spfile=[cur_data '/ISall/0000-%d-%d-K800.mat'];
i=1;
for k = firstFrame:lastFrame
    
    
    %zxy0805
%     if k>2
%         sp_lable=sp_labels(:,:,k-2:k);
%     else
%         sp_lable=[];
%     end
%% zxy0805 load ISall 背景建模（seg fore-background）
     if k==1
%       cur_spfile=sprintf(spfile,k,min(k+49,lastFrame));
       kk=1;
%         isall=load(cur_spfile);
%         ISall=isall.ISall;
        read_det1;
%         detSeg;
%         svmSeg;

%         imtoplimit=min([detections(:).yi]);
%         sceneInfo.imOnGP= [...
% 	1 sceneInfo.imgHeight ...
% 	1 imtoplimit ...
% 	sceneInfo.imgWidth,imtoplimit ...
% 	sceneInfo.imgWidth,sceneInfo.imgHeight];
%    htobj=estimateTargetsSize(detections);%坐标为下中心
%     sceneInfo.htobj=htobj;
        

     
    
     end

     
    if mod(k,45)== 6&&k~=6
        kk=6;
        

%          cur_spfile=sprintf(cur_spfile,k-5,min(k+44,lastFrame));
         
% 
%         isall=load(cur_spfile);
%         ISall=isall.ISall;
%         ISall(:,3)= ISall(:,3)+45*round(k/45);
        read_det1;
%         detSeg;
%         svmSeg;


%         sceneInfo.imOnGP= [...
% 	1 sceneInfo.imgHeight ...
% 	1 imtoplimit ...
% 	sceneInfo.imgWidth,imtoplimit ...
% 	sceneInfo.imgWidth,sceneInfo.imgHeight];
%     htobj=estimateTargetsSize(detections);%坐标为下中心
%     sceneInfo.htobj=htobj;
     
           end
%          
    
  


        im1 = imread(sprintf(img_input_path, i)); %% read an image

        ndet=length(detections(kk).sc);
        for dd=1:ndet
            bx=detections(kk).bx(dd);by=detections(kk).by(dd);bh=detections(kk).ht(dd);bw=detections(kk).wd(dd);
            im1(max(1,by):min(by+2,sceneInfo.imgHeight),max(1,bx):min(bx+bw,sceneInfo.imgWidth),:)=255;
            im1(max(1,by+bh):min(by+bh+2,sceneInfo.imgHeight),max(1,bx):min(bx+bw,sceneInfo.imgWidth),:)=255;
            im1(max(1,by):min(by+bh,sceneInfo.imgHeight),max(1,bx):min(bx+2,sceneInfo.imgWidth),:)=255;
             im1(max(1,by):min(by+bh,sceneInfo.imgHeight),max(1,bx+bw):min(bx+bw+2,sceneInfo.imgWidth),:)=255;
             
        end
        imshow(im1);
        for dd=1:ndet
             bx=detections(kk).bx(dd);by=detections(kk).by(dd);sc=detections(kk).sc(dd);
            text(max(1,bx),max(1,by),num2str(sc),'fontsize',12);
        end
        saveas(gcf, ['det_box/' cur_data(7:end)  sprintf('/%0.8d', i) '.jpg']);  %保存当前窗口的图像  
%         imwrite(im1, ['det_box/' cur_data(7:end)  sprintf('/%0.8d', i) '.jpg']); %%write the output image  
 
        
        kk=kk+1;
        i=i+1;
        
 
end

