function pre_fore=isAllback1(fre_other,x_pre2,y_pre2,w_pre2,h_pre2)
%判断当前框是否只有背景，是为  1
global g_para;
try
    back_file=sprintf([g_para.cur_data '/fore/%06d.jpg'],fre_other);
    back_img=imread(back_file);
    num_fore=find(back_img(x_pre2:x_pre2+w_pre2,y_pre2:y_pre2+h_pre2));
    if length(num_fore)>5
        pre_fore=0;
    else
        pre_fore=1;
    end
catch
    pre_fore=0;
end
                 
                 
                 
end