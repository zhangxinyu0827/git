function stateInfo=my_swSegTracker(varargin)
%将追踪的输出结果转化为stateInfo，便于处理
%for追踪的视觉展示
%by  Xinyu  Zhang , 20170315
%zhangxinyu0827@buaa.edu.cn


% parse input parameters
p = inputParser;
addOptional(p,'scene','config/scene.ini');
addOptional(p,'params','config/params.ini');

parse(p,varargin{:});


% add paths
addpath(genpath('./utils'))
addpath(genpath('./external'))

% get scene information and parameters
sceneFile = p.Results.scene;
sceneInfo = parseScene(sceneFile);
opt=parseOptions(p.Results.params);

stateInfo = [];


% do entire sequence in small batches (default 50)
allframeNums=sceneInfo.frameNums;
FF=length(allframeNums);
fromframe=1; toframe=min(FF,opt.winSize);
wincnt=0;allwins=[];
allstInfo=[];


sceneInfo = parseScene(sceneFile);

cn_path = strrep(sceneInfo.imgFolder,'img1','imgCN');
cnimg_files = cellstr(num2str(allframeNums','%06d.bmp'));

global cncell


detections=parseDetections(sceneInfo,opt);
K= opt.nSP;

det_data=dlmread([ sceneInfo.sequence '.txt']);
tra_num=unique(det_data(:,2));
stateInfo.Xi=zeros(length(sceneInfo.frameNums),length(tra_num));


stateInfo.Yi=zeros(length(sceneInfo.frameNums),length(tra_num));
stateInfo.W=zeros(length(sceneInfo.frameNums),length(tra_num));
stateInfo.H=zeros(length(sceneInfo.frameNums),length(tra_num));
tmp_i=1;
stateInfo.frameNums=sceneInfo.frameNums;
for tra_i=tra_num' 
    fram_tmp=find(det_data(:,2)==tra_i);
%     stateInfo.Xi(det_data(fram_tmp,1),tmp_i)=det_data(det_data(fram_tmp,1),3);%+det_data(det_data(fram_tmp,1),5)/2;
%     stateInfo.Yi(det_data(fram_tmp,1),tmp_i)=det_data(det_data(fram_tmp,1),4);%+det_data(det_data(fram_tmp,1),6);
%   
%     stateInfo.W(det_data(fram_tmp,1),tmp_i)=det_data(det_data(fram_tmp,1),5);
%     stateInfo.H(det_data(fram_tmp,1),tmp_i)=det_data(det_data(fram_tmp,1),6);
%     
      stateInfo.Xi(det_data(fram_tmp,1),tmp_i)=det_data(fram_tmp,3)+det_data((fram_tmp),5)/2;
    stateInfo.Yi(det_data(fram_tmp,1),tmp_i)=det_data(fram_tmp,4)+det_data((fram_tmp),6);
  
    stateInfo.W(det_data(fram_tmp,1),tmp_i)=det_data(fram_tmp,5);
    stateInfo.H(det_data(fram_tmp,1),tmp_i)=det_data(fram_tmp,6);
    tmp_i=tmp_i+1;
    
end
 displayTrackingResult(sceneInfo,stateInfo);

genTracksGraph;
 
