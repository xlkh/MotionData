%%曲率的计算函数
% 实际数据
load('90009_traj_sep_1_166164.mat');
dx = diff(pos.x);
dy = diff(pos.y);
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

pos.kappa = dheading_final./ds_final;
% 中点欧拉法计算曲率以及曲率半径
for i = 1:166163
    if abs(pos.kappa(i)) > 50
        pos.kappa(i) = 0;
    end 
end
curve = zeros(1,166163);
time = zeros(1,166163);
for i = 1:166163
    if abs(pos.kappa(i)) < 1
        curve(i) = pos.kappa(i);
        time(i) = pos.t(i);
    end
end
figure;
scatter(pos.t,pos.kappa);%绘制散点图