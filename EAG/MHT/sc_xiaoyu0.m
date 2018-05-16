im1(max(1,by):min(by+2,sceneInfo.imgHeight),max(1,bx):min(bx+bw,sceneInfo.imgWidth),1)=255;
im1(max(1,by+bh):min(by+bh+2,sceneInfo.imgHeight),max(1,bx):min(bx+bw,sceneInfo.imgWidth),1)=255;
im1(max(1,by):min(by+bh,sceneInfo.imgHeight),max(1,bx):min(bx+2,sceneInfo.imgWidth),1)=255;
im1(max(1,by):min(by+bh,sceneInfo.imgHeight),max(1,bx+bw):min(bx+bw+2,sceneInfo.imgWidth),1)=255;

im1(max(1,by):min(by+2,sceneInfo.imgHeight),max(1,bx):min(bx+bw,sceneInfo.imgWidth),2)=0;
im1(max(1,by+bh):min(by+bh+2,sceneInfo.imgHeight),max(1,bx):min(bx+bw,sceneInfo.imgWidth),2)=0;
im1(max(1,by):min(by+bh,sceneInfo.imgHeight),max(1,bx):min(bx+2,sceneInfo.imgWidth),2)=0;
im1(max(1,by):min(by+bh,sceneInfo.imgHeight),max(1,bx+bw):min(bx+bw+2,sceneInfo.imgWidth),2)=0;

im1(max(1,by):min(by+2,sceneInfo.imgHeight),max(1,bx):min(bx+bw,sceneInfo.imgWidth),3)=0;
im1(max(1,by+bh):min(by+bh+2,sceneInfo.imgHeight),max(1,bx):min(bx+bw,sceneInfo.imgWidth),3)=0;
im1(max(1,by):min(by+bh,sceneInfo.imgHeight),max(1,bx):min(bx+2,sceneInfo.imgWidth),3)=0;
im1(max(1,by):min(by+bh,sceneInfo.imgHeight),max(1,bx+bw):min(bx+bw+2,sceneInfo.imgWidth),3)=0;
col=[255 0 0];
sc=ceil(sc*100);
if sc>0
    bw=bws(sc).bw;
    [num_x num_y]=size(bw);
    start_by=max(by-num_x+1,1);
    start_bx=max(bx-num_y+1,1);
    for kkkk = 1:3 %% RGB channels
        im1(start_by:start_by+num_x-1,start_bx:start_bx+num_y-1, kkkk) = (1-bw) * col(kkkk);
    end

end