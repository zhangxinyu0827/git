function det_new=getNewDet(tree_table_del,ISall_all)
%根据当前的树信息，恢复出一些新框
global sceneInfo;
global g_para;
warning off;
min_own=g_para.min_own;
 detFile=sceneInfo.detFile;
detRaw=dlmread(detFile);
% detRaw(:,7)=(detRaw(:,7)-min(detRaw(:,7)))/(max(detRaw(:,7))-min(detRaw(:,7)));
%存储的为做左上角信息
%3:6bx,by,w,h
det_new=[];
if g_para.is_use_high
    htobj=myEstimateTargetsSize(detRaw);
    keep_h=ones(size(detRaw,1),1);
    for ii=1:size(detRaw,1)
        h_pre=htobj(detRaw(ii,3)+detRaw(ii,5)/2,detRaw(ii,4)+detRaw(ii,6));
        if detRaw(ii,6)>1.5*h_pre  ||  detRaw(ii,6)<0.5*h_pre
            keep_h(ii)=0;
        end
      
    end
      detRaw=detRaw(find(keep_h),:);
end
% 高度重新标定置信度
if g_para.is_mot
else
[mR mT]=getRotTrans(sceneInfo.camPar);
muh=1.7; sigmah=.7; factorh=1/sigmah/sqrt(2*pi);
for det_i=1:size(detRaw,1)
    det_xi=detRaw(det_i,3)+detRaw(det_i,5)/2;
    det_yi=detRaw(det_i,4)+detRaw(det_i,6);;
    det_ht=detRaw(det_i,6);
    [xw yw zw]=imageToWorld(det_xi, det_yi,sceneInfo.camPar);



    [xiu yiu]=worldToImage(xw,yw,1000,mR,mT,sceneInfo.camPar.mInt,sceneInfo.camPar.mGeo);
    onemeteronimage=norm([det_xi det_yi]-[xiu yiu]);
    worldheight=det_ht/onemeteronimage; % in meters
    weight=normpdf(worldheight,muh,sigmah)/factorh;

   detRaw(det_i,7)=detRaw(det_i,7)*weight;
end
end


for ttdi=1:length(tree_table_del)
    %ttdi :  tree_table_del中的第i个记录
    fre_info=tree_table_del{ttdi}{3};
%     tsp_info=tree_table_del{ttdi}{1};
    x_info=tree_table_del{ttdi}{4};
    y_info=tree_table_del{ttdi}{5};
    tmp_det_own=[];%现在已经有的检测框
    for i_fre=1:length(fre_info)  %对于当前分支的，检测信息的获取
        fre_i=fre_info(i_fre);
        tmp_fre_i_ind=find(detRaw(:,1)==fre_i ...
            & x_info(i_fre)>detRaw(:,3) &   x_info(i_fre)<detRaw(:,3)+detRaw(:,5)...
            & y_info(i_fre)>detRaw(:,4) & y_info(i_fre)<detRaw(:,4)+detRaw(:,6) ) ;
        tmp_cur=detRaw(tmp_fre_i_ind,[1 3:7]);
        tmp_det_own=[tmp_det_own;tmp_cur] ;
        
    end
    if size(tmp_det_own,1)>min_own*g_para.ex_next;
        %若大于最低检测框量则进行修复
        fre_own=tmp_det_own(:,1);%我们目前有的信息
        x_own=tmp_det_own(:,2);
        y_own=tmp_det_own(:,3);
        w_own=tmp_det_own(:,4);
        h_own=tmp_det_own(:,5);
        s_own=tmp_det_own(:,6);%分数
        
        
        s_keep=find(s_own>0.4);
        s_own=s_own(s_keep);%分数
        x_own=x_own(s_keep);
        y_own=y_own(s_keep);
        w_own=w_own(s_keep);
        h_own=h_own(s_keep);
        fre_own=fre_own(s_keep);
        
        a_x2=polyfit(fre_own,x_own,2);%系数,避免龙格现象，采用2次
        a_y2=polyfit(fre_own,y_own,2);%
        a_w2=polyfit(fre_own,w_own,2);%
        a_h2=polyfit(fre_own,h_own,2);%
        
        a_x1=polyfit(fre_own,x_own,1);%系数,避免龙格现象，采用2次
        a_y1=polyfit(fre_own,y_own,1);%
        a_w1=polyfit(fre_own,w_own,1);%
        a_h1=polyfit(fre_own,h_own,1);%
        
        fre_other=setdiff(fre_info,fre_own);
        if  ~isempty(fre_other)
            x_pre2=polyval(a_x2,fre_other);%预测的检测信息
            y_pre2=polyval(a_y2,fre_other);
            w_pre2=polyval(a_w2,fre_other);
            h_pre2=polyval(a_h2,fre_other);
            
            x_pre1=polyval(a_x1,fre_other);%预测的检测信息
            y_pre1=polyval(a_y1,fre_other);
            w_pre1=polyval(a_w1,fre_other);
            h_pre1=polyval(a_h1,fre_other);
            pre_iou=[];
            pre_v=[];
            pre_fore=[];
            for pre_i=1:length(x_pre1)
                 pre_iou(pre_i,1)=boxiou(x_pre1(pre_i),y_pre1(pre_i),w_pre1(pre_i),...
                     h_pre1(pre_i),x_pre2(pre_i),y_pre2(pre_i),w_pre2(pre_i),h_pre2(pre_i));
