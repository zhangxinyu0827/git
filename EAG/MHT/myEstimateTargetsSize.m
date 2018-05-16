function htobj=myEstimateTargetsSize(detRaw)
% Take best n percent of alldets
% and fit a 2d surface through their heights
% (cf. Sec. 5, Height.)


npercent = 25; % best 25 %


% alldets=parseDetections(sceneInfo);

allxi=[];allxi=[];allyi=[];allsc=[];allht=[];

% F=length(alldets);
% for t=1:F
allxi=detRaw(:,3)+detRaw(:,5)/2;
allyi=detRaw(:,4)+detRaw(:,6);
allsc=detRaw(:,7);
allht=detRaw(:,6);
% end
allxi=allxi';
allyi=allyi';
allht=allht';
[~, goodones]=sort(allsc,'descend'); goodones=goodones(1:round(length(goodones)/(1/npercent*100))); 
%goodones是最好的分数（回应）的前25%
allxi=allxi(goodones);allyi=allyi(goodones);allht=allht(goodones);

% special case, less than 3 detections found, fit anything
%小于3时，均采用此值
if length(goodones)<3
    allxi=[10,20,50];
    allyi=[20,30,40];
    allht=[80,90,95];
end
htobj=fit([allxi; allyi]',allht','poly11','Robust','on');
   %plot(htobj,[allxi ;allyi]',allht')
%11

% %% %% visualize
% clf
% 
% plot3(allxi,allyi,allht,'.'); box on
% xlim(sceneInfo.trackingArea(1:2));ylim(sceneInfo.trackingArea(3:4)); zlim([minheight sceneInfo.imgHeight]);
% set(gca,'Ydir','reverse');
% 
% hold on
% 
% %%
% 
% 
% [xi yi]=meshgrid(1:50:sceneInfo.imgWidth, 1:50:sceneInfo.imgHeight);
% htsurface=feval(fitobj,xi(:),yi(:)); htsurface=reshape(htsurface,size(xi,1),size(xi,2));
% htsurface(htsurface<minheight)=minheight;
% htsurface(htsurface>sceneInfo.imgHeight)=sceneInfo.imgHeight;
% surf(xi,yi,htsurface)
% view(-78,34)