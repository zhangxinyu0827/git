
% 设置参数
addpath(genpath('TSP'));
addpath(genpath('eval_det'));
%0917
% 重要参数
fore_pick=150;
is_mot=2;%%2对应采用新的背景建模方法，1为米兰采样
flow_thresh=0.1;%光流阈值
fore_thresh=0.6;%前景阈值
indet_thresh=-0.05;%判别在检测内时，想检测框内部附加值

ex_next=10;%先后延伸数
 
dist_nearest=10;%在下一帧找距离最近放空间距离最近的10个，不参与权值的计算
dist_thresh=2;%在下一帧中找最近 的2个,直接进行返回
%暂时不用Lab信息,不用不行，只找位置就不会进行移动了
%均是和根节点求Lab距离
Lab_dist_thresh=0.2;%下一帧中Lab欧式距离阈值,标准化后,现在没有标准化
Lab_pa=0.99;%Lab占的比重,注意在新方法中设为0.95
max_next=2;%%在下一帧中最多延伸2个
min_own=0.5;%在树中最少有50%个节点才进行恢复
is_Lab=1;%是否在寻找下一个帧时使用Lab信息

is_use_high=1;%是否使用高度惩罚,用在最后生成新检测上，前面不用
%在生成新的检测时，不使用NMS，NMS是跟踪的算法，我们只负责生产检测
is_nms=0;%是否使用nms，用在最后生成新检测上，前面不用
nms_thtesh=0.85;%nms系数，用在最后生成新检测上，前面不用

del_keep=0.5;%剪枝后留下的好的分支的前50%
%% load TSP0805zxy
sp_lb_file=[sceneInfo.imgFolder '/sp-K800.mat'];
% load(sp_lb_file);
global g_para;
global sceneInfo;
%0805zxy

% cameraconffile = 'input/View_001.xml';
% camPar = parseCameraParameters(cameraconffile);
% %    
% sceneInfo.camPar=camPar;
% %0806zxy   sceneInfo.imgFolder
im_file=[sceneInfo.imgFolder '000001.jpg'];
img_input_path=[sceneInfo.imgFolder '%06d.jpg'];
im=imread(im_file);
sceneInfo.imgHeight=size(im,1);
sceneInfo.imgWidth=size(im,2);
clear im;


   if seq_i==9
      spfile=['tmp-' sceneInfo.sequence  '/ISall/0040-%d-%d-K800.mat'];
   elseif seq_i==10
       spfile=['tmp-' sceneInfo.sequence  '/ISall/0042-%d-%d-K800.mat'];
   elseif seq_i==26
        spfile=['tmp-' sceneInfo.sequence  '/ISall/0041-%d-%d-K800.mat'];
   else
        spfile=['tmp-' sceneInfo.sequence  '/ISall/0000-%d-%d-K800.mat'];
   end




g_para.cur_data=cur_data;
g_para.firstFrame=firstFrame;
g_para.lastFrame=lastFrame;
g_para.sp_lb_file=sp_lb_file;
% g_para.cameraconffile=cameraconffile;
g_para.img_input_path=img_input_path;
g_para.imgHeight=sceneInfo.imgHeight;
g_para.imgWidth=sceneInfo.imgWidth;
g_para.detFile= sceneInfo.detFile;
try
 g_para.gtFile= sceneInfo.gtFile;
catch
end
g_para.spfile=spfile;

g_para.flow_thresh=flow_thresh;
g_para.fore_thresh=fore_thresh;
g_para.indet_thresh=indet_thresh;
g_para.ex_next=ex_next;
g_para.dist_thresh=dist_thresh;
g_para.Lab_dist_thresh=Lab_dist_thresh;
g_para.max_next=max_next;
g_para.min_own=min_own;
g_para.is_Lab=is_Lab;
g_para.Lab_pa=Lab_pa;

g_para.is_use_high=is_use_high;%是否使用高度惩罚
g_para.is_nms=is_nms;%是否使用nms
g_para.nms_thtesh=nms_thtesh;%nms系数

g_para.del_keep=del_keep;
g_para.dist_nearest=dist_nearest;
g_para.is_mot=is_mot;
g_para.fore_pick=fore_pick;
g_para