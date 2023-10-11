%%墨卡托法将经纬度信息转换为惯导坐标系
load('90009_load_traj.mat');
opt1 = detectImportOptions('E:\data\MotionData\90009轨迹9月.xlsx');
opt1.SelectedVariableNames = 6:8;
opt1.DataRange = '2:166164';
data = readmatrix('E:\data\MotionData\90009轨迹9月.xlsx',opt1);
origin_pos = [data(1,3),data(1,2),0];
longitude = data(:,2);
altitude = data(:,3);

R = 6371000; % 地球半径约为 6371 公里，将单位转换为米

% 转换为墨卡托坐标
pos.jing = R * longitude * pi / 180;
pos.wei = R * log(tan((90 + altitude) * pi / 360));
save('E:\data\MotionData\90009_traj_sep_1_166164.mat','pos');
%pos.jing = pos.x * 20037508.34 / 180;
%ly = log(tan((90+ pos.y)*pi/360))/(pi/180);
%pos.wei = ly * 20037508.34 / 180;