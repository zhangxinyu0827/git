function ISall_now=getIsall_q( ISall_all,last_tsp_now)

last_tsp_fre=last_tsp_now(3);

global g_para;

lastFrame=g_para.lastFrame;
ex_next=g_para.ex_next;
ISall_now=[];
% 没有和第三个合并为了避免在最后一个窗口出问题
%向前
if last_tsp_fre<50
    ISall= ISall_all{1};
    keep=find(ISall(:,3)<=last_tsp_fre & (ISall(:,3)>=last_tsp_fre-ex_next+1));
    ISall_now=ISall(keep,:);
else
    try
     ISall= ISall_all{ceil(last_tsp_fre/45)};
keep=find(ISall(:,3)<=last_tsp_fre & (ISall(:,3)>=last_tsp_fre-ex_next+1));
    ISall_now=ISall(keep,:);
    catch
        fprintf('getIsall_q读入省略\n')
    end
    
     ISall= ISall_all{ceil(last_tsp_fre/45-1)};
    keep=find(ISall(:,3)<=last_tsp_fre & (ISall(:,3)>=last_tsp_fre-ex_next-1));
    ISall_now=[ISall_now ;ISall(keep,:)];
end