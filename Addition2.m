load_batch_end_1 = '285664';

% 创建一个新的矩阵用于存储增补后的数据
%newData = [];

% 循环遍历时间戳
for i = 1:length(pos.linux_time)
    currentTimestamp = pos.linux_time(i);
    
    % 查找在openValue中具有相同时间戳的行
    matchingRows = find(abs(openValue(:, 3) - currentTimestamp) < 1e-1);
    
    if ~isempty(matchingRows)
        % 如果找到匹配的行，使用第一个匹配行的数据
        %newRow = openValue(matchingRows(1), :);
    else
        % 如果没有匹配的行，根据相邻的数据补充
        if i == 1
            newRow = [openValue(1,1),openValue(1,2),pos.linux_time(i)]; % 使用第一行数据
        else
            if i < length(openValue)
            newRow = [openValue(i+1,1),openValue(i+1,2),pos.linux_time(i)]; % 使用前一行数据  
            else
            newRow = [openValue(length(openValue),:)]; % 如果超出范围直接选择最后一个数据
            end
        end
         openValue = [openValue; newRow];
         sortedOpenValue = sortrows(openValue, 3);
         openValue = sortedOpenValue;
    end
    % 添加新行到新数据矩阵
    %newData = [newData; newRow];
    %sortednewData = sortrows(newData, 3);
end
% 更新pos.open
%sortednewData = sortrows(newData, 3);
Delete;
pos.open = sortedOpenValue(:, 2);

% 保存增补后的数据
save([pwd, '.\90009_traj_sep_166165_', load_batch_end_1, '.mat'], 'pos');

% 显示运行时间
fprintf('函数运行时间为 %.4f 秒\n', elapsedTime);