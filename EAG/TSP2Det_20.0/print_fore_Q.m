% 显示当前背景建模结果，前提是有ISall，和一些必要的图像，超像素文件信息
ind1=1;
ISall=ISall_all{ind1};

global g_para;
sp_lb_file=g_para.sp_lb_file;
load(sp_lb_file);
img_input_path=g_para.img_input_path;
cnt=0;
Q=ISall(:,14);
ss=min(ISall(:,3));
ee=max(ISall(:,3));
clear ISall;
for t=ss:ee

    thisF=sp_labels(:,:,t);
     im = imread(sprintf(img_input_path, t)); %% read an image
    npix=size(im,1)*size(im,2);
    segs=unique(thisF(:))';

%     w=getGaussMasks(im,detections(t));
    Itmpc=rgb2gray(zeros(size(im)));
    Itmp=rgb2gray(zeros(size(im)));
%     Itmp=im;
    for s=segs
        cnt=cnt+1;
        [u,v]=find(thisF==s);
        spLH=Q(cnt);        
%         spLH=spLH*QD(cnt);
%         spLH=Q(cnt)*w(round(mean(u)),round(mean(v)));
%         spLH
%         spLH=Q(cnt)+w(round(mean(u)),round(mean(v)));
        imind=sub2ind(size(thisF),u,v);
        Itmp(imind)=spLH;
%         Itmp(imind)=featmat(cnt);
        Itmpc(imind)=Q(cnt);
%         Q(cnt)=spLH;
%         imtight(Itmp);
%         Q(cnt)
%         pause
    end
    figure(1);
%     imtight(Itmp,[0 1]);
imshow(Itmp);
%     imwrite(Itmpc,sprintf('tmp/hyp/s%02d-f%04d-lhco.jpg',scenario,sceneInfo.frameNums(t)));
%     imwrite(Itmp,sprintf('tmp/hyp/s%02d-f%04d-lh.jpg',scenario,t));

    pause(.01);
end
clear sp_labels;