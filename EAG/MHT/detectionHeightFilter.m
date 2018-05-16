function [observation] = detectionHeightFilter(observation, other_param)
    xList = [];
    yList = [];
    hList = [];
    for i = 1 : numel(observation.x)
        if (observation.r(i) > other_param.scForTrain)
            x = floor(observation.x(i) / other_param.dtX) + 1;
            y = floor(observation.y(i) / other_param.dtY) + 1;
            xList = [xList x];
            yList = [yList y];
            hList = [hList observation.h(i)];
        end
    end
    
    net = trainModel([xList; yList], hList);
    
    idx = [];
    for i = 1 : numel(observation.x)
        height = net([floor(observation.x(i) / other_param.dtX) + 1; floor(observation.y(i) / other_param.dtY) + 1]);
        if (observation.r(i) < other_param.confscHeight) && (observation.h(i) > height * other_param.coeffHeightLarge)
            idx = [idx 1];
        elseif (observation.r(i) < other_param.confscHeight) && (observation.h(i) < height * other_param.coeffHeightSmall)
            idx = [idx 1];
        else
            idx = [idx 0];
        end
    end
    idx = ~~idx;
    
    observation.x(idx) = [];
    observation.y(idx) = [];
    observation.bx(idx) = [];
    observation.by(idx) = [];
    observation.w(idx) = [];
    observation.h(idx) = [];
    observation.r(idx) = [];
    observation.fr(idx) = [];
    
    if other_param.isAppModel
        observation.app(idx, :) = [];
    end     
end

function [net] = trainModel(featureVector, hVector)
    x = featureVector;
    t = hVector;
    trainFcn = 'trainlm';
    hiddenLayerSize = 3;
    net = fitnet(hiddenLayerSize,trainFcn);
    net.divideParam.trainRatio = 80/100;
    net.divideParam.valRatio = 20/100;
    net.divideParam.testRatio = 0/100;
    net.trainParam.showWindow = 0;
    [net, ~] = train(net,x,t);
end