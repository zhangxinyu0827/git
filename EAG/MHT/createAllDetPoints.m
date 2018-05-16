function alldpoints=createAllDetPoints(detections)
% put all data points (detections) into one struct
% 
%%zxy0721
% xp，yp三维信息
% sp分数，tp帧信息
% bx，by，xi，yi位置信息，wd，ht宽高

T=size(detections,2); 
alldpoints.xp=[];alldpoints.yp=[];alldpoints.sp=[];alldpoints.tp=[];
alldpoints.bx=[];alldpoints.by=[];alldpoints.wd=[];alldpoints.ht=[];
alldpoints.flag=[];
%%zxy0720
alldpoints.xi=[];alldpoints.yi=[];


if isfield(detections(1),'dirxi'), alldpoints.dirxi=[]; alldpoints.diryi=[]; end
if isfield(detections(1),'dirxw'), alldpoints.dirxw=[]; alldpoints.diryw=[]; end
if isfield(detections(1),'dirx'), alldpoints.dirx=[]; alldpoints.diry=[]; end
for t=1:T
    %zxy1221
%     alldpoints.flag=[alldpoints.flag detections(t).flag];
    alldpoints.xp=[alldpoints.xp detections(t).xp];
    
    alldpoints.yp=[alldpoints.yp detections(t).yp];
    
    %%zxy0720
    alldpoints.xi=[alldpoints.xi detections(t).xi];
    alldpoints.yi=[alldpoints.yi detections(t).yi];
    
    %%%
    alldpoints.sp=[alldpoints.sp detections(t).sc];
    alldpoints.bx=[alldpoints.bx detections(t).bx];
    alldpoints.by=[alldpoints.by detections(t).by];
    alldpoints.wd=[alldpoints.wd detections(t).wd];
    alldpoints.ht=[alldpoints.ht detections(t).ht];
    
    alldpoints.tp=[alldpoints.tp t*ones(1,length(detections(t).xp))];    

    
    if isfield(detections(t),'dirxi')
        alldpoints.dirxi=[alldpoints.dirxi detections(t).dirxi];
        alldpoints.diryi=[alldpoints.diryi detections(t).diryi];
    end
    if isfield(detections(t),'dirxw')
        alldpoints.dirxw=[alldpoints.dirxw detections(t).dirxw];
        alldpoints.diryw=[alldpoints.diryw detections(t).diryw];
    end
    if isfield(detections(t),'dirx')
        alldpoints.dirx=[alldpoints.dirx detections(t).dirx];
        alldpoints.diry=[alldpoints.diry detections(t).diry];
    end
end