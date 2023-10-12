%%该函数将车辆空/满载时间分开 
%load('90009_traj_sep_1_166164.mat');
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
save('E:\data\MotionData\90009_load_traj_1_285664','load_state');
save('E:\data\MotionData\90009_load_traj_1_285664','unload_state');
%save('E:\data\MotionData\90009_load_traj','load_state');
%save('E:\data\MotionData\90009_unload_traj','unload_state');