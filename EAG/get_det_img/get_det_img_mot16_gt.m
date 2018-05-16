
clear all,clc;
devkitRoot = fullfile('..','devkit','devkit');     %get the devkit from the MOT challenge website for tracker evaluation purposes

addpath(genpath(devkitRoot));        
uniqueRunNum = 1;            
warning off




for mot=16
    for training=1
        %每次重新初始化
        get_det_img_mot_16_gt_init_seq;
             
            seqDirs=cur_seqDirs;
            seqFPS=cur_seqFPS;
            seqLens=cur_seqLens;

%make a directory to hold the output from the tracker
            resultsDir = fullfile('.','tracker output',['resultsRun_' int2str(uniqueRunNum)]);
            if  ~exist(resultsDir, 'dir')
                mkdir(resultsDir);
            end
% warming off;
            for seqNum = [1:seq_len]
            seqNum
                seqData.rootDir = rootDir;
                seqData.seqDir = seqDirs{seqNum};
                seqData.seqLen = seqLens(seqNum);
                seqData.seqFPS = seqFPS(seqNum);        
                seqData.inputVideoFile = fullfile(rootDir,seqDirs{seqNum},'img1');        
                if mot==15
                    seqData.inputDetections = fullfile(rootDir,seqDirs{seqNum},'det',[seqDirs{seqNum} '0_xml_new.txt']);    
                else
%                     seqData.inputDetections = fullfile(rootDir,seqDirs{seqNum},'det',[seqDirs{seqNum} '_det_final.txt']);    
%                         seqData.inputDetections = fullfile('DetectionSceneDetection',[seqDirs{seqNum} '.txt']);    
              seqData.inputDetections =  fullfile(rootDir,seqDirs{seqNum},'gt',[ 'gt.txt']);    
              
                end
                
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
det_data=det_data(find(det_data(:,8)==1),:);

% track.id=det_raw(:,2);
                  im=imread([seqData.inputVideoFile '/' sprintf('%06d.jpg',1)]);
                  [xx yy zz]=size(im);
                for det_i=1:size(det_data,1)
                    if det_i==1644
                        zanting=1;
                    end
                    im=imread([seqData.inputVideoFile '/' sprintf('%06d.jpg',det_data(det_i,1))]);
                    save_im=im(max(1,det_data(det_i,4)):min(  (det_data(det_i,4)+det_data(det_i,6)), xx),...
                                          max(1,det_data(det_i,3)):min(  (det_data(det_i,3)+det_data(det_i,5)), yy),:);
                     try
                     save_im137=imresize(save_im,[144 56]);
                    save_img_f137=[img_file137 '/' sprintf('%08d%08d.jpg',tmp_image_i,det_data(det_i,2))];
                    imwrite(save_im137,save_img_f137);
                    fprintf(fid137,'%s %d\n',save_img_f137 ,seqNum*10000+det_data(det_i,2));
                    
                      save_im333=imresize(save_im,[246 123]);
                    save_img_f333=[img_file333 '/' sprintf('%08d%08d.jpg',tmp_image_i,det_data(det_i,2))];
                    imwrite(save_im333,save_img_f333);
                    fprintf(fid333,'%s %d\n',save_img_f333 ,seqNum*10000+det_data(det_i,2));
                    
                    
                    tmp_image_i=tmp_image_i+1;
                     catch
                         fprintf('检测出错')
                         det_i
                         fid=fopen('errors_catch.txt','a+');
                         fprintf(fid,'%d  %d %d %d\n',[mot training seqNum det_i]);
                         fclose(fid);
%                            fid=fopen(txt_file,'a+');
                     end
                end
              
                zanting=1;

            end
%               fclose(fid);
  fclose(fid137);
    fclose(fid333);
    end
end