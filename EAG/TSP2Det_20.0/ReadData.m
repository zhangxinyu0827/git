function ISall_all=ReadData(sceneInfo,seqDirs,seqLens,seq_i)
%by  Xinyu  Zhang , 20170315

%zhangxinyu0827@buaa.edu.cn
% 读入缓存数据，为后续工作方便
% a helper lookup table
% ISall(k,1) = TSP
% ISall(k,2) = Iunsp
% ISall(k,3) = frame（全局）
% ISall(k,4) = mean x (v)
% ISall(k,5) = mean y (u)
% ISall(k,6) = mean L
% ISall(k,7) = mean a
% ISall(k,8) = mean b
% ISall(k,9) = mean flowX
% ISall(k,10) = mean flowY
% ISall(k,11) = size
% ISall(k,12) = 在当前窗口，此超像素的Id
% ISall(k,13) = 在当前窗口，此超像素所在是帧
% ISall(k,14) = 前景分数
% ISall(k,15) = 水平和数值光流的二范数
% ISall(k,16) = 是否在检测内，是为1
global g_para;
% global sceneInfo;
firstFrame=g_para.firstFrame;
lastFrame=g_para.lastFrame;
spfile=g_para.spfile;
indet_thresh=g_para.indet_thresh;
sp_lb_file=g_para.sp_lb_file;
fore_pick=g_para.fore_pick;
load(sp_lb_file);
for k = firstFrame:lastFrame
  
    
    %zxy0805
%     if k>2
%         sp_lable=sp_labels(:,:,k-2:k);
%     else
%         sp_lable=[];
%     end
%% zxy0805 load ISall 背景建模（seg fore-background）
     if k==1
      cur_spfile=sprintf(spfile,k,min(k+49,lastFrame));
       kk_isall=1;
        isall=load(cur_spfile);
%         [cur_spfile(1:end-16) '42' cur_spfile(end-13:end)]
        ISall=isall.ISall;
        read_det;
       if (g_para.is_mot ==1)
        detSeg;
        svmSeg;
       elseif  (g_para.is_mot ==2)
              back_file=[g_para.cur_data '/img_svm_flow_fore/%06d.jpg'];
          Q=zeros(length(ISall(:,3)),1);
          for back_i=k:min(k+49,lastFrame)
              back_img_file=sprintf(back_file,back_i);
              back_img=imread(back_img_file);
               [xx yy]=size(back_img);
              cur_fre_ind=find(ISall(:,3)==back_i);
              cur_fre_lb=ISall(cur_fre_ind,1);
              for ii=1:length(cur_fre_lb)
                   [u,v]=find(sp_labels(:,:,back_i)==cur_fre_lb(ii));
                   imind=sub2ind([xx yy],u,v);
                  Q(cur_fre_ind(ii))=length(find(back_img(imind)>fore_pick))/length(v);
              end
              
          end
       else
          back_file=[g_para.cur_data '/imgCN/%06d.bmp'];
          Q=zeros(length(ISall(:,3)),1);
          for back_i=k:min(k+49,lastFrame)
              back_img_file=sprintf(back_file,back_i);
              back_img=imread(back_img_file);
               [xx yy]=size(back_img);
              cur_fre_ind=find(ISall(:,3)==back_i);
              cur_fre_lb=ISall(cur_fre_ind,1);
              for ii=1:length(cur_fre_lb)
                   [u,v]=find(sp_labels(:,:,back_i)==cur_fre_lb(ii));
                   imind=sub2ind([xx yy],u,v);
                  Q(cur_fre_ind(ii))=length(find(back_img(imind)))/length(v);
              end
              
          end
       end
%         imtoplimit=min([detections(:).yi]);
%         sceneInfo.imOnGP= [...
% 	1 sceneInfo.imgHeight ...
% 	1 imtoplimit ...
% 	sceneInfo.imgWidth,imtoplimit ...
% 	sceneInfo.imgWidth,sceneInfo.imgHeight];
%    htobj=estimateTargetsSize(detections);%坐标为下中心
%     sceneInfo.htobj=htobj;
    
    
        ISall(:,12)=1:length(Q);
        ISall(:,13)=ISall(:,3);
        ISall(:,14)=Q;
        ISall(:,15)=sqrt((ISall(:,9)).^2+(ISall(:,10)).^2);
        
         insidedet=false(size(Q));
%          bx_tmp=cell(size(Q));
        for kk=1:length(detections)
            ndet=length(detections(kk).sc);
            for dd=1:ndet
