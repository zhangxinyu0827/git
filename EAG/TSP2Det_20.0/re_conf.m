%   修改置信度范围

%     det_data=[seqData.inputVideoFile(1:end-4) '/det/det.txt'];
det_data='PETS09-S2L10_all_new.txt';

    detData=dlmread(det_data);   
    detData=detData(:,1:10);
    detData(:,7)=100*detData(:,7);
     fid=fopen(det_data,'w+');
     for ii=1:size(detData,1)
            fprintf(fid,'%d,%d,%.2f,%.2f,%.2f,%.2f,%.6f,%d,%d,%d\n', detData(ii,:));%
     end
     fclose(fid);
     