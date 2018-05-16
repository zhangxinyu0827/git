 addpath(genpath('./utils'))
    detRaw=dlmread(detFile);
    frToParse=1:seqLens(seq_i);
    %     if nargin==2, frToParse=frames; end
    %     frToParse
    
    for t=frToParse
        detections(t).bx=[];
        detections(t).by=[];
        detections(t).xi=[];
        detections(t).yi=[];
        detections(t).xp=[];
        detections(t).yp=[];
        detections(t).wd=[];
        detections(t).ht=[];
        detections(t).sc=[];
        %zxy1221
            detections(t).flag=[];
    end
    
    % first defined frame and shift
    ff = 1;
    fshift = ff-1;
    
    for d=1:size(detRaw,1)
        t=detRaw(d,1);
    
        
        w=detRaw(d,5);
        h=detRaw(d,6);
        bx=detRaw(d,3);
        by=detRaw(d,4);
        xi=detRaw(d,3)+w/2;
        yi=detRaw(d,4)+h;
        sc=detRaw(d,7);
        try
         flag=detRaw(d,11);
        catch
             flag=ones(size(detRaw(d,8)));
        end
        %         sc(:)=1./(1+exp(-sc));
        % sc
        % scale to 0-1
%         sc=(sc-min(detRaw(:,7))) / (max(detRaw(:,7)-min(detRaw(:,7))));

        
        tshft = t-fshift;

        
        detections(tshft).bx=[detections(tshft).bx bx];
        detections(tshft).by=[detections(tshft).by by];
        detections(tshft).xi=[detections(tshft).xi xi];
        detections(tshft).yi=[detections(tshft).yi yi];
        detections(tshft).xp=[detections(tshft).xp xi];
        detections(tshft).yp=[detections(tshft).yp yi];
        detections(tshft).wd=[detections(tshft).wd w];
        detections(tshft).ht=[detections(tshft).ht h];
        detections(tshft).sc=[detections(tshft).sc sc];
        try
         detections(tshft).flag=[detections(tshft).flag flag];
        catch
        end
    end
    det=createAllDetPoints(detections);
    det.fr=det.tp;
    det.w=det.wd;
    det.h=det.ht;
    zanting=1;