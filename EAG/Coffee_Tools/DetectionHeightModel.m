clear
clc

if ismac
    baseDirectory = '/Users/coffee/Dropbox (MIT)/Dataset/';   
elseif isunix
    error('Directory is not set yet!');
else
    error('Directory is not set yet!');
end

% dataset = 'MOT_Challenge/2DMOT2015/train';
% dataset = 'MOT_Challenge/2DMOT2015/test';
% dataset = 'MOT_Challenge/MOT16/train';
dataset = 'MOT_Challenge/MOT16/test';
% dataset = 'PETSTUD';

listing = dir([baseDirectory dataset]);
ind = find([listing(:).isdir] == 1);
seqName = {listing(ind(3:end)).name};

largecoeff = 1.8;
smallcoeff = 0.4;

for i = 4 : 4%numel(seqName)
    count = 0;
    
    img = imread([baseDirectory dataset '/' seqName{i} '/img1/000001.jpg']);
    [ih, iw, ~] = size(img);
    detFilename = [baseDirectory dataset '/' seqName{i} '/det/det.mat'];
    load(detFilename);
    
    det.x = det.x + det.w / 2;
    det.y = det.y + det.h - 1;
    
    dtX = 20;
    dtY = 20;
    xList = [];
    yList = [];
    wList = [];
    hList = [];
    for j = 1 : numel(det.x)
        if (det.r(j) >= 0)
            x = floor(det.x(j) / dtX) + 1;
            y = floor(det.y(j) / dtY) + 1;
            xList = [xList x];
            yList = [yList y];
            hList = [hList det.h(j)];
        end
    end
    
    net = trainModel([xList; yList], hList);

    xOutput = [];
    yOutput = [];
    zOutput = [];
    for j = 1 : max(xList)
        for k = 1 : max(yList)
            maxK = max(yList(xList == j));
            minK = min(yList(xList == j));
            xOutput(j, k) = j;
            yOutput(j, k) = k;
            if (~isempty(maxK)) && (k <= maxK) && (k >= minK)
                zOutput(j, k) = net([j; k]);
            else
                zOutput(j, k) = 0;
            end
        end
    end
    
    surfc(xOutput, yOutput, zOutput);
    set(gca,'ydir','reverse');

    imgSequence = cell(max(det.fr), 1);
    for j = min(det.fr) : max(det.fr)
        img = imread(sprintf([baseDirectory dataset '/' seqName{i} '/img1/%06d.jpg'], j));
        imgSequence{j} = img;
    end
    for j = 1 : numel(det.x)
        estimateZ = net([floor(det.x(j) / dtX) + 1; floor(det.y(j) / dtY) + 1]);
        if det.r(j) < 0 && det.h(j) > estimateZ * largecoeff
            count = count + 1;
            filename = sprintf([baseDirectory dataset '/' seqName{i} '/det_large/%06d_%06d_%.02f.jpg'], count, det.fr(j), det.r(j));
            x1 = max(1, floor(det.x(j) - det.w(j) / 2));
            x2 = min(iw, floor(det.x(j) - det.w(j) / 2 + det.w(j) - 1));
            y1 = max(1, floor(det.y(j) - det.h(j) + 1));
            y2 = min(ih, floor(det.y(j)));
            img = imgSequence{det.fr(j)}(y1 : y2, x1 : x2, :);
            img(floor(size(img, 1) - estimateZ), :, 1) = 255;
            img(floor(size(img, 1) - estimateZ), :, 2) = 0;
            img(floor(size(img, 1) - estimateZ), :, 3) = 0;
            imwrite(img, filename);           
        end
        if det.r(j) < 0 && det.h(j) < estimateZ * smallcoeff
            count = count + 1;
            filename = sprintf([baseDirectory dataset '/' seqName{i} '/det_small/%06d_%06d_%.02f.jpg'], count, det.fr(j), det.r(j));
            x1 = max(1, floor(det.x(j) - det.w(j) / 2));
            x2 = min(iw, floor(det.x(j) - det.w(j) / 2 + det.w(j) - 1));
            y1 = max(1, floor(det.y(j) - estimateZ + 1));
            y2 = min(ih, floor(det.y(j)));
            img = imgSequence{det.fr(j)}(y1 : y2, x1 : x2, :);
            img(floor(size(img, 1) - det.h(j)), :, 1) = 255;
            img(floor(size(img, 1) - det.h(j)), :, 2) = 0;
            img(floor(size(img, 1) - det.h(j)), :, 3) = 0;
            imwrite(img, filename);           
        end
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