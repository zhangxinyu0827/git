% �������е�ʵ�������в���

% 选取�?��框外的超像素建立树（轨迹�?
clear all,clc;
%设置参数
set_para;
% ISall_all=ReadData();
% read_data;
%根据分数输出图像
% print_fore_Q;
%为检测画�?% print_box; 
%对每�?��选出的TSP 输出�?��
% print_tsp_figure;
%对每�?��选出的TSP 输出，�?帧输�?
% print_tsp_fre_figure;
%将在�?��外的，且为前�?的输出，逐个输出，输出为mat文件
% fore_TSP=PrintTspMat(ISall_all);

%便于测试
% save ISall_all ISall_all;
load ISall_all;
% save  fore_TSP fore_TSP;
load fore_TSP;
for iiitest=4:10
    tmp_txt_name=['tsp_det_result/' g_para.cur_data(7:end) num2str(iiitest) '.txt'];
    tmp_txt_name_q=['tsp_det_result/' g_para.cur_data(7:end) num2str(iiitest) '_q.txt'];
    
    det_new=dlmread(tmp_txt_name);
    det_new_q=dlmread(tmp_txt_name_q);
    
    gtData=dlmread( g_para.gtFile);
    detData=dlmread( g_para.detFile);
    detData=[detData;det_new;det_new_q];
    result=evalDet(gtData,detData);
end
