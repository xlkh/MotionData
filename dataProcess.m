tic
%% 数据处理
%根据实际情况填写
load_batch_begin_0 = '2';
load_batch_end_0 = '700157';
load_batch_0 = [load_batch_begin_0,':',load_batch_end_0];
Document_Name = '.\90009轨迹8.10-8.14.xlsx';
%读取数据
opt = detectImportOptions(Document_Name);
opt.SelectedVariableNames = 4:7;
opt.DataRange = load_batch_0;
data = readmatrix(Document_Name,opt);
origin_pos = [data(1,3),data(1,4),data(1,2)];
origin_time = data(:,1);
[pos.x,pos.y,pos.z] = latlon2local(data(:,3),data(:,4),data(:,2),origin_pos);
pos.linux_time = origin_time;

%% 转换时间
% 将时间戳转换为日期时间对象，加上时区偏移
formattedTimes = cell(length(pos.linux_time),1);
formattedTimes1 = cell(length(pos.linux_time),1);
for i = 1 : length(pos.linux_time)
    dt = datetime((origin_time(i) + 28800000) / 86400000 + datenum(1970, 1, 1), 'ConvertFrom', 'datenum');
    dt2 = datetime((origin_time(i)/1000+8*3600)/86400+70*365+19, 'ConvertFrom', 'datenum');
    % 将日期时间对象格式化为字符串，并将其转换为 double
    formattedTime = datestr(dt, 'yyyy-mm-dd HH:MM:SS.FFF');
    formattedTimes{i} = formattedTime;
end

%% 数据清理
i = 2;
while i <= (length(pos.linux_time))
  if pos.linux_time(i) - pos.linux_time(i-1) < 1e-3
     pos.linux_time(i) = [];
     pos.x(i) = [];
     pos.y(i) = [];
     pos.z(i) = [];
     data(i,:) = [];
     formattedTimes(i) = [];
  else
     i = i + 1;
  end
end
formattedTimes = unique(formattedTimes, 'stable');

%% 存储数据 & 创建EXCLE表格
save([pwd,'.\90009_traj_sep_',load_batch_begin_0,'_',load_batch_end_0,',mat'],'pos');
file_name = '90009_traj_sep_2.xlsx'; 
file_data_0 = [pos.linux_time];
file_data_1 = [data(:,3),data(:,4),data(:,2)];
sheet_name = 'Sheet1';
% 使用 writematrix 函数将数据写入指定工作表
writematrix(file_data_0, file_name, 'Sheet', sheet_name,'Range','A2');
writematrix(file_data_1, file_name, 'Sheet', sheet_name,'Range','C2');
headerText = {'时间戳', '年月日','经度', '纬度', '高程'};
writecell(headerText, file_name, 'Sheet', sheet_name);
writecell(formattedTimes, file_name, 'Sheet', sheet_name,'Range','B2');

elapsedTime = toc;
fprintf('函数运行时间为 %.4f 秒\n', elapsedTime);