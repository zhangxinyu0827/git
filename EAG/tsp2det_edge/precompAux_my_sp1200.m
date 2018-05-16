function [sp_labels,seqinfo, ISall, SPPerFrame] =  precompAux_my_sp1200(scenario,sceneInfo,K,frames)
% precomp auxiliary data
%%%%%% superpixels

createTempFolders()
F=length(frames);
    spfile=sprintf('sp-K%d.mat',K);
    try
        load(fullfile(sceneInfo.imgFolder,spfile));
        sp_labels=sp_labels(:,:,frames);
    catch err
        fprintf('Oops, we need superpixels. This may take a while...\n');
        thisd=pwd;
        TSPd=fullfile('external','TSP');
        myTSP;
        seqinfo=[];
         ISall=[];
         SPPerFrame=[];
        return;
    end


% sp_labels=sp_labels+1;


fprintf('\n');

%%%%% Iunsp
% independent superpixels for each frame
if ~exist('tmp/Iunsp/','dir'), mkdir('tmp/Iunsp'); end
Iunsplfile=sprintf('tmp/Iunsp/%04d-%d-%d-K%d.mat',scenario,frames(1),frames(end),K);
fprintf('Iunsp');

%  try
%         load(['/media/zxy/数据/tmp_mot_train/' Iunsplfile]);
%     catch
%          load(['/media/zxy/新加卷/tmp_mot_train/' Iunsplfile]);
%  end
%     
 
try 
    load(Iunsplfile)
catch
    Iunsp=unspliceSeg(sp_labels);
    %     fprintf('!!!!! UNSPLICE\n');
    %     Iunsp=sp_labels;
    save(Iunsplfile,'Iunsp','-v7.3');
end

%%%%% ISall
% all info about superpixel in one single matrix
fprintf('\nISall');
if ~exist('tmp/ISall/','dir'), mkdir('tmp/ISall'); end
ISallfile=sprintf('tmp/ISall/%04d-%d-%d-K%d.mat',scenario,frames(1),frames(end),K);

%  try
%         load(['/media/zxy/数据/tmp_mot_train/' ISallfile]);
%     catch
%          load(['/media/zxy/新加卷/tmp_mot_train/' ISallfile]);
%  end
 
try 
    load(ISallfile)
catch
%     [ISall,IMIND]=combineAllIndices(sp_labels,Iunsp, sceneInfo, flowinfo,iminfo);
     [ISall,IMIND]=combineAllIndices_my(sp_labels,Iunsp, sceneInfo);
    
save(ISallfile,'ISall','IMIND','-v7.3');
end
fprintf('\n');

%%%%%%%% concat sequence info into struct array
clear seqinfo SPPerFrame
sifile=sprintf('tmp/seqinfo/%04d-%d-%d-K%d.mat',scenario,frames(1),frames(end),K);
fprintf('seqinfo');

%  try
%         load(['/media/zxy/数据/tmp_mot_train/' sifile]);
%     catch
%          load(['/media/zxy/新加卷/tmp_mot_train/' sifile]);
%  end

try
    load(sifile)
catch
    for t=1:F
        fprintf('.');
        im=getFrame(sceneInfo,t);
        thisF=sp_labels(:,:,t);
        
        % vector of superpixels for each frame
        seqinfo(t).segF=unique(thisF(:));
%         seqinfo(t).nSeg=getNeighboringSuperpixels(sp_labels(:,:,t)+1);

        % vector of neighbors for each SP
        seqinfo(t).nSegUnsp = getNeighboringSuperpixels(Iunsp(:,:,t)+1);
        
        % weights for neighrbos
        seqinfo(t).nWeights = getNeighborWeights(seqinfo(t).nSegUnsp,Iunsp(:,:,t)+1,im);
        
        % how many superpixels in each frame?
        SPPerFrame(t)=numel(unique(sp_labels(:,:,t)));
        pause(1)
    end
    save(sifile,'seqinfo','SPPerFrame', '-v7.3');
end
fprintf('\n');
