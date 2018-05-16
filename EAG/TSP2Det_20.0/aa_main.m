% 选取检测框外的超像素建立树（轨迹）
clear all,clc;
%设置参数
cur_data_all={'input/PETS09-S1L1';'input/PETS09-S1L2';'input/PETS09-S2L1';...
    'input/PETS09-S2L2';'input/PETS09-S2L3'};
lastFrame_all=[241 201 795 436 240];
for data_i= 3:5
    
    cur_data=cur_data_all{data_i};
% 0802zxy用于小规模调试
    firstFrame=1;
    lastFrame=lastFrame_all(data_i);
    % s1l1  241  201
    % s2 795 436 240


    set_para;
    ISall_all=ReadData();
    % read_data;
    %根据分数输出图像
    % print_fore_Q;
    %为检测画框
    % print_box; 
    %对每一个选出的TSP 输出一帧
    % print_tsp_figure;
    %对每一个选出的TSP 输出，逐帧输出

    % print_tsp_fre_figure;
    %将在检测外的，且为前景 的输出，逐个输出，输出为mat文件
    fore_TSP=PrintTspMat(ISall_all);
%用差分制作前景
% make_fore;
    %便于测试
    % save ISall_all ISall_all;
%     load([g_para.cur_data(7:end) '-ISall_all.mat']);
    % save  fore_TSP fore_TSP;
%     load ([g_para.cur_data(7:end) '-fore_TSP.mat']);
    % for iiitest=1:10
    iiitest=0
    % g_para.Lab_pa=0.9+0.01*iiitest;

    %将前景漏检超像素以框的形式输出,mat
    % print_tsp_box;
    %将前景漏检超像素以框的形式输出,txt
    % print_tsp_box_txt;

    % 建树,向后
     fprintf('BuildTree\n');
    tree_table=BuildTree(fore_TSP,ISall_all);
    % load tree_table;
%     load ([g_para.cur_data(7:end) '-tree_table.mat']);

    %建树,向前
    tree_table_q=BuildTree_q(fore_TSP,ISall_all);
    % load tree_table_q;
%       load ([g_para.cur_data(7:end) '-tree_table_q.mat']);


    % 树的剪枝向后
     fprintf('delTree\n');
    tree_table_del=delTree(tree_table);
    % load tree_table_del;
%     load ([g_para.cur_data(7:end) '-tree_table_del.mat']);

    %树的剪枝向前

    tree_table_del_q=delTree_q(tree_table_q);
    % load tree_table_del_q;
%     load ([g_para.cur_data(7:end) '-tree_table_del_q.mat']);


    % 输出树对应的tsp序列，对于tree_table向后
    % write_tsp_figure;

    % 输出树对应的tsp序列，对于tree_table向前
    % write_tsp_figure_q;

    % 输出树对应的tsp序列，对于tree_table_del向后
    % write_tsp_figure2;

    % 输出树对应的tsp序列，对于tree_table_del向前
    % write_tsp_figure2_q;
     fprintf('getNewDet\n');
    det_new=getNewDet(tree_table_del,ISall_all);
    det_new_q=getNewDet(tree_table_del_q,ISall_all);

    tmp_txt_name=[g_para.cur_data(7:end) num2str(iiitest) '.txt'];
     fid=fopen(tmp_txt_name,'w+');
     for ii=1:size(det_new,1)
     fprintf(fid,'%d,%d,%.2f,%.2f,%.2f,%.2f,%.6f,%d,%d,%d\n', det_new(ii,:));%
     end
     fclose(fid);
    % 
      tmp_txt_name=[g_para.cur_data(7:end) num2str(iiitest) '_q.txt'];
     fid=fopen(tmp_txt_name,'w+');
     for ii=1:size(det_new_q,1)
     fprintf(fid,'%d,%d,%.2f,%.2f,%.2f,%.2f,%.6f,%d,%d,%d\n', det_new_q(ii,:));%
     end
     fclose(fid);
     
     tmp_txt_name=[g_para.cur_data(7:end) num2str(iiitest) '_all.txt'];
     fid=fopen(tmp_txt_name,'w+');
     det_new_all=[det_new;det_new_q];
     for ii=1:size(det_new_all,1)
     fprintf(fid,'%d,%d,%.2f,%.2f,%.2f,%.2f,%.6f,%d,%d,%d\n', det_new_all(ii,:));%
     end
     fclose(fid);
     
    gtData=dlmread( g_para.gtFile);
    detData=dlmread( g_para.detFile);
    detData=detData(:,1:10);
    detData=[detData;det_new;det_new_q];
%     detData=[detData;det_new];
    result=evalDet(gtData,detData);
    % end
    clear ISall_all ;
    clear fore_TSP;
    clear tree_table;
    clear tree_table_q;
    clear tree_table_del;
    clear tree_table_del_q;
    end
