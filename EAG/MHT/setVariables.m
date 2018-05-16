%% set observations
%0731zxy剪取置信度较低的节点
% observation = cutDetections(observation,other_param);
%选择是否有app维
[observation other_param] = selectAppFeat(observation, other_param);


%% declare variables声明变量
appTreeSet = [];
obsTreeSet = [];
stateTreeSet = [];
scoreTreeSet = []; 
idTreeSet = [];
incompabilityListTreeSet = [];   
incompabilityListTreeNodeIDSet = [];  
activeTreeSet = [];
obsTreeSetConfirmed = [];
stateTreeSetConfirmed = [];
scoreTreeSetConfirmed = [];
activeTreeSetConfirmed = [];
selectedTrackIDs = [];
trackFamilyPrev = [];
trackIDtoRegInd = [];
firstFrame = min(observation.fr);
%zxy0806
firstFrame = 1;
lastFrame = max(observation.fr);
familyID = 1;
trackID = uint64(1);    


%% graph solver
other_param.const = 10;