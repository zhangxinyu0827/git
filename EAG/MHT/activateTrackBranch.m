function activeTreeSet = activateTrackBranch(idTreeSet,scoreTreeSet,obsTreeSet,activeTreeSet,other_param,cur_time)
global cur_tsp_cost;
treeInd = findleaves(scoreTreeSet);
tabuList = zeros(1,length(treeInd));
score = [];            
for j = 1:length(treeInd)
    obsSel = obsTreeSet.get(treeInd(j));
               
    if obsSel(5) ~= cur_time
        tabuList(j) = treeInd(j);
        continue;
    end
    scoreSel = scoreTreeSet.get(treeInd(j));               
    score = [score scoreSel(1)];               
    if scoreSel(2) == 0
        error('error in the confidence score of the current observation');
    end
        
end
     
% NOTE: assumed that treeInd is always sorted. otherwise, treeInd and score will not be synced anymore.
treeInd = setdiff(treeInd, tabuList);

% error check
if length(treeInd) ~= length(score)
    error('something wrong happened in the track tree branch pruning'); 
end
            
if length(treeInd) > other_param.maxActiveTrackPerTree
    [~, indexSorted] = sort(score,'descend');                                                                              
   
                
    tsp_sort_tmp= indexSorted(-49+other_param.maxActiveTrackPerTree:min(length(treeInd),...
50+other_param.maxActiveTrackPerTree));
                tsp_sc=[];
               tmp_cur_obs_tr=obsTreeSet.Node;
               for brun_i=1:length(tsp_sort_tmp)
                   
               tmp_obs_ind=[];
               cur_node_for_tsp_ind=treeInd(tsp_sort_tmp(brun_i));
               
               while cur_node_for_tsp_ind~=0
                   tmp_obs_ind=[tmp_obs_ind  (tmp_cur_obs_tr{cur_node_for_tsp_ind,1}(:,10)')];
                   cur_node_for_tsp_ind=idTreeSet.getparent(cur_node_for_tsp_ind);
               end
               tmp_obs_ind=fliplr(tmp_obs_ind);
               tsp_link_sc=sum((diag(cur_tsp_cost(tmp_obs_ind(1:end-1),tmp_obs_ind(2:end-1)))));
               tsp_sc=[tsp_sc tsp_link_sc];
               end
                [~, indexSorted_tsp] = sort(tsp_sc,'descend');   
                 indexSorted = indexSorted(1:other_param.maxActiveTrackPerTree);
                indexSorted(51:end)=tsp_sort_tmp(indexSorted_tsp(1:50));
                   
                   
    for j = 1:length(indexSorted)
        activeTreeSet = activeTreeSet.set(treeInd(indexSorted(j)),1);
    end
else
    % if the number of track branches is smaller than the threshold, activate all track branches
    for j = 1:length(treeInd)
        activeTreeSet = activeTreeSet.set(treeInd(j),1);
    end
end
            
end