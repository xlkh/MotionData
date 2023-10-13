%% 对重复的数据进行处理
% 删除变量或数据
% 翻转矩阵
openValue = flipud(openValue);

% 删除重复数据
i = 1;
while i <= (size(openValue, 1) - 1)
    if openValue(i, 3) == openValue(i+1, 3)
        openValue(i, :) = [];
    else
        i = i + 1;
    end
end

% 再次翻转矩阵以恢复原始顺序
openValue = flipud(openValue);

% 对数据进行排序
sortedOpenValue = sortrows(openValue, 3);
openValue = sortedOpenValue;