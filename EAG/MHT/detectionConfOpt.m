function output_obs=detectionConfOpt(det)

detRaw=[det.fr] ;
%det.r=det.r*0.5/(max(det.r)-min(det.r))+(0.5*max(det.r)-min(det.r))/(max(det.r)-min(det.r));
detRaw(:,3:7)=[ det.bx det.by det.w det.h det.r];


 tmp_det_Raw=detRaw;
 fram=max(detRaw(:,1));
 tofram=50;
 if fram-tofram<30
     tofram=fram;
 end
 begfram=1;
while tofram<=fram
    detRaw=tmp_det_Raw(tmp_det_Raw(:,1)>=begfram & tmp_det_Raw(:,1)<=tofram,:);
    htobj=myEstimateTargetsSize(detRaw);
    muh=1.7; sigmah=.3; 
    for ii=1:size(detRaw,1)
        h_pre=htobj(detRaw(ii,3)+detRaw(ii,5)/2,detRaw(ii,4)+detRaw(ii,6));
        sigmah_scal=(h_pre/muh)*sigmah;%缩放后的标准差
        factorh=1/sigmah_scal/sqrt(2*pi);
        weight=normpdf(detRaw(ii,6),h_pre,sigmah_scal)/factorh;
      
        detRaw(ii,7)=detRaw(ii,7)*weight;
       
        if isnan(detRaw(ii,7))
            detRaw(ii,7)=0;
        end
    end
    tmp_det_Raw(tmp_det_Raw(:,1)>=begfram & tmp_det_Raw(:,1)<=tofram,7)=detRaw(:,7);
    if tofram==fram
        break;
    end
    tofram=min([tofram+50,fram]);
    begfram=begfram+50;
     if fram-tofram<30
        tofram=fram;
    end
end
detRaw=tmp_det_Raw;
det.r=detRaw(:,7);
output_obs=det;
end
