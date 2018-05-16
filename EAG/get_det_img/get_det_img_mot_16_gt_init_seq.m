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


            if mot==15
                trackerResourcesRoot = fullfile('..','2DMOT2015');
                    seq_len=11;
                    if training==1
                         rootDir = fullfile(trackerResourcesRoot,'train');
                        cur_seqDirs=seqDirs(1:11);
                        cur_seqFPS=seqFPS(1:11);
                        cur_seqLens = seqLens(1:11);   
                        
                        img_file=['mot15/train'];
                        mkdir(img_file);
                        tmp_image_i=1;
                        txt_file=['mot15/'  'mot_train15.txt'];
                        fid=fopen(txt_file,'a+');

                    else
                        rootDir = fullfile(trackerResourcesRoot,'test');
                        cur_seqDirs=seqDirs(17:27);
                        cur_seqFPS=seqFPS(17:27);   
                        cur_seqLens = seqLens(17:27);   
                        img_file=['mot15/test'];
                        mkdir(img_file);
                        tmp_image_i=1;
                        txt_file=['mot15/'  'mot_test15.txt'];
                        fid=fopen(txt_file,'a+');


                    end
            else
                    
                    trackerResourcesRoot = fullfile('..','MOT16');
                    seq_len=7;
                    if training==1
                        rootDir = fullfile(trackerResourcesRoot,'train');
                        cur_seqDirs=seqDirs([28 29 30 34 35 36 37]);
                        cur_seqFPS=seqFPS( [28 29 30 34 35 36 37]);
                        cur_seqLens = seqLens( [28 29 30 34 35 36 37]);
                       img_file137=['mot16gt137/train'];
                        mkdir(img_file137);
                        tmp_image_i=1;
                        txt_file137=['mot16gt137/'  'mot_train16.txt'];
                        fid137=fopen(txt_file137,'a+');
                        
                        
                        img_file333=['mot16gt333/train'];
                        mkdir(img_file333);
                        tmp_image_i=1;
                        txt_file333=['mot16gt333/'  'mot_train16.txt'];
                        fid333=fopen(txt_file333,'a+');

                    else
                        rootDir = fullfile(trackerResourcesRoot,'test');
                        cur_seqDirs=seqDirs( [31 32 33 38:41]);
                        cur_seqFPS=seqFPS( [31 32 33 38:41]); 
                        cur_seqLens = seqLens([31 32 33 38:41]);
                        img_file137=['mot16gt137/test'];
                        mkdir(img_file137);
                        tmp_image_i=1;
                        txt_file137=['mot16gt137/'  'mot_test16.txt'];
                        fid137=fopen(txt_file137,'a+');
                        
                        
                        img_file333=['mot16gt333/test'];
                        mkdir(img_file333);
                        tmp_image_i=1;
                        txt_file333=['mot16gt333/'  'mot_test16.txt'];
                        fid333=fopen(txt_file333,'a+');

                    end
            end
