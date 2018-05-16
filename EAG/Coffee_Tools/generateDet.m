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
dataset = 'MOT_Challenge/2DMOT2015/test';
% dataset = 'MOT_Challenge/MOT16/train';
% dataset = 'MOT_Challenge/MOT16/test';
% dataset = 'PETSTUD';
listing = dir([baseDirectory dataset]);
ind = find([listing(:).isdir] == 1);
seqName = {listing(ind(3:end)).name};

for i = 1 : numel(seqName)
    detFilename = [baseDirectory dataset '/' seqName{i} '/det/det.txt'];
    detValue = load(detFilename);
    det = struct('x', [], 'y', [], 'w', [], 'h', [], 'r', [], 'fr', []);
    for j = 1 : size(detValue, 1)
        det.x = [det.x; detValue(j, 3)];
        det.y = [det.y; detValue(j, 4)];
        det.w = [det.w; detValue(j, 5)];
        det.h = [det.h; detValue(j, 6)];
        det.r = [det.r; detValue(j, 7)];
        det.fr = [det.fr; detValue(j, 1)];
    end
    det.bx = det.x;
    det.by = det.y;
    outputFilename = [baseDirectory dataset '/' seqName{i} '/det/det.mat'];
    cnn = load([baseDirectory dataset '/' seqName{i} '/det/cnn.txt']);
    det.cnn = cnn;
    size(det.cnn, 1)
    size(det.bx, 1)
    save(outputFilename, 'det');
end