function observation = cutDetections(observation,other_param)

% cut detections based on its confidence score
del_idx = find(observation.r < other_param.minDetScore);    

observation.x(del_idx) = [];
observation.y(del_idx) = [];
observation.w(del_idx) = [];
observation.h(del_idx) = [];
observation.fr(del_idx) = [];
observation.r(del_idx) = [];
try
observation.bx(del_idx) = [];

catch
    
end
try

observation.by(del_idx) = [];

catch
    
end
try

observation.chist(del_idx) = [];

catch
    
end
try

observation.hog(del_idx) = [];

catch
    
end
try

observation.flag(del_idx) = [];
catch
    
end


try
observation.g_id(del_idx) = [];

catch
    
end



if other_param.is3Dtracking
    observation.bx(del_idx) = [];
    observation.by(del_idx) = [];
end

if ~isempty(other_param.appSel)
    observation.cnn(del_idx,:) = [];
end


end
