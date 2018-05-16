other_param.seqs
txt_file=['output/' ,  other_param.seqs{1}, '.txt' ];
outdata=[track.fr];
outdata(:,2)=[track.id];
outdata=[outdata  track.x_hat  track.y_hat  track.w  track.h];
outdata(:,7)=-1;
outdata(:,8)=-1;
outdata(:,9)=-1;
outdata(:,10)=-1;
 csvwrite(txt_file,outdata);    

 
%  fid=fopen(txt_file,'a+');
% 
% fprintf(fid,'\n',sum_res(1:14));
% 
% fp=sum_res(8);fn=sum_res(9);ids=sum_res(10);
% mota=1-(fp+fn+ids)/gt
% fprintf(fid,'\n%.6f\n',mota);
% fclose(fid);
