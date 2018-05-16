close all;
clear all,clc;
%用于输出追踪结果
%%注意在切换数据级时，有一个参数对应的MOT和pets是不同的
% 注意有无选用appSel，有无选用三维数据在setOtherParameters
warning off;
addpath(genpath('external'));
%0805zxy
addpath(genpath('CLEAR'));
for mot=16
    if mot==15
        vis_mot15;
    else
        vis_mot16;
    end
end

