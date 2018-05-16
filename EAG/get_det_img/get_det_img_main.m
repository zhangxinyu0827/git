
function get_det_img_main(seqData,img_file137,seq_i)

det_data=dlmread(seqData.inputDetections);
tmp_image_i=1;
im=imread([seqData.inputVideoFile '/' sprintf('%06d.jpg',1)]);
[xx yy zz]=size(im);
det_num=size(det_data,1);
for det_i=1:det_num
if mod(det_i,10)==0
    fprintf('img%d/%d\n',det_num,det_i);
end
    
    
    im=imread([seqData.inputVideoFile '/' sprintf('%06d.jpg',det_data(det_i,1))]);
    save_im=im(max(1,det_data(det_i,4)):min(  (det_data(det_i,4)+det_data(det_i,6)), xx),...
    max(1,det_data(det_i,3)):min(  (det_data(det_i,3)+det_data(det_i,5)), yy),:);
    try
        save_im137=imresize(save_im,[144 56]);  % resize im_data

        save_img_f137=[img_file137 '/' sprintf('%08d.jpg',tmp_image_i)];
 imwrite(save_im137,save_img_f137);

tmp_image_i=tmp_image_i+1;

    catch
        fprintf('检测出错')
        det_i
        fid=fopen('errors_catch16det.txt','a+');
        fprintf(fid,'%d  %d \n',[seq_i det_i]);
        fclose(fid);

    end
end
end


