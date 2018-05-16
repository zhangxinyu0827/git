function stateInfo=segTracking(sceneFile,opt)
% for compute ISall
%for LIBAO main function
%by  Xinyu  Zhang , 20170315

%zhangxinyu0827@buaa.edu.cn


addpath(genpath('./mex'))

global seq_i seqLens seqDirs;

% global scenario gtInfo opt detections stStartTime htobj labdet
global sceneInfo detections gtInfo glopt scenario ColorName cncell bgimg mask

%% prepare
stStartTime=tic;

% scenario=25;

% parameters
% if nargin>0, scenario=scen; end
% frames=1:30;

if ~isfield(opt,'frames'), opt.frames = 1:length(sceneInfo.frameNums); end
frames=opt.frames;



F=length(frames);
% opt.maxRemove=0;
% opt.canvel=3;

% set random seed for deterministic results
rng(1); 

% get info about sequence
sceneInfo = parseScene(sceneFile);
scenario=sceneInfo.scenario;
sceneInfo.detFile=[sceneInfo.detFile(1:end-7)  seqDirs{seq_i} '_det.txt'];
%% camera，解析相机（没有读懂）
cameraconffile=[];
if opt.track3d
    cameraconffile = './data/View_001.xml';
    cameraconffile = './data/TUD-Stadtmitte-calib.xml';
end
sceneInfo.camFile=cameraconffile;

if ~isempty(sceneInfo.camFile)
    sceneInfo.camPar = parseCameraParameters(sceneInfo.camFile);
end

sceneInfo.frameNums=sceneInfo.frameNums(frames);




% now parse detection for specified frames
[detections, nPoints]=parseDetections(sceneInfo,opt);
fprintf('%d detections read\n',nPoints);
alldpoints=createAllDetPoints(detections);



sceneInfo.targetSize = mean(alldpoints.wd)/2;
%sceneInfo.targetSize = 350;


% opt=readSTOptions('config/default2d.ini');
sceneInfo.imTopLimit=0;




K= opt.nSP;
fprintf('Approx. %d superpixels per frame\n',K);
avgMinDetDistF=avgMinDetDist(detections);
% avgMinDetDistF;

%% all ims, all flows
fprintf('Precomputing helper structures\n');
% [~, iminfo, sp_labels, ISall, IMIND, seqinfo, SPPerFrame] = ...
%     precompAux(scenario,sceneInfo,K,frames);

[sp_labels,seqinfo, ISall, SPPerFrame] = ...
    precompAux_my_sp1200(scenario,sceneInfo,K,frames);
stateInfo=1;

end

