%将追踪的输出结果转化为轨迹图
%for追踪的视觉展示
%by  郝丽
%by  Xinyu  Zhang , 20170315

%zhangxinyu0827@buaa.edu.cn


figure();
tracks =det_data;
ppf = 2;
axis([0,sceneInfo.imgWidth,0,sceneInfo.imgHeight]);
ntracks = max(tracks(:,2));
for i =1:ntracks
    track = tracks(tracks(:,2) == i,:);
    frame = track(:,1);
    color = random('unif',0,1,1,3);
    
    xc = track(:,3) + track(:,5)/2;
    yc = track(:,4) + track(:,6);
%     if length(xc)>100
    x = xc;
    y = yc ;% + frame * ppf;
    line(x,sceneInfo.imgHeight-y,'color',color);
%     end
end
    
