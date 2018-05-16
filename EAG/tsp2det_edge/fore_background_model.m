function fore_background_model(sceneInfo,seqDirs,seqLens,seq_i)
for f_i=2:seqLens(seq_i)
%    flow_mat_f1=['data/2DMOT2015/test/' seqDirs{seq_i} '/img1/TSP_flows/'];
   flow_mat_f1=[sceneInfo.imgFolder 'TSP_flows/'];
   flow_mat_f2=sprintf('%06d_flow.mat',f_i);
   flow_mat_f=[flow_mat_f1 flow_mat_f2];

   svm_f_f1=['tmp'  '/hyp/'];
   if seq_i==9
       svm_f_f2=sprintf('s40-f%04d-lh.jpg',f_i);
   elseif seq_i==10
       svm_f_f2=sprintf('s42-f%04d-lh.jpg',f_i);
   elseif seq_i==26
        svm_f_f2=sprintf('s41-f%04d-lh.jpg',f_i);
   else
        svm_f_f2=sprintf('s00-f%04d-lh.jpg',f_i);
   end
  svm_f_f=[svm_f_f1 svm_f_f2];

%   detFile=['data/2DMOT2015/test/'  seqDirs{seq_i} '/det/det.txt'];
  detFile=sceneInfo.detFile;
  flow_back_model;


    svm_f=imread(svm_f_f);
    % imshow(svm_f);
    % imshow(flow_f);
    % figure();
    % mesh(flow_mat{1})
    % figure();
    % mesh(flow_mat{2})
    % figure();
    % mesh(flow_mat{3})

    Q_flow=max(max(abs(r_fvx),abs(r_fvy)),max(abs(r_bvx),abs(r_bvy)));

    Q_flow=(Q_flow-min(Q_flow(:)))./(max(Q_flow(:))-min(Q_flow(:)));

    Q_svm=double(svm_f);
    Q_svm=(Q_svm-min(Q_svm(:)))./(max(Q_svm(:))-min(Q_svm(:)));
    Q_flow=Q_flow.^0.5;
    Q=0.5*Q_flow+0.5*Q_svm;
    Q=(Q-min(Q(:)))./(max(Q(:))-min(Q(:)));
    subplot(1,3,1)
    imshow(Q)
    subplot(1,3,2)
    imshow(Q_flow)
    subplot(1,3,3)
    imshow(Q_svm)
    pause(.1);
    name1=[flow_mat_f1(1:end-15) 'img_flow_fore/'];
    name2=[flow_mat_f1(1:end-15) 'img_svm_flow_fore/'];
    mkdir(name1);
    mkdir(name2);
    name3=sprintf('%06d.jpg',idx);
    name11=[name1 name3];
    name22=[name2 name3];
    imwrite(Q_flow,name11);
    imwrite(Q,name22);
    if idx==2
        name3=sprintf('%06d.jpg',1);
        name11=[name1 name3];
        name22=[name2 name3];
        imwrite(Q_flow,name11);
        imwrite(Q,name22);
    end
end
end