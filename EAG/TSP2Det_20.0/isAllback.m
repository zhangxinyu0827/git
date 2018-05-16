function pre_fore=isAllback(ISall_all,fre_other,x_pre2,y_pre2,w_pre2,h_pre2)
%判断当前框是否只有背景，是为  1
global g_para;
cur_isall=ISall_all{ceil(fre_other/45)};

bx=x_pre2;by=y_pre2;bh=h_pre2;bw=w_pre2;
  tmp__inside_ind=find( cur_isall(:,3)==fre_other& ...
                    cur_isall(:,4)>bx & cur_isall(:,5)>by& ...
                    cur_isall(:,4)<bx+bw & ...
                    cur_isall(:,5)<by+bh&...
                    cur_isall(:,14)>g_para.fore_thresh);
       if isempty(tmp__inside_ind)
           pre_fore=1;
       else
           pre_fore=0;
       end
                 
                 
                 
end