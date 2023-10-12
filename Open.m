%%开合度计算公式
open = zeros(78304,2);%矩阵初始化
Opts1 =detectImportOptions('.\74openFit9.1.xlsx');
Opts1.SelectedVariableNames = 3;
opt1.DataRange = '2:78305';
openValue = zeros(78304,3);
data = readmatrix('.\74openFit9.1.xlsx',Opts1);%读取数据

%使用正则化进行数据匹配
for i = 1:size(data,1)
    dataString =char(data{i,1});
    pattern = '\d+\.\d+'; % 匹配一个或多个数字
    matches = regexp(dataString, pattern, 'match');
%根据匹配结果来计算车辆是否为满载或空载
    if ~isempty(matches)
    openValue(i,1) = str2double(matches{end}); % 获取最后一个匹配的数字
    if  openValue(i,1) < 158 && openValue(i,1) >= 140 
        openValue(i,2) = 1;% 1表达为满载
    else if openValue(i,1) >=158  
        openValue(i,2) = 0;  % 0表达为空载
        end
    end
    
else
    fprintf('未找到开合度值。\n');
    end
end 
%%对特殊值进行处理
%如果附近的数据相差太大可以认为该数据存在问题需要更改
    for i = 2:78302
        if openValue(i,2)~= openValue(i-1,2) && openValue(i,2)~=openValue(i+1,2)
            openValue(i,2) = openValue(i-1,2); 
        end
        if openValue(i,2) ~= openValue(i-1,2) && openValue(i+1,2)~=openValue(i+2,2)
            openValue(i,2) = openValue(i-1,2); 
            openValue(i+1,2) = openValue(i+2,2);
        end
        open(i,1) = openValue(i,2);
        open(i,2) = openValue(i,3);
    end
Opts1.SelectedVariableNames = 5;
opt1.DataRange = '2:78305';
data1 = readmatrix('E:\data\MotionData\74openFit9.1.xlsx',Opts1);
for i = 1 : 78304
openValue(i,3) = data1(i);
end