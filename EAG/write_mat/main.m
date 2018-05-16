close all;
clear all,clc;

seqDirs = {'ADL-Rundle-6','ADL-Rundle-8','ETH-Bahnhof','ETH-Pedcross2',...
        'ETH-Sunnyday','KITTI-13','KITTI-17','PETS09-S2L1','TUD-Campus',...
        'TUD-Stadtmitte','Venice-2'  'PETS09-S1L1'   'PETS09-S1L2'  'PETS09-S2L1' ...
        'PETS09-S2L2'  'PETS09-S2L3','ADL-Rundle-1','ADL-Rundle-3','AVG-TownCentre',...
        'ETH-Crossing','ETH-Jelmoli','ETH-Linthescher','KITTI-16','KITTI-19',...
        'PETS09-S2L2','TUD-Crossing','Venice-1','MOT16-04','MOT16-11','MOT16-13'...
        ,'MOT16-03','MOT16-12','MOT16-14','MOT16-02','MOT16-05','MOT16-09'...
        ,'MOT16-10','MOT16-01','MOT16-06','MOT16-07','MOT16-08'};
seqLens = [525,654,1000,840,354,340,145,795,71,179,600];
seqLens=[seqLens   241  201 795 436 240];
seqLens=[seqLens   500,625,450,219,440,1194,209,1059,436,201,450];
seqLens=[seqLens  1050 900 750 ];
seqLens=[seqLens  1500 900 750 ];
seqLens=[seqLens  600 837 525 654 ];
seqLens=[seqLens  450 1194 500 625 ];
seqFPS = [30,30,14,14,14,10,10,7,25,25,30];
seqFPS=[seqFPS 7 7 7 7 7];
seqFPS=[seqFPS 30,30,3,14,14,14,10,10,7,2.5,30];  
seqFPS=[seqFPS 30 30 25 30 30 25 ];
seqFPS=[seqFPS 30 14 30 30 30 14 30 30 ];


training=1;
for mot=16
    for training=[0 ]
                
        if mot==15
     
        else
            seq_len=7;
            if training==1
                cur_seqDirs=seqDirs([28 29 30 34 35 36 37]);
                cur_seqFPS=seqFPS( [28 29 30 34 35 36 37]);
                cur_seqLens = seqLens( [28 29 30 34 35 36 37]);
                %all_file=['mot16/train/train_all.txt'];
                for i=1:7
                    seq_txt_file{i}=['mot16/train/' cur_seqDirs{i} '.txt'];
%                     seq_txt_tmp=dlmread( seq_txt_file{i});
%                     seq_txt_len(i)=length(seq_txt_tmp);
                end


            else
                cur_seqDirs=seqDirs( [31 32 33 38:41]);
                cur_seqFPS=seqFPS( [31 32 33 38:41]); 
                cur_seqLens = seqLens([31 32 33 38:41]);
%                 all_file=['mot16/test/test_all.txt'];
                for i=1:7
                    seq_txt_file{i}=['mot16/test/'  cur_seqDirs{i} '.txt'];
%  seq_txt_file{i}=['mot16/test/'  cur_seqDirs{i} '/det/det-dpm-raw' '.txt'];

%                      seq_txt_tmp=dlmread( seq_txt_file{i});
%                     seq_txt_len(i)=length(seq_txt_tmp);
                end

            end
        end


%         all_txt=dlmread(all_file);
        % 偏移量
off=0


        for i=[1:seq_len]
            detFile=seq_txt_file{i};
            detRaw=dlmread(detFile);
            det_tmp=detRaw;
            keep=find(detRaw(:,5)>0 & detRaw(:,6)>0);

            if size(detRaw,1)~=length(keep)
                detRaw=detRaw(keep,:);
                fprintf([detFile '有删除\n'])
            end
            %conf_hobj;
            cnndata=get_reid_txt(training,off+1,off+length(keep));
            off=off+length(keep);
          
            cnndata=cnndata';
            det.bx=detRaw(:,3);
            det.by=detRaw(:,4);
            det.w=detRaw(:,5);
            det.h=detRaw(:,6);
            det.x=det.bx;
            det.y=det.by;
            det.r=detRaw(:,7);
            det.r_old=det_tmp(:,7);
            det.fr=detRaw(:,1);
           % det.flag=detRaw(:,11);
            det.cnn=cnndata;
            txtfile=[cur_seqDirs{i} '.mat'];
            save(txtfile,'det','-v7.3');
off
        end
    end
end

