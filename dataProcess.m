tic
%% 数据处理
%根据实际情况填写
load_batch_begin_0 = 2;
load_batch_end_0 = 700157;
load_batch_0 = [load_batch_begin_0,':',load_batch_end_0];
Document_Name = '.\90009轨迹8.10-8.14.xlsx';
datatime = 9.1;
%读取数据
opt = detectImportOptions('根据需要读取的文档填写');
opt.SelectedVariableNames = 3:6;
opt.DataRange = load_batch_0;
data = readmatrix(Document_Name,opt);
origin_pos = [data(1,3),data(1,4),data(1,2)];
origin_time = data(1,1);
[pos.x,pos.y,pos.z] = latlon2local(data(:,3),data(:,4),data(:,2),origin_pos);
%数据清理
i = 2;
while i <= (length(pos.linux_time))
  if pos.linux_time(i) == pos.linux_time(i-1)
     pos.linux_time(i) = [];
     pos.x(i) = [];
     pos.y(i) = [];
     pos.z(i) = [];
  else
     i = i + 1;
  end
end
pos.linux_time = origin_time;
%% 转换时间
normal_time = ones(length(origin_time),1);
formattedTime = ones(length(origin_time),1);
for i = 1 : length(origin_time)
normal_time(i) =  datetime(origin_time(i), 'ConvertFrom', 'posixtime');
formattedTime(i) = datestr(normal_time(i),'yyyy-MM-dd HH:MM:SS');
timepart = timeofday(formattedTime);
pos.t = seconds(timepart);
clear normal_time;
end

%% 存储数据 & 创建EXCLE表格
save([pwd,'.\90009_traj_sep_',load_batch_begin_0,load_batch_end_0,',mat'],'pos');
file_data = [pos.linux_time,formattedTime,pos.x,pox.y,pos.z,];
file_name = ['90009_traj_sep_',load_batch_0,'.xlsx']; 
% 指定工作表名称
sheet_name = 'Sheet1';
% 使用 writematrix 函数将数据写入指定工作表
writematrix(file_data, file_name, 'Sheet', sheet_name);

elapsedTime = toc;
fprintf('函数运行时间为 %.4f 秒\n', elapsedTime);