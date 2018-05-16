load fore_TSP;
%有冗余，在时间邻接处，可以用unique消除
% 1为全局标签
% 2为所在帧
% 3，4为平均x,y
% 5为尺寸
% 6，7为左上角x，y
% 8，9为宽和高
%10,在前面是否有相同超像素，且在检测内，是计为1
%11,在后面是否有相同超像素，且在检测内，是计为1
%12前景分数

for fore_TSP_i=1:length(fore_TSP)
    
    tsp_box{fore_TSP_i}=fore_TSP{fore_TSP_i}(:,[1,3,4,5,11]);
    tsp_box{fore_TSP_i}(:,6)=max(1,tsp_box{fore_TSP_i}(:,3)-sqrt(tsp_box{fore_TSP_i}(:,5)));%左上角
    tsp_box{fore_TSP_i}(:,7)=max(1,tsp_box{fore_TSP_i}(:,4)-sqrt(tsp_box{fore_TSP_i}(:,5)));%左上角
    tsp_box{fore_TSP_i}(:,8)=sqrt(tsp_box{fore_TSP_i}(:,5))*2;%左上角
    tsp_box{fore_TSP_i}(:,9)=sqrt(tsp_box{fore_TSP_i}(:,5))*2;%左上角
    tsp_box{fore_TSP_i}(:,10:11)=0;
     tsp_box{fore_TSP_i}(:,12)=fore_TSP{fore_TSP_i}(:,14);
    fore_TSP_i_len=size(fore_TSP{fore_TSP_i},1);
    for fore_TSP_i_i=1:fore_TSP_i_len
        exist_forw=find((ISall_all{fore_TSP_i}(:,1)==tsp_box{fore_TSP_i}(fore_TSP_i_i,1)) ...
            &(ISall_all{fore_TSP_i}(:,3)==tsp_box{fore_TSP_i}(fore_TSP_i_i,2)+1)) ;
         exist_back=find((ISall_all{fore_TSP_i}(:,1)==tsp_box{fore_TSP_i}(fore_TSP_i_i,1)) ...
            &(ISall_all{fore_TSP_i}(:,3)==tsp_box{fore_TSP_i}(fore_TSP_i_i,2)-1) );
        if ~isempty(exist_forw)
            if ISall_all{fore_TSP_i}(exist_forw,16)
                tsp_box{fore_TSP_i}(fore_TSP_i_i,10)=1;
            end
        end
         if ~isempty(exist_back)
            if ISall_all{fore_TSP_i}(exist_back,16)
                tsp_box{fore_TSP_i}(fore_TSP_i_i,11)=1;
            end
        end
    end
end
%有冗余
save tsp_box tsp_box;






%  im1 = imread(sprintf(img_input_path, 1)); %% read an image
%  im1(1:28,120:120+28,:)=255;
% im1(149:149+27,193:193+27,:)=255;
% im1(1:21,145:145+21,:)=255;
% imshow(im1);