%                 if  g_para.is_use_high
%                     bx=detections(kk).bx(dd);by=detections(kk).by(dd);bh=detections(kk).ht(dd);bw=detections(kk).wd(dd);
% 
%                     tmp__inside_ind=find( ISall(:,13)==kk& ...
%                     ISall(:,4)>bx+indet_thresh*bw & ISall(:,5)>by +indet_thresh*bh& ...
%                     ISall(:,4)<bx+(1-indet_thresh)*bw & ...
%                     ISall(:,5)<by+(1-indet_thresh)*bh);
%                     insidedet(tmp__inside_ind)=true; % inside det box 判断每一个超级像素是否在边界箱内)
%                 
%    
%                 else
                    bx=detections(kk).bx(dd);by=detections(kk).by(dd);bh=detections(kk).ht(dd);bw=detections(kk).wd(dd);

                   tmp__inside_ind=find( ISall(:,13)==kk& ...
                    ISall(:,4)>bx+indet_thresh*bw & ISall(:,5)>by +indet_thresh*bh& ...
                    ISall(:,4)<bx+(1-indet_thresh)*bw & ...
                    ISall(:,5)<by+(1-indet_thresh)*bh);
                    insidedet(tmp__inside_ind)=true; % inside det box 判断每一个超级像素是否在边界箱内)
%                 end
            end
        end
        ISall(:,16)=insidedet;
        
        ISall_all{kk_isall}=ISall;
        kk_isall=kk_isall+1;
     end

     
    if mod(k,45)== 6&&k~=6

         cur_spfile=sprintf(spfile,k-5,min(k+44,lastFrame));
         
% 
        isall=load(cur_spfile);
        ISall=isall.ISall;

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
%     
        ISall(:,12)=1:length(ISall(:,3));
        ISall(:,13)=ISall(:,3);
        ISall(:,3)= ISall(:,3)+45*round(k/45);
        
%         !!!!!!!!!!!!!!!!!!!!!!!!!加Q 
      if (g_para.is_mot ==1)
        detSeg;
        svmSeg;
       elseif  (g_para.is_mot ==2)
              back_file=[g_para.cur_data '/img_svm_flow_fore/%06d.jpg'];
              Q=zeros(length(ISall(:,3)),1);
          for back_i=k:min(k+49,lastFrame)
              back_img_file=sprintf(back_file,back_i);
              back_img=imread(back_img_file);
               [xx yy]=size(back_img);
              cur_fre_ind=find(ISall(:,3)==back_i);
              cur_fre_lb=ISall(cur_fre_ind,1);
              for ii=1:length(cur_fre_lb)
                   [u,v]=find(sp_labels(:,:,back_i)==cur_fre_lb(ii));
                   imind=sub2ind([xx yy],u,v);
                 Q(cur_fre_ind(ii))=length(find(back_img(imind)>fore_pick))/length(v);
              end
          end
     else
       back_file=[g_para.cur_data '/imgCN/%06d.bmp'];
          Q=zeros(length(ISall(:,3)),1);
          for back_i=k:min(k+49,lastFrame)
              back_img_file=sprintf(back_file,back_i);
              back_img=imread(back_img_file);
               [xx yy]=size(back_img);
              cur_fre_ind=find(ISall(:,3)==back_i);
              cur_fre_lb=ISall(cur_fre_ind,1);
              for ii=1:length(cur_fre_lb)
                   [u,v]=find(sp_labels(:,:,back_i)==cur_fre_lb(ii));
                   imind=sub2ind([xx yy],u,v);
                  Q(cur_fre_ind(ii))=length(find(back_img(imind)))/length(v);
              end
          end
     end
        ISall(:,14)=Q;
       
      ISall(:,15)=sqrt((ISall(:,9)).^2+(ISall(:,10)).^2);
      
        insidedet=false(size(Q));
        for kk=1:length(detections)
            ndet=length(detections(kk).sc);
            for dd=1:ndet
                bx=detections(kk).bx(dd);by=detections(kk).by(dd);bh=detections(kk).ht(dd);bw=detections(kk).wd(dd);

                
                 insidedet(ISall(:,13)==kk& ...
                ISall(:,4)>bx+indet_thresh*bw & ISall(:,5)>by +indet_thresh*bh& ...
                ISall(:,4)<bx+(1-indet_thresh)*bw & ...
                ISall(:,5)<by+(1-indet_thresh)*bh)=true; % inside det box 判断每一个超级像素是否在边界箱内)
         
            end
        end
        ISall(:,16)=insidedet;
         ISall_all{kk_isall}=ISall;
        kk_isall=kk_isall+1;
        end
%          
    
  


        
 
end

save([ sceneInfo.imgFolder sceneInfo.sequence '-ISall_all.mat'],'ISall_all','-V7.3');

clear sp_labels;
end