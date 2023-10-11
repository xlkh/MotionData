%%用来绘画卸载区车辆行驶轨迹
opt1 = detectImportOptions('E:\data\MotionData\90009轨迹9月.xlsx');
opt1.SelectedVariableNames = 6:8;
opt1.DataRange = '55981:56398';
data = readmatrix('E:\data\MotionData\90009轨迹9月.xlsx',opt1);
origin_pos = [data(1,3),data(1,2),0];

[pos1.x,pos1.y,pos1.z] = latlon2local(data(:,3),data(:,2),data(:,1),origin_pos);
opt2 = detectImportOptions('E:\data\MotionData\90009轨迹9月.xlsx');
opt2.SelectedVariableNames = 5 ;
opt2.DataRange = '55981:56398';
date = readtable('E:\data\MotionData\90009轨迹9月.xlsx',opt2);

datatimeString = char(date{:,1});
dataTimeObj = datetime(datatimeString,'format','yyyy-MM-dd HH:mm:ss');
timepart = timeofday(dataTimeObj);
pos1.t = seconds(timepart); 
opt3 = detectImportOptions('E:\data\MotionData\90009轨迹9月.xlsx');
opt3.SelectedVariableNames = 4 ;
opt3.DataRange = '55981:56398';
linux_time = readmatrix('E:\data\MotionData\90009轨迹9月.xlsx',opt3);
pos1.linux_time = linux_time;

save('E:\data\MotionData\90009_curve_traj_sep_1_166164.mat','pos1');
%plot3(pos1.x,pos1.y,pos1.t);
plot(pos1.x,pos1.y);
axis equal;