% 将漏检连续超像素以白块输出，对应tree_table_del，小范围实验，用于验证正确性
clear all ,clc;
set_para;

load tree_table_del;
sp_lb_file=g_para.sp_lb_file;
load(sp_lb_file);

g_i=1;
for ind=1:length(tree_table_del)

    tsp_print=tree_table_del{ind};
    tsp_print_label=tsp_print{1};
    tsp_print_fre=tsp_print{3};
    if length(tsp_print_fre)~=10
        bugggg=0;
    end
    for i=1:length(tsp_print_fre)
        im1=imread(sprintf(img_input_path, tsp_print_fre(i))); %% read an image
        Itmp=im1;
        [xx yy zz]=size(im1);
        npix=xx*yy;
        [u,v]=find(sp_labels(:,:,tsp_print_fre(i))==tsp_print_label(i));
        imind=sub2ind([xx yy],u,v);
        Itmp(imind)=255;        Itmp(imind+npix)=255;        Itmp(imind+npix*2)=255;
        im1=Itmp;
        imwrite(im1, ['tsp_tree_del_q/' sprintf('%0.8d%0.6d%0.6d', g_i,tsp_print_fre(i),tsp_print_label((i))) '.jpg']); %%write the output image  
        g_i=g_i+1;
    end
end
% 
