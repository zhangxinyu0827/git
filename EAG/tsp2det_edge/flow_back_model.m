
    
    read_det_for_fore_background;
    
   idx=f_i;
    load(flow_mat_f);
    
    fvx=flow.fvx;
    bvy=flow.bvy;
    fvy=flow.fvy;
    bvx= flow.bvx;
    if sum(seq_i==[2:6 17 20:22 24 30 32:34  37 38 40 41])>0

    
    id = find(det.fr(:) == idx);
    
    tt = 1;
    
    mask = zeros(size(fvx));
    x = [];
    y = [];
    z_fvx = [];
    z_fvy = [];
    z_bvx = [];
    z_bvy = [];
    for i = 1:length(id)     
                mask(max(1,det.by(id(i))):det.by(id(i))+det.h(id(i))...
                    ,max(1,det.bx(id(i))):det.bx(id(i))+det.w(id(i)))=1;
    end
%     
%     for i=1:length(fvx(1,:))
%         for j=1:length(fvx(:,1))
%             if mask(j,i) == 0
%                 x(tt) = i;
%                 y(tt) = j;
%                 z_fvx(tt) = fvx(j,i);
%                 z_fvy(tt) = fvy(j,i);
%                 z_bvx(tt) = bvx(j,i);
%                 z_bvy(tt) = bvy(j,i);
%                 tt = tt + 1;
%             end
%         end
%     end
mask=mask(1:size(fvx,1),1:size(fvx,2));
mask_t=find(mask);
mask_tmp=false(size(mask));
mask_tmp(mask_t)=1;
mask_tmp=~mask_tmp;
try
mask_tmp=find(mask_tmp);
sample_t=randperm(length(mask_tmp));
mask_tmp=mask_tmp(sample_t(1:100000));
catch
end
xx = repmat([1:1:length(fvx(1,:))],[length(fvx(:,1)) 1]);
 yy = repmat([1:1:length(fvx(:,1))]',[1 length(fvx(1,:))]);
x=xx(mask_tmp);    
y=yy(mask_tmp) ;
z_fvx = fvx(mask_tmp);
z_fvy = fvy(mask_tmp);
z_bvx = bvx(mask_tmp);
z_bvy = bvy(mask_tmp);
    fittedmodel_fvx = fit([x y],z_fvx,'poly33');%,'Robust','on');
    fittedmodel_fvy = fit([x y],z_fvy,'poly33');%,'Robust','on');
    fittedmodel_bvx = fit([x y],z_bvx,'poly33');%,'Robust','on');
    fittedmodel_bvy = fit([x y],z_bvy,'poly33');%,'Robust','on');
    
    
    r1 = fittedmodel_fvx(xx,yy);
    r_fvx = r1 - fvx;
    r1 = fittedmodel_fvy(xx,yy);
    r_fvy = r1 - fvy;
    r1 = fittedmodel_bvx(xx,yy);
    r_bvx = r1 - bvx;
    r1 = fittedmodel_bvy(xx,yy);
    r_bvy = r1 - bvy;
    else
        r_fvx =  fvx;
        r_fvy = fvy;
        r_bvx =  bvx;
        r_bvy = bvy;
    end