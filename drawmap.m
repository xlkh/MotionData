%% 数据处理
load_batch_end = '166164';
load_batch = ['2:', load_batch_end];%为什么是166164？
%获取数据
opt1 = detectImportOptions('.\90009轨迹9月.xlsx');
opt1.SelectedVariableNames = 6:8;
opt1.DataRange = load_batch;
data = readmatrix('.\90009轨迹9月.xlsx',opt1);
origin_pos = [data(1,3),data(1,2),0];
%提取EXCLE经纬度、高程数据存入在POS中
[pos.x,pos.y,pos.z] = latlon2local(data(:,3),data(:,2),data(:,1),origin_pos);
opt2 = detectImportOptions('.\90009轨迹9月.xlsx');
opt2.SelectedVariableNames = 5 ;
opt2.DataRange = load_batch;
date = readtable('.\90009轨迹9月.xlsx',opt2);
%将UNIX时间装换为秒
datatimeString = char(date{:,1});
dataTimeObj = datetime(datatimeString,'format','yyyy-MM-dd HH:mm:ss');
timepart = timeofday(dataTimeObj);
pos.t = seconds(timepart); 
opt3 = detectImportOptions('.\90009轨迹9月.xlsx');
opt3.SelectedVariableNames = 4 ;
opt3.DataRange = load_batch;
linux_time = readmatrix('.\90009轨迹9月.xlsx',opt3);
pos.linux_time = linux_time;
%将时间存入POS中
%pos.time = ConvertDate(data(:,1));
%把计算后的数据存储到pos当中 以后所有的数据都以.mat形式存入到pos当中
save([ pwd, '.\90009_traj_sep_1_',load_batch_end,'.mat' ],'pos');

%function [date] = ConvertDate(x)
%date = datetime( x/1000, 'ConvertFrom', 'posixtime' ,'TimeZone','LOCAL','Format','uuuu-MM-dd'' ''HH:mm:ss.SSS'); %datetime类型
%end

%% 绘图
% load ../data/90009_traj_sep_1_100000.mat;
%plot(pos.x,pos.y);
% plot3(pos.x,pos.y,pos.z);
plot3(pos.x,pos.y,pos.t);
axis equal;