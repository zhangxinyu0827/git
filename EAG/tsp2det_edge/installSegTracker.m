%% installs all necessary dependencies
% Required:

%   - configured mex c++ compiler
%   - internet connection

format compact;

segdir = pwd;
nerrors=0;

%%
%%%%%%%%%%%%%%%%%%
%%%% MEX Files %%%
%%%%%%%%%%%%%%%%%%
try
    fprintf('Compiling mex...\n');
    compileMex;
catch err
    fprintf('FAILED: Mex files could not be compiled! %s\n',err.message);
    nerrors=nerrors+1;
end
    


%%
%%%%%%%%%%%%%%%
%%%%%% GCO %%%%
%%%%%%%%%%%%%%%
try
    fprintf('Installing GCO....\n');
    if ~exist(['external/GCO/matlab/bin/gco_matlab.',mexext],'file')
        cd external
        mkdir('GCO')
        cd GCO
        cd matlab
        GCO_BuildLib
        
        cd(segdir);
        fprintf('Success!\n');
    else
        fprintf('IGNORE. Already exist\n');
    end
    
catch err
    fprintf('FAILED: GCO not installed! %s\n',err.message);
    nerrors=nerrors+1;
    cd(segdir)
end

%%
%%%%%%%%%%%%%%%%%%
%%% LIGHTSPEED %%%
%%%%%%%%%%%%%%%%%%
% This one is optional
try
    fprintf('Installing Lightspeed...\n');
    if ~exist(['external/lightspeed/@double/gammaln.',mexext],'file')
        cd external
        cd lightspeed
        install_lightspeed;
        cd(segdir);
        
        fprintf('Success!\n');
    else
        fprintf('IGNORE. Already exist\n');
    end
    
catch err
    fprintf('FAILED: Lightspeed not installed! %s\n',err.message);
    nerrors=nerrors+1;
    cd(segdir)
end

%%
%%%%%%%%%%%%%%%%%%
%%% TSP %%%
%%%%%%%%%%%%%%%%%%
try
    fprintf('Installing TSP\n');
    if ~exist(['external/TSP/mex/split_move.',mexext],'file')
        cd external/TSP
        compile_MEX
        cd(segdir);
        
        fprintf('Success!\n');
    else
        fprintf('IGNORE. Already exist\n');
    end
    
catch err
    fprintf('FAILED: TSP not installed! %s\n',err.message);
    nerrors=nerrors+1;
    cd(segdir)
end

%%
%%%%%%%%%%%%%%%%%%
%%% liblinear %%%
%%%%%%%%%%%%%%%%%%
% This one is optional
try
    fprintf('Installing liblinear-1.94...\n');
    if ~exist(['external/liblinear-1.94/matlab/predict.',mexext],'file')
        cd external/liblinear-1.94/matlab
        make;
        assert(lsvmerr==0);
        cd(segdir);
        
        
        fprintf('Success!\n');
    else
        fprintf('IGNORE. Already exist\n');
    end
    
catch err
    fprintf('FAILED: liblinear not installed! %s\n',err.message);
    nerrors=nerrors+1;
    cd(segdir)
end

%%
%%%%%%%%%%%%%%%%%%
%%% kmeans %%%
%%%%%%%%%%%%%%%%%%
try
    fprintf('Installing vgg_kmiter\n');
    if ~exist(['external/Shu/BoW_code/vgg_kmiter.',mexext],'file')
        cd external/Shu/BoW_code
        mex vgg_kmiter.cxx
        cd(segdir);
        
        fprintf('Success!\n');
    else
        fprintf('IGNORE. Already exist\n');
    end
    
catch err
    fprintf('FAILED: vgg_kmiter not installed! %s\n',err.message);
    nerrors=nerrors+1;
    cd(segdir)
end

    


%%
if ~nerrors
    fprintf('SegTracker installed with no errors\n');
else
    fprintf('Installation finished with %d errors. SegTracker may not work properly\n',nerrors);
end

cd(segdir)