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
dataset = 'MOT_Challenge/MOT16/train';
% dataset = 'MOT_Challenge/MOT16/test';
% dataset = 'PETSTUD';
listing = dir([baseDirectory dataset]);
ind = find([listing(:).isdir] == 1);
seqName = {listing(ind(3:end)).name};

for i = 1 : 1%numel(seqName)
    detFilename = [baseDirectory dataset '/' seqName{i} '/det/det.mat'];
    load(detFilename);
    [~, ind] = sort(det.r);
    det.x = det.x(ind);
    det.y = det.y(ind);
    det.w = det.w(ind);
    det.h = det.h(ind);
    det.r = det.r(ind);
    det.fr = det.fr(ind);
    det.bx = det.bx(ind);
    det.by = det.by(ind);
    det.cnn = det.cnn(ind);
    
    histogram(det.r);
    
    find(det.r > 0, 'first')
    
    
%     imgSequence = cell(max(det.fr), 1);
%     for j = min(det.fr) : max(det.fr)
%         img = imread(sprintf([baseDirectory dataset '/' seqName{i} '/img1/%06d.jpg'], j));
%         imgSequence{j} = img;
%     end
%     
%     iw = size(img, 2);
%     ih = size(img, 1);
%     
%     for j = 1 : numel(det.x)
%         filename = sprintf([baseDirectory dataset '/' seqName{i} '/det_sort/%06d_%06d_%.03f.jpg'], j, det.fr(j), det.r(j));
%         x1 = max(1, floor(det.x(j)));
%         x2 = min(iw, floor(det.x(j) + det.w(j) - 1));
%         y1 = max(1, floor(det.y(j)));
%         y2 = min(ih, floor(det.y(j) + det.h(j) - 1));
%         img = imgSequence{det.fr(j)}(y1 : y2, x1 : x2, :);
%         imwrite(img, filename);
%     end
    
end