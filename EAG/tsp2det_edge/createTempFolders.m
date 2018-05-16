function createTempFolders()
% make sure all necessary temp folders exist

tmpfolders={'tmp/seqinfo',...
    'tmp/ISall',...
    'tmp/Iunsp',...
    'tmp/hyp',...
    'tmp/hyps',...
    'tmp/res',...
    };

for t=1:length(tmpfolders)
    tf=char(tmpfolders(t));
    if ~exist(tf,'dir'), mkdir(tf); end
end