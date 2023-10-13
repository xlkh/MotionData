%% 卸载区曲率的计算函数
% 实际数据
dx = diff(unload_state.jing);
dy = diff(unload_state.wei);
Size = length(dx);
dx_pre = [dx(1);dx];
dx_after = [dx;dx(end)];
dx_final = (dx_pre + dx_after) /2;

dy_pre = [dy(1);dy];
dy_after = [dy;dy(end)];
dy_final = (dy_pre + dy_after) /2;

ds_final = sqrt(dx_final.^2 + dy_final.^2);
path_heading = atan2(dy_final,dx_final);

dheading = diff(path_heading);
dheading_pre = [dheading(1);dheading];
dheading_after = [dheading;dheading(end)];
dheading_final = (dheading_pre + dheading_after)/2;

unload_state.kappa = dheading_final./ds_final;

nonZeroIndices = (unload_state.kappa ~= 0);
filtered_kappa = unload_state.kappa(nonZeroIndices);
filtered_time = unload_state.t(nonZeroIndices);
figure;
scatter(filtered_time,filtered_kappa);%绘制散点图
title('Scatter Plot with no_load');
%scatter(unload_state.t,unload_state.kappa);%绘制散点图