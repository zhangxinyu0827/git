clear,clc;
cur_data_all={'PETS09-S1L1';'PETS09-S1L2';'PETS09-S2L1';...
    'PETS09-S2L2';'PETS09-S2L3'};
detData=dlmread('eval_det.txt');
detData(:,4)=detData(:,6)./(detData(:,6)+detData(:,8));
detData(:,5)=detData(:,6)./(detData(:,6)+detData(:,7));
% Rcll=TP/(TP+FN);
% Prcn=TP/(TP+FP);
a=1:length(detData(:,5));
ss=[];
for det_i=1:5
    for det_j=9:8
        figure();
        plot(detData(det_i:5:end,det_j));
        if det_j==5
            hold on;
            plot(detData(det_i:5:end,4));
            plot(detData(det_i:5:end,4)+detData(det_i:5:end,5));
            hold off;
             title([cur_data_all{det_i} '   recall-prac']);
            saveas(gcf, ['thtesh_effect/' cur_data_all{det_i} '_recall-prac' '.jpg']);  %保存当前窗口的图像  
        end
        if det_j==6
            title([cur_data_all{det_i} '   TP']);
            saveas(gcf, ['thtesh_effect/' cur_data_all{det_i} '_TP' '.jpg']);  %保存当前窗口的图像  
        elseif det_j==7
            title([cur_data_all{det_i} '   FP']);
            saveas(gcf, ['thtesh_effect/' cur_data_all{det_i} '_FP' '.jpg']);  %保存当前窗口的图像  
        elseif det_j==8
            title([cur_data_all{det_i} '   FN']);
            saveas(gcf, ['thtesh_effect/' cur_data_all{det_i} '_FN' '.jpg']);  %保存当前窗口的图像  
        end
        
    end
    recall_prac=detData(det_i:5:end,4)+detData(det_i:5:end,5);
    [tmp_val tmp_ind]=sort(recall_prac,'descend');  %sort 20
%     recall_prac_ind{det_i}=find(recall_prac==recall_prac_max);
    recall_prac_ind(:,det_i)=tmp_ind(1:50);
    a=intersect(a,tmp_ind(1:52));
    ddd=detData(det_i:5:end,2:end);
    ss=[ss recall_prac];
    
end


%经过选择，最终确定,nms_thtesh    0,.46,   conf_thtesh   0.4