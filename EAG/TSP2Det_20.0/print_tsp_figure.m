%将在检测外的，且为前景 的输出，每个超像素均输出一帧
g_i=1;
for k = firstFrame:lastFrame
    
    
    %zxy0805
%     if k>2
%         sp_lable=sp_labels(:,:,k-2:k);
%     else
%         sp_lable=[];
%     end
%% zxy0805 load ISall 背景建模（seg fore-background）
     if k==1
%         cur_spfile=sprintf(spfile,k,min(k+49,lastFrame));
%        
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
%                 insidedet(ISall(:,13)==kk& ...
%                 ISall(:,4)>bx+indet_thresh*bw & ISall(:,5)>by +indet_thresh*bh& ...
%                 ISall(:,4)<bx+(1-indet_thresh)*bw & ...
%                 ISall(:,5)<by+(1-indet_thresh)*bh)=true; % inside det box 判断每一个超级像素是否在边界箱内)
%          
%             end
%         end
%         ISall(:,12)=1:length(Q);
%         ISall(:,13)=ISall(:,3);
%         ISall(:,14)=Q;
%         ISall(:,15)=(ISall(:,9)).^2+(ISall(:,10)).^2;
        fore_ind=Q>fore_thresh  &  ISall(:,15) >flow_thresh;
        keep=fore_ind & (~insidedet);
        fore_indu=unique(ISall(keep,1));
        fore_tsp=ISall(keep,:);
        for foreii=1:length(fore_indu)
            %把所在行选出
            foreii_row=find(fore_tsp(:,1)==fore_indu(foreii));
            %记录对应帧
            fre=fore_tsp(foreii_row,3);
            tsp_xy_size=fore_tsp(foreii_row,[4 5 11]);
            
                for frei=1:length(fre)
                        im1=imread(sprintf(img_input_path, fre(frei))); %% read an image
%                         im1=rgb2gray(im1);
%                         im1(sp_labels(:,:,fre(frei))==fore_indu(foreii))=255;
                        Itmp=im1;
                        [xx yy zz]=size(im1);
                        npix=xx*yy;
                        [u,v]=find(sp_labels(:,:,fre(frei))==fore_indu(foreii));
                        imind=sub2ind([xx yy],u,v);
                        Itmp(imind)=255;        Itmp(imind+npix)=255;        Itmp(imind+npix*2)=255;
                        im1=Itmp;
%                         分别记录了超像素标签，帧数，全局ID 
                        imwrite(im1, ['out_det/' cur_data(7:end) sprintf('/%0.6d%0.6d%0.8d', fore_indu(foreii),fre(frei),g_i) '.jpg']); %%write the output image 
%                         A(g_i,1)=fore_indu(foreii);
%                         A(g_i,2)=fre(frei);
%                         A(g_i,3:5)=tsp_xy_size(frei,1:3);
%                         
                        g_i=1+g_i;                     
                     
                end
       

        end
      
     end
    if mod(k,45)== 6&&k~=6
%          cur_spfile=sprintf(spfile,k-5,min(k+44,lastFrame));
%          
% 
%         isall=load(cur_spfile);
%         ISall=isall.ISall;
%      
        read_det;
%         detSeg;
%         svmSeg;
%         sceneInfo.imOnGP= [...
%         1 sceneInfo.imgHeight ...
%         1 imtoplimit ...
%         sceneInfo.imgWidth,imtoplimit ...
%         sceneInfo.imgWidth,sceneInfo.imgHeight];
%         htobj=estimateTargetsSize(detections);%坐标为下中心
%         sceneInfo.htobj=htobj;
 %查找符合要求 超像素，此处为，前景且在检测外的
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
%                 insidedet(ISall(:,13)==kk& ...
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
%         
%         ISall(:,15)=(ISall(:,9)).^2+(ISall(:,10)).^2;
        fore_ind=Q>fore_thresh  &  ISall(:,15) >flow_thresh;
        keep=fore_ind & (~insidedet);
        fore_indu=unique(ISall(keep,1));
        fore_tsp=ISall(keep,:);
        for foreii=1:length(fore_indu)
            %把所在行选出
            foreii_row=find(fore_tsp(:,1)==fore_indu(foreii));
            %记录对应帧
            fre=fore_tsp(foreii_row,3);
            tsp_xy_size=fore_tsp(foreii_row,[4 5 11]);
            
            for frei=1:length(fre)
                    im1=imread(sprintf(img_input_path, fre(frei))); %% read an image
%                         im1=rgb2gray(im1);
%                         im1(sp_labels(:,:,fre(frei))==fore_indu(foreii))=255;
                    Itmp=im1;
                    [xx yy zz]=size(im1);
                    npix=xx*yy;
                    [u,v]=find(sp_labels(:,:,fre(frei))==fore_indu(foreii));
                    imind=sub2ind([xx yy],u,v);
                    Itmp(imind)=255;        Itmp(imind+npix)=255;        Itmp(imind+npix*2)=255;
                    im1=Itmp;
%                         分别记录了超像素标签，帧数，全局ID 
                    imwrite(im1, ['out_det/' cur_data(7:end) sprintf('/%0.6d%0.6d%0.8d', fore_indu(foreii),fre(frei),g_i) '.jpg']); %%write the output image 
%                     A(g_i,1)=fore_indu(foreii);
%                     A(g_i,2)=fre(frei);
%                     A(g_i,3:5)=tsp_xy_size(frei,1:3);

                    g_i=1+g_i;                     

            end
    
                                                                                                                                          
        end
    end   
end
