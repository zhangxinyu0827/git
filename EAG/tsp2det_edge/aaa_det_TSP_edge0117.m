%对检测狂

    
%% 计算新det部分
    try
%             load([g_para.cur_data(23:end) '-ISall_all.mat']);
        load([ sceneInfo.imgFolder sceneInfo.sequence '-ISall_all.mat']);   
    catch
        ISall_all=ReadData();
    end
    try
	load([['data/'] seqDirs{seq_i} '-tsp_det_edge.mat']);
catch
     g_para.detFile=[g_para.detFile(1:end-7) seqDirs{seq_i} '_det_final.txt'];
    %超像素是否在检测中需要重新判断，因为加了新框
    data_raw=dlmread(g_para.detFile);
    det_tsp_e.gap=sparse(size(data_raw,1),size(data_raw,1));%标记时间距离
    det_tsp_e.mask=sparse(size(data_raw,1),size(data_raw,1));%标记连接
    det_tsp_e.num=sparse(size(data_raw,1),size(data_raw,1));%标记连接个数
    det_tsp_e.fore=sparse(size(data_raw,1),size(data_raw,1));%标记前景分数和
    det_tsp_e.tr_sc=sparse(size(data_raw,1),size(data_raw,1));%标记最优树的分数
    for isall_i=1:size(ISall_all,2)
        cur_isall=ISall_all{isall_i};
        toframe=min(45*isall_i,g_para.lastFrame);
        if isall_i==size(ISall_all,2)
            toframe=g_para.lastFrame;
        end
        for fram_i=(45*(isall_i-1)+1):toframe
            cur_data_raw=data_raw(find(data_raw(:,1)==fram_i),:);
            cur_data_raw_ind=find(data_raw(:,1)==fram_i);
            
            for det_i=1:size(cur_data_raw,1)
                 if mod(det_i,10)==1
                        fprintf('%d/%d/%d\n',fram_i,det_i,size(cur_data_raw,1))
                    end
                for det_j=1:size(data_raw,1)
                   
                    
                    if data_raw(det_j,1)-cur_data_raw(det_i,1)>0 && data_raw(det_j,1)-cur_data_raw(det_i,1)<4
                        cur_data_raw_i=cur_data_raw(det_i,:);
                        cur_data_raw_j=data_raw(det_j,:);
                        cur_det_i_tsp=get_cur_det_i_tsp(cur_data_raw_i,cur_isall);
                        
                        g_para.ex_next= data_raw(det_j,1)-cur_data_raw(det_i,1)+1;
                            
                        %     last_tsp_now为一个超像素节点所有信息
                        %ISall_now是扩展用的
                        %框内的所有TSP 
                        min_tmp_val=10000;
                        for cur_det_i_tsp_i=1:size(cur_det_i_tsp,1)
                            last_tsp_now=cur_det_i_tsp(cur_det_i_tsp_i,:);
                            ISall_now=getIsall( ISall_all,last_tsp_now);
                            ex_for_det_tsp_edg;
                            del_for_det_tsp_edg2;
                            
                            if is_in_det_j(tree_del,cur_data_raw_j)==1
                                if tmp_val<min_tmp_val
                                    min_tmp_val=tmp_val;
                                end
                                det_tsp_e.gap(cur_data_raw_ind(det_i), det_j)=data_raw(det_j,1)-cur_data_raw(det_i,1);
                                det_tsp_e.mask(cur_data_raw_ind(det_i), det_j)=1;
                                det_tsp_e.num(cur_data_raw_ind(det_i), det_j)=det_tsp_e.num(cur_data_raw_ind(det_i), det_j)+1;
                                det_tsp_e.fore(cur_data_raw_ind(det_i), det_j)=det_tsp_e.fore(cur_data_raw_ind(det_i), det_j)+tree_del{14}(end);
                                det_tsp_e.tr_sc(cur_data_raw_ind(det_i), det_j)=min_tmp_val;
                            end
                        end
                        
                    else
                        continue;
                    end 
                end
            end
        end
    end

    save ( [['data/'] seqDirs{seq_i} '-tsp_det_edge.mat'], 'det_tsp_e','-V7.3');
end