%                  速度
                 pre_v(pre_i,1)=((2*fre_other(pre_i)*a_x2(1)+a_x2(2)).^2+...
                     (2*fre_other(pre_i)*a_y2(1)+a_y2(2)).^2+...
                     (2*fre_other(pre_i)*a_w2(1)+a_w2(2)).^2+...
                     (2*fre_other(pre_i)*a_h2(1)+a_h2(2)).^2).^0.5;
                 %前景数目，如果全为背景，则isAllback为1
%                  pre_fore(pre_i,1)=1-isAllback(ISall_all,fre_other(pre_i),x_pre2(pre_i),...
%                      y_pre2(pre_i),w_pre2(pre_i),h_pre2(pre_i));
                 pre_fore(pre_i,1)=1-isAllback1(fre_other(pre_i),x_pre2(pre_i),...
                     y_pre2(pre_i),w_pre2(pre_i),h_pre2(pre_i));
            end
%             自己拟合 的一个二次函数
            pre_v_a=polyfit([0,10,20],[1 0.8 0.4],2);
            pre_v_weight=polyval(pre_v_a,pre_v);
            own_len_weight=1-0.5*length(fre_other)/length(fre_info);
           
            
            
            new_i=-ones(length(x_pre1),10);%记录当前分支新生成的
%             老的方法
            s_pre=mean(s_own)*ones(length(x_pre1),1).*pre_iou;
            %新的方法
%             s_pre=mean(s_own)*ones(length(x_pre1),1).*own_len_weight...
%                 .*pre_v_weight.*pre_fore;
            new_i(:,[1 3:7])=[fre_other' x_pre2'  y_pre2' w_pre2' h_pre2'  s_pre];
            if g_para.is_use_high
                keep_h=ones(size(new_i,1),1);
                for ii=1:size(new_i,1)
                    h_pre2=htobj(new_i(ii,3)+new_i(ii,5)/2,new_i(ii,4)+new_i(ii,6));
                    if new_i(ii,6)>1.5*h_pre2  ||  new_i(ii,6)<0.5*h_pre2
                        keep_h(ii)=0;
                    end
                    
                end
                new_i=new_i(find(keep_h),:);
            end
           if ~isempty(new_i)  
                if isempty(find(isnan(new_i)))
                       det_new=[det_new;new_i];
                end
            end
			
			
        end
        
        
    end
end


% tmp_txt_name=[g_para.cur_data(7:end) '.txt'];
%  fid=fopen(tmp_txt_name,'a+');
%  for ii=1:size(det_new,1)
%  fprintf(fid,'%d,%d,%.2f,%.2f,%.2f,%.2f,%.2f,%d,%d,%d\n', det_new(ii,:));%
%  end
%  fclose(fid);
end