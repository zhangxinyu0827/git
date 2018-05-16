det_cur=[observation.fr];
det_cur=[det_cur -1*ones(size(det_cur,1),1)];
det_cur=[det_cur observation.bx observation.by observation.w observation.h observation.r];
    det_cur=[det_cur  -1*ones(size(det_cur,1),3)];
    try
        det_cur=[det_cur  observation.flag];
    catch
    end
    txt_file_cur_det=['cur_det/' other_param.seqs '.txt']
 csvwrite(txt_file_cur_det,det_cur);    

