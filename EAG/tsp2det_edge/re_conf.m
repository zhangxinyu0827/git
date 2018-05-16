%%重命名和标定置信度
%新的名字在det下，为序列名字
%for LIBAO main function
%by  Xinyu  Zhang , 20170315

%zhangxinyu0827@buaa.edu.cn
function   re_conf(sceneInfo,seqDirs,seq_i)
detData=dlmread(sceneInfo.detFile);
detData=detData(:,1:10);
tmp_s=detData(:,7);
detData(:,7)=((tmp_s-min(tmp_s))/(max(tmp_s)-min(tmp_s)))*0.5+0.5;
fid=fopen([sceneInfo.detFile(1:end-7)  seqDirs{seq_i} '_det.txt'],'w+');
     for ii=1:size(detData,1)
            fprintf(fid,'%d,%d,%.2f,%.2f,%.2f,%.2f,%.6f,%d,%d,%d\n', detData(ii,:));%
     end
fclose(fid);

end