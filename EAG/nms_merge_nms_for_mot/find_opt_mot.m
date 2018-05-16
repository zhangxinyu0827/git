clear all,clc;
data_all=dlmread('eval_det.txt');

for seq_i=1:10
    
    TP=data_all(seq_i:10:end,6);
    FP=data_all(seq_i:10:end,7);
    FN=data_all(seq_i:10:end,8);
    Rcll=TP./(TP+FN);
    Prcn=TP./(TP+FP);

  
    F(seq_i,:)=2.*Rcll.*Prcn./(Rcll+Prcn);
    [val ind]=sort(F(seq_i,:));
    keepmax(seq_i,:)=ind(end-40:end);
%     figure(seq_i);
%     subplot(1,3,1);
%     plot(Rcll);
%     subplot(1,3,2);
%     plot(Prcn);
%     subplot(1,3,3);
%     plot(F(seq_i,:));
%     legend('调谐均值')
end

% % 找重复集
% keep=keepmax(1,:);
% for i=2:10
%     
%    keep= intersect(keep,keepmax(i,:))
% end

%% 找F 加和最大值
F_sum=sum(F);
[val ind]=sort(F_sum);
