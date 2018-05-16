
% load_det;
det = loadDet(det_input_path{i}, other_param);
keep_ind=find(det.r>0);
det.bx=det.bx(keep_ind);
det.by=det.by(keep_ind);
det.w=det.w(keep_ind);
det.h=det.h(keep_ind);
det.x=det.x(keep_ind);
det.y=det.y(keep_ind);
det.r=eps+(det.r(keep_ind)-min(det.r(keep_ind)))/(max(det.r(keep_ind))-min(det.r(keep_ind)));
det.fr=det.fr(keep_ind);
det.cnn=det.cnn(keep_ind,:);
try
det.flag=det.flag(keep_ind,:);
catch
    
end
% 
detRaw=[det.fr];
detRaw(:,2)=1;
detRaw=[detRaw  det.bx  det.by  det.w  det.h det.r];

detRaw(:,8)=-1;
detRaw(:,9)=-1;
try
detRaw(:,11)=det.flag;
catch
end
F = max(det.fr);
frToParse=1:F;
%     if nargin==2, frToParse=frames; end
%     frToParse

for t=frToParse
    detections(t).bx=[];
    detections(t).by=[];
    detections(t).xi=[];
    detections(t).yi=[];
    detections(t).xp=[];
    detections(t).yp=[];
    detections(t).wd=[];
    detections(t).ht=[];
    detections(t).sc=[];
    detections(t).flag=[];
end

% first defined frame and shift
ff = 1;
fshift = ff-1;

for d=1:size(detRaw,1)
    t=detRaw(d,1);
    
    w=detRaw(d,5);
    h=detRaw(d,6);
    bx=detRaw(d,3);
    by=detRaw(d,4);
    xi=detRaw(d,3)+w/2;
    yi=detRaw(d,4)+h;
    sc=detRaw(d,7);
    
    tshft = t-fshift;
    detections(tshft).bx=[detections(tshft).bx bx];
    detections(tshft).by=[detections(tshft).by by];
    detections(tshft).xi=[detections(tshft).xi xi];
    detections(tshft).yi=[detections(tshft).yi yi];
    detections(tshft).xp=[detections(tshft).xp xi];
    detections(tshft).yp=[detections(tshft).yp yi];
    detections(tshft).wd=[detections(tshft).wd w];
    detections(tshft).ht=[detections(tshft).ht h];
    detections(tshft).sc=[detections(tshft).sc sc];
    try
        flag=detRaw(d,11);
         detections(tshft).flag=[detections(tshft).flag flag];
    catch
    end
    
end
% if  g_para.is_use_high
%     
%     htobj=estimateTargetsSize(detections);%坐标为下中心
% end
alldpoints=createAllDetPoints(detections);
% alldpoints.sp=(alldpoints.sp-min(alldpoints.sp))/(max(alldpoints.sp)-min(alldpoints.sp));