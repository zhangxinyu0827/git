%将在检测外的，且为前景 的输出，逐帧输出

global g_para;
global sceneInfo;
firstFrame=g_para.firstFrame;
lastFrame=g_para.lastFrame;
fore_thresh=g_para.fore_thresh;
flow_thresh=g_para.flow_thresh;
spfile=g_para.spfile;
sp_lb_file=g_para.sp_lb_file;
load(sp_lb_file);
%画框
i=1;
% lastFrame=100;
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
%        kk=1;
%         isall=load(cur_spfile);
%         ISall=isall.ISall;
        read_det;
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
     ISall= ISall_all{1};
    Q=ISall(:,14);
        insidedet=ISall(:,16);
   %查找符合要求 超像素，此处为，前景且在检测外的
%      insidedet=false(size(Q));
%         for kk=1:length(detections)
%             ndet=length(detections(kk).sc);
%             for dd=1:ndet
%                 bx=detections(kk).bx(dd);by=detections(kk).by(dd);bh=detections(kk).ht(dd);bw=detections(kk).wd(dd);
% 
%                 
%                insidedet(ISall(:,13)==kk& ...
%                 ISall(:,4)>bx+indet_thresh*bw & ISall(:,5)>by +indet_thresh*bh& ...
%                 ISall(:,4)<bx+(1-indet_thresh)*bw & ...
%                 ISall(:,5)<by+(1-indet_thresh)*bh)=true; % inside det box 判断每一个超级像素是否在边界箱内)
%          
%             end
%         end
%         ISall(:,12)=1:length(Q);
%         ISall(:,13)=ISall(:,3);
%         ISall(:,14)=Q;

        fore_ind=Q>fore_thresh  &  ISall(:,15) >flow_thresh;
        keep=fore_ind & (~insidedet);

        fore_tsp=ISall(keep,:);
       
     
    
     end

     
    if mod(k,45)== 6&&k~=6
% %         kk=6;
%          cur_spfile=sprintf(cur_spfile,k-5,min(k+44,lastFrame));
%          
% 
%         isall=load(cur_spfile);
%         ISall=isall.ISall;
%         ISall(:,3)= ISall(:,3)+45*round(k/45);
        read_det;
%         detSeg;
%         svmSeg;
%         sceneInfo.imOnGP= [...
% 	1 sceneInfo.imgHeight ...
% 	1 imtoplimit ...
% 	sceneInfo.imgWidth,imtoplimit ...
% 	sceneInfo.imgWidth,sceneInfo.imgHeight];
%     htobj=estimateTargetsSize(detections);%坐标为下中心
%     sceneInfo.htobj=htobj;

    ISall= ISall_all{ceil(k/45)};
    Q=ISall(:,14);
        insidedet=ISall(:,16);
%         insidedet=false(size(Q));
%         for kk=1:length(detections)
%             ndet=length(detections(kk).sc);
%             for dd=1:ndet
%                 bx=detections(kk).bx(dd);by=detections(kk).by(dd);bh=detections(kk).ht(dd);bw=detections(kk).wd(dd);
% 
%                 
%                   insidedet(ISall(:,13)==kk& ...
%                 ISall(:,4)>bx+indet_thresh*bw & ISall(:,5)>by +indet_thresh*bh& ...
%                 ISall(:,4)<bx+(1-indet_thresh)*bw & ...
%                 ISall(:,5)<by+(1-indet_thresh)*bh)=true; % inside det box 判断每一个超级像素是否在边界箱内)
%          
%             end
%         end
        
%         ISall(:,12)=1:length(Q);
%         ISall(:,13)=ISall(:,3);
%         ISall(:,3)= ISall(:,3)+45*round(k/45);
%         ISall(:,14)=Q;

        fore_ind=Q>fore_thresh  &  ISall(:,15) >flow_thresh;
        keep=fore_ind & (~insidedet);
     
        fore_tsp=ISall(keep,:);
    end
%          
    
  


        im1 = imread(sprintf(img_input_path, i)); %% read an image
        cur_tsp_ind=find(fore_tsp(:,3)==i);
        cur_tsp_l_ind=fore_tsp(cur_tsp_ind,1);  
        Itmp=im1;
        for cur_tsp_l_ind_i=1:length(cur_tsp_l_ind)
      
            [xx yy zz]=size(im1);
            npix=xx*yy;
            [u,v]=find(sp_labels(:,:,i)==cur_tsp_l_ind(cur_tsp_l_ind_i));
            imind=sub2ind([xx yy],u,v);
            Itmp(imind)=255;        Itmp(imind+npix)=255;        Itmp(imind+npix*2)=255;
        end
        im1=Itmp;
     
        
        
        
        imwrite(im1, ['out_det_fre/' cur_data(7:end)  sprintf('/%06d%06d', i,k) '.jpg']); %%write the output image  
 
        
%         kk=kk+1;
        i=i+1;
        
 
end
clear sp_labels;
