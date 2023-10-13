tic;
%% 墨卡托法将经纬度信息转换为惯导坐标系
load_batch_end_1 = '285664';
opt4 = detectImportOptions('E:\data\MotionData\90009轨迹9月.xlsx');
opt4.SelectedVariableNames = 6:8;
opt4.DataRange = load_batch_1; %2:166164 166165:285664
data = readmatrix('E:\data\MotionData\90009轨迹9月.xlsx',opt4);
origin_pos = [data(1,3),data(1,2),0];
longitude = data(:,2);
altitude = data(:,3);

R = 6371000; % 地球半径约为 6371 公里，将单位转换为米

% 转换为墨卡托坐标
pos.jing = R * longitude * pi / 180;
pos.wei = R * log(tan((90 + altitude) * pi / 360));
save([pwd,'.\90009_traj_sep_166165_',load_batch_end_1,'.mat'],'pos');

%% 将空满载状态分开
j = 1;
k = 1;
for i = 1:length(pos.open)
if pos.open(i) == 1 %满载状态
    load_state.x(j,1) = pos.x(i);
    load_state.y(j,1) = pos.y(i);
    load_state.z(j,1) = pos.z(i);
    load_state.t(j,1) = pos.t(i);
    load_state.open(j,1) = pos.open(i);
    load_state.jing(j,1) = pos.jing(i);
    load_state.wei(j,1) = pos.wei(i);
    j = j + 1;
else
    unload_state.x(k,1) =  pos.x(i);
    unload_state.y(k,1) =  pos.y(i);
    unload_state.z(k,1) =  pos.z(i);
    unload_state.t(k,1) =  pos.t(i);
    unload_state.open(k,1) =  pos.open(i);
    unload_state.jing(k,1) = pos.jing(i);
    unload_state.wei(k,1) = pos.wei(i);
    k = k + 1;
end
end
