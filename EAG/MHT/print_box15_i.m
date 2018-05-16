im1 = imread(sprintf(img_input_path{1,i}, 1)); %% read an image
[sceneInfo.imgHeight  sceneInfo.imgWidth tmp_w]=size(im1);
load external/Pirsiavash_CVPR2011/label_image_file.mat;
for f_i=1:max(det.fr);
    im1 = imread(sprintf(img_input_path{1,i}, f_i)); %% read an image
    kk=f_i;
    ndet=length(detections(kk).sc);
    for dd=1:ndet
        bx=detections(kk).bx(dd);by=detections(kk).by(dd);bh=detections(kk).ht(dd);bw=detections(kk).wd(dd);
        sc=detections(kk).sc(dd);
       if sc>0.1
                sc_dayu0;
       else
                sc_xiaoyu0;    
        end
    end
    % imshow(im1);
    for dd=1:ndet
         bx=detections(kk).bx(dd);by=detections(kk).by(dd);sc=detections(kk).sc(dd);
    %      if sc>0.1
    %     text(max(1,bx),max(1,by),num2str(sc),'fontsize',12);
        if sc>=0
        else
            sprintf('有负数置信度');
        end
    %      end
    end
    % pause(0.1)
    % saveas(gcf, [img_output_path{1,i} sprintf('/%0.8d', f_i) '.jpg']);  %保存当前窗口的图像
    imwrite(im1,[img_output_path{1,i} sprintf('/%0.8d', f_i) '.jpg']);
end