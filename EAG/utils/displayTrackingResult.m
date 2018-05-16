function displayTrackingResult(sceneInfo, stateInfo)
% Display Tracking Result
%
% Take scene information sceneInfo and
% the tracking result from stateInfo
% 
% 
% (C) Anton Andriyenko, 2012
%
% The code may be used free of charge for non-commercial and
% educational purposes, the only requirement is that this text is
% preserved within the derivative work. For any other purpose you
% must contact the authors for permission. This code may not be
% redistributed without written permission from the authors.

% [~, ~, ~, ~, X Y]=getStateInfo(stateInfo);
W=stateInfo.W;
H=stateInfo.H;
Xi=stateInfo.Xi;
Yi=stateInfo.Yi;

options.defaultColor=[.1 .2 .9];
options.grey=.7*ones(1,3);
options.framePause=0.01; % pause between frames

options.traceLength=10; % overlay track from past n frames
options.dotSize=10;
options.boxLineWidth=2;
options.traceWidth=2;

options.hideBG=0;

% what to display
options.displayDots=0;
options.displayBoxes=1;
options.displayID=0;
options.displayCropouts=0;
options.displayConnections=0;

% save?
options.outFolder='./output/';

% Xi = Xi(120 : end, :);
% Yi = Yi(120 : end, :);
% W = W(120 : end, :);
% H = H(120 : end, :);
% stateInfo.frameNums = 120 : 220;
reopenFig('Tracking Results')
displayBBoxes(sceneInfo,stateInfo.frameNums,Xi,Yi,W,H,options)


end