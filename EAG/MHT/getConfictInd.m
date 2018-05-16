function [ confictInd ] = getConfictInd(observation, observationList)
    confictInd = [];
    for i = 1 : numel(observationList.x)
        cx1 = observation(1) - observation(3) / 2 + 0.5;
        cx2 = observation(1) + observation(3) / 2 - 0.5;
        cy1 = observation(2) - observation(4) / 2 + 0.5;
        cy2 = observation(2) + observation(4) / 2 - 0.5;

        gx1 = observationList.x(i) - observationList.w(i) / 2 + 0.5;
        gx2 = observationList.x(i) + observationList.w(i) / 2 - 0.5;
        gy1 = observationList.y(i) - observationList.h(i) / 2 + 0.5;
        gy2 = observationList.y(i) + observationList.h(i) / 2 - 0.5;
        
        ca =  observation(3) * observation(4);  %% area
        ga = observationList.w(i) * observationList.h(i);
        
        xx1 = max(cx1, gx1);
        yy1 = max(cy1, gy1);
        xx2 = min(cx2, gx2);
        yy2 = min(cy2, gy2);
        w = max(0, xx2 - xx1 + 1);
        h = max(0, yy2 - yy1 + 1);
        
        if (w * h / min(ca, ga) > 0.99) % min is for +conflict, max is for -conflict
            confictInd = [confictInd 1];
        else
            confictInd = [confictInd 0];
        end
    end
    
    confictInd = ~~confictInd;
end

