open = zeros(78304,1);
Opts1 =detectImportOptions('../data/74openFit9.1.xlsx');
Opts1.SelectedVariableNames = 3;
opt1.DataRange = '2:78305';
openValue = zeros(78304,3);
data = readmatrix('../data/74openFit9.1.xlsx',Opts1);
for i = 1:size(data,1)
    dataString =char(data{i,1});
    pattern = '\d+\.\d+'; % 匹配一个或多个数字
    matches = regexp(dataString, pattern, 'match');
    if ~isempty(matches)
    openValue(i,1) = str2double(matches{end}); % 获取最后一个匹配的数字
    if  openValue(i,1) < 158 && openValue(i,1) >= 140 
        openValue(i,2) = 1;
    else if openValue(i,1) >=158 
        openValue(i,2) = 0;
        end
    end
    
else
    fprintf('未找到开合度值。\n');
    end
end 
%%对特殊值进行处理
    for i = 2:78302
        if openValue(i,2)~= openValue(i-1,2) && openValue(i,2)~=openValue(i+1,2)
            openValue(i,2) = openValue(i-1,2); 
        end
        if openValue(i,2) ~= openValue(i-1,2) && openValue(i+1,2)~=openValue(i+2,2)
            openValue(i,2) = openValue(i-1,2); 
            openValue(i+1,2) = openValue(i+2,2);
        end
        open(i) = openValue(i,2);
    end
Opts1.SelectedVariableNames = 5;
opt1.DataRange = '2:78305';
data1 = readmatrix('../data/74openFit9.1.xlsx',Opts1);
for i = 1 : 78304
openValue(i,3) = data1(i);
end