% Copyright (c) 2015 Niall McLaughlin, CSIT, Queen's University Belfast, UK
% Contact: nmclaughlin02@qub.ac.uk
% If you use this code please cite:
% "Enhancing Linear Programming with Motion Modeling for Multi-target Tracking",
% N McLaughlin, J Martinez Del Rincon, P Miller, 
% IEEE Winter Conference on Applications of Computer Vision (WACV), 2015 
% 
% This software is licensed for research and non-commercial use only.
% 
% The above copyright notice and this permission notice shall be included in
% all copies or substantial portions of the Software.
% 
% THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
% IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
% FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
% AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
% LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
% OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
% THE SOFTWARE.


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% MOT Challenge tracker harness
% http://motchallenge.net/
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear all,clc;
clear vars

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% NOTE - MODIFY FOLLOWING  TWO LINES TO POINT TO DEVKIT & SEQUENCES
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
devkitRoot = fullfile('..','devkit','devkit');     %get the devkit from the MOT challenge website for tracker evaluation purposes
trackerResourcesRoot = fullfile('..','MOT16'); %set to the directory containing the images and detections for MOT challenge 

addpath(genpath(devkitRoot));        
uniqueRunNum = 1;            
doTraining = -1;    
warning off
if doTraining==1
    rootDir = fullfile(trackerResourcesRoot,'train');
        seqDirs = {'ADL-Rundle-6','ADL-Rundle-8','ETH-Bahnhof','ETH-Pedcross2',...
        'ETH-Sunnyday','KITTI-13','KITTI-17','PETS09-S2L1','TUD-Campus',...
        'TUD-Stadtmitte','Venice-2'  'PETS09-S1L1'   'PETS09-S1L2'  'PETS09-S2L1' ...
        'PETS09-S2L2'  'PETS09-S2L3','ADL-Rundle-1','ADL-Rundle-3','AVG-TownCentre',...
        'ETH-Crossing','ETH-Jelmoli','ETH-Linthescher','KITTI-16','KITTI-19',...
        'PETS09-S2L2','TUD-Crossing','Venice-1'};
    seqLens = [525,654,1000,840,354,340,145,795,71,179,600];
    seqFPS = [30,30,14,14,14,10,10,7,25,25,30];
    seqLens=[seqLens   241  201 795 436 240];
    seqFPS=[seqFPS 7 7 7 7 7];
    seqLens=[seqLens 500,625,450,219,440,1194,209,1059,436,201,450];
    seqFPS=[seqFPS 30 30 14 14 14 10 10 7 2.5 30];
    
elseif doTraining==0
    rootDir = fullfile(trackerResourcesRoot,'test');
    seqDirs = {'ADL-Rundle-1','ADL-Rundle-3','AVG-TownCentre',...
        'ETH-Crossing','ETH-Jelmoli','ETH-Linthescher','KITTI-16'...
        ,'KITTI-19','PETS09-S2L2','TUD-Crossing','Venice-1'};
    seqLens = [500,625,450,219,440,1194,209,1059,436,201,450];
    seqFPS = [30,30,3,14,14,14,10,10,7,2.5,30];   
    elseif doTraining==-1  %mot16train
          rootDir = fullfile(trackerResourcesRoot,'train');
    seqDirs = {'MOT16-02','MOT16-04','MOT16-05','MOT16-09','MOT16-10','MOT16-11','MOT16-13'};
    seqLens = [600 1050 837 525 654 900 750];
    seqFPS = [30,30, 14 30 30 30 25];   
       elseif doTraining==-2  %mot16test
          rootDir = fullfile(trackerResourcesRoot,'test');
    seqDirs = {'MOT16-01','MOT16-03','MOT16-06','MOT16-07','MOT16-08','MOT16-12','MOT16-14'};
    seqLens = [450 1500 1194 500 625 900 750];
    seqFPS = [30,30, 14 30 30 30 25];   
    
    
    
    
end

%make a directory to hold the output from the tracker
resultsDir = fullfile('.','tracker output',['resultsRun_' int2str(uniqueRunNum)]);
if  ~exist(resultsDir, 'dir')
    mkdir(resultsDir);
end
% warming off;
   for seqNum = [1:7]
seqNum
            seqData.rootDir = rootDir;
            seqData.seqDir = seqDirs{seqNum};
            seqData.seqLen = seqLens(seqNum);
            seqData.seqFPS = seqFPS(seqNum);        
            seqData.inputVideoFile = fullfile(rootDir,seqDirs{seqNum},'img1');        
            seqData.inputDetections = fullfile(rootDir,seqDirs{seqNum},'det','det.txt');    
            seqData.CSVOutputFile = fullfile(resultsDir,[seqDirs{seqNum} '.txt']);

            % The following parameters control the tracker behaviour

            trackerConf.maxIters = 2;                       % the 1st iteration links detections using unary costs, later iterations link tracklets using motion costs
            trackerConf.linkEnergyThreshold = 100;          % maximum 'energy', measured by average deviation in pixels from linear tracklet motion, allowed when linking tracklets
            trackerConf.heightsPerSec = 3;                  % distance threshold used when linking detections. Relative to detection height which means it scales well with different video resolution / distance from the camera
            trackerConf.appearanceThreshold = 0.1;          % appearance similarity threshold to prevent detections with very different apppearance from linking
            trackerConf.doDetectionPreProcessing = true;    % apply NMS to detections before doing tracking

            trackerConf.nmsThreshold = 0.5;                 % threshold used by NMS 
            trackerConf.doFilterTracklets = true;           % remove short tracklets as these may be false positives
            trackerConf.maxFrameJump = 2;                   % max frame gap between detections allowed in first iteration
            trackerConf.maxFrameJumpMultiplier = 7;         % max frame gap * (nIterations - 1) between tracklets allowed in iterations > 1
            
            
            det_data=dlmread(seqData.inputDetections);
            img_file=['test/' seqData.seqDir];
             mkdir(img_file);
             tmp_image_i=1;
             txt_file=['test/' seqData.seqDir '.txt'];
             fid=fopen(txt_file,'a+');
              im=imread([seqData.inputVideoFile '/' sprintf('%06d.jpg',1)]);
              [xx yy zz]=size(im);
            for det_i=1:size(det_data,1)
         
                im=imread([seqData.inputVideoFile '/' sprintf('%06d.jpg',det_data(det_i,1))]);
                save_im=im(max(1,det_data(det_i,4)):min(  (det_data(det_i,4)+det_data(det_i,6)), xx),...
                                      max(1,det_data(det_i,3)):min(  (det_data(det_i,3)+det_data(det_i,6)), yy),:);
                 try
                 save_im=imresize(save_im,[144 56]);
                save_img_f=[img_file '/' sprintf('%08d.jpg',tmp_image_i)];
                 imwrite(save_im,save_img_f);
                 fprintf(fid,'%s 0\n',save_img_f);
                tmp_image_i=tmp_image_i+1;
                 catch
                     fprintf('检测出错')
                     det_i
                     fid=fopen('errors_catch','a+');
                     fprintf(fid,'%d  %d %d 0\n',save_img_f);
                 end
            end
            fclose(fid);
            zanting=1;
  
        end
