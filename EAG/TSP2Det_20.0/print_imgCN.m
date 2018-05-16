%read imgCN,将VB 背景画出
% 选取检测框外的超像素建立树（轨迹）
clear all,clc;
%设置参数
cur_data_all={'input/PETS09-S1L1';'input/PETS09-S1L2';'input/PETS09-S2L1';...
    'input/PETS09-S2L2';'input/PETS09-S2L3'};
lastFrame_all=[241 201 795 436 240];
for data_i= 1:2
    
    cur_data=cur_data_all{data_i};
% 0802zxy用于小规模调试
    firstFrame=1;
    lastFrame=lastFrame_all(data_i);




    set_para;
    for i=1:lastFrame
        cnfile=[cur_data '/imgCN/%06d.bmp'];
        cnfile_i=sprintf(cnfile,i);
        AA=imread(cnfile_i);
        AA(AA>0)=255;
        imshow(AA);
        % pause(0.5);
        imwrite(AA, [cur_data  sprintf('/imgVB/%06d.bmp',i)]); %%write the output image  
    end
end
