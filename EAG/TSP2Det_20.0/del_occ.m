function keep=del_occ(all)
keep=true(length(all),1);

for all_i=1:length(all)
    if keep(all_i)
        occ_i=find((all(:,1)==all(all_i,1)) ...
            &(all(:,2)==all(all_i,2)) );
        
        if length(occ_i)>1
            [max_i ,max_ind]=max(all(occ_i,3));
            del_i=setdiff(occ_i,occ_i(max_ind));
            keep(del_i)=false;
        end
    end
        

end
keep=find(keep);
end