%% 数据处理
opt1 = detectImportOptions('../data/90009轨迹9月.xlsx');
opt1.SelectedVariableNames = 6:8;
opt1.DataRange = '2:166164';
data = readmatrix('../data/90009轨迹9月.xlsx',opt1);
origin_pos = [data(1,3),data(1,2),0];
[pos.x,pos.y,pos.z] = latlon2local(data(:,3),data(:,2),data(:,1),origin_pos);
opt2 = detectImportOptions('../data/90009轨迹9月.xlsx');
opt2.SelectedVariableNames = 5 ;
opt2.DataRange = '2:166164';
date = readtable('../data/90009轨迹9月.xlsx',opt2);
datatimeString = char(date{:,1});
dataTimeObj = datetime(datatimeString,'format','yyyy-MM-dd HH:mm:ss');
timepart = timeofday(dataTimeObj);
pos.t = seconds(timepart); 
opt3 = detectImportOptions('../data/90009轨迹9月.xlsx');
opt3.SelectedVariableNames = 4 ;
opt3.DataRange = '2:166164';
linux_time = readmatrix('../data/90009轨迹9月.xlsx',opt3);
pos.linux_time = linux_time;
%pos.time = ConvertDate(data(:,1));
save('../data/90009_traj_sep_1_166164.mat','pos');

%function [date] = ConvertDate(x)
%date = datetime( x/1000, 'ConvertFrom', 'posixtime' ,'TimeZone','LOCAL','Format','uuuu-MM-dd'' ''HH:mm:ss.SSS'); %datetime类型
%end

%% 绘图
% load ../data/90009_traj_sep_1_100000.mat;
% 
%plot(pos.x,pos.y);
% plot3(pos.x,pos.y,pos.z);
plot3(pos.x,pos.y,pos.t);
%axis equal;