        
res=[
   27.6,83.3,1.65,54,6,16,32,988,12915,48,62,21.8,75.9,22.0,
51.1,89.9,2.59,83,14,42,27,2724,23267,116,145,45.1,79.2,45.3,
44.4,86.0,0.59,125,23,46,56,492,3790,20,46,36.9,76.8,37.2,
61.8,84.3,1.15,25,11,11,3,606,2007,28,30,49.8,75.3,50.3,
46.1,91.2,0.84,54,9,22,23,549,6635,40,67,41.3,75.9,41.7,
57.8,91.2,0.57,69,14,21,34,511,3869,22,23,52.0,79.8,52.2,
28.2,85.1,0.75,107,9,39,59,566,8224,31,68,22.9,73.6,23.2,


];
% gt=sum(res(:,8:10),2)./((1-res(:,12)/100));
% gt=sum(gt);
gt=1.1041e+05;
sum_res=sum(res);
% gt=([29193 108005 7671 8830 16929 10076 19263]);
fp=sum_res(8);fn=sum_res(9);ids=sum_res(10);
 fprintf('%.1f,%.1f,%.2f,%d,%d,%d,%d,%d,%d,%d,%d,%.1f,%.1f,%.1f,\n\n',sum_res(1:14));
mota=1-(fp+fn+ids)/gt

% mota=1-sum(res(2,8:10))/gt(2)