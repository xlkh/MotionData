load('90009_traj_sep_1_166164.mat');
x = zeros(10000,1);
y = zeros(10000,1);
for i = 1:10000
    x(i) = pos.x(i);
    y(i) = pos.y(i);
end
dataMatrix = [x,y];
% 创建拟合模型（这里使用二次多项式拟合）
model = fit(dataMatrix(:, 1), dataMatrix(:, 2), 'poly5');

% 生成拟合曲线的评估点
t = linspace(min(x), max(x), 10000);

% 计算拟合曲线上的点
y_fit = feval(model, t);

% 绘制拟合曲线
figure;
plot(x, y, 'o', 'DisplayName', '原始数据');
hold on;
plot(t, y_fit, 'r', 'DisplayName', '拟合曲线');
xlabel('X轴');
ylabel('Y轴');
title('曲线拟合和曲率计算');
legend;