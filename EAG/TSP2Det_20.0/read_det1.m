
if k==1
    sceneInfo.frameNums=1:min(k+49,lastFrame);
else
    sceneInfo.frameNums=k-5:min(k+44,lastFrame);
end
detFile=sceneInfo.detFile;
detRaw=dlmread(detFile);
%标准化
% detRaw(:,7)=(detRaw(:,7)-min(detRaw(:,7)))/(max(detRaw(:,7))-min(detRaw(:,7)));

F = length(sceneInfo.frameNums);
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

end

% first defined frame and shift
ff = sceneInfo.frameNums(1);
fshift = ff-1;

for d=1:size(detRaw,1)
    t=detRaw(d,1);
    if isempty(intersect(t,sceneInfo.frameNums))
        continue;
    end
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
end
% if  g_para.is_use_high
%     
%     htobj=estimateTargetsSize(detections);%坐标为下中心
% end
alldpoints=createAllDetPoints(detections);
% alldpoints.sp=(alldpoints.sp-min(alldpoints.sp))/(max(alldpoints.sp)-min(alldpoints.sp));