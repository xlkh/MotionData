tic;
%%数据增补
load_batch_end_1 = '285664';
valid = 0;
clear sortedOpenValue;
%opt_original = detectImportOptions('../data/90009轨迹9月.xlsx');
%opt_original.SelectedVariableNames = 4;
%opt_original.DataRange = '2:166164';
%data = readmatrix('../data/90009轨迹9月.xlsx',opt_original);
%TimeSerial = zeros(166163,1);
%for i = 1 : 166163
    %TimeSerial(i) = data(i);
%end
%pos.open = zeros(166163,1); %这里需要根据数据的大小来设置矩阵的大小

%for i = 1 : 166163 %这一部分的作用是将车辆空满载状态加入到pos.mat当中
%时间轴对齐
 for i = 1 : 119500
    %if openValue(i,3) == pos.linux_time(i)
    
    %由于数据存在非常小的误差 因此在这里需要设计一个判断
    for j = 1 : size(openValue,1)
        if abs(openValue(j,3) - pos.linux_time(i)) < 1e-1 
            valid = 1 ; 
            break
        else
            valid = 0;
        end
    end
    if valid == 1    
        pos.open(i,1) = openValue(i,2);
    else 
        if i == 1
            newopenValue = [openValue(i+1,1),openValue(i+1,2),pos.linux_time(i)];
        else
            newopenValue = [openValue(i-1,1),openValue(i-1,2),pos.linux_time(i)];
        end
        %由于采样频率的原因导致时间上存在差异 因此要根据相邻的数据来补全
        openValue = [openValue;newopenValue];
        clear newopenValue;
    end
    sortedOpenValue = sortrows(openValue, 3);
    openValue = sortedOpenValue;%对数据进行正向排序
    pos.open = openValue(:,2);
end
pos.colors = cell(size(pos.open));
%for i = 1:length(pos.open)
%    if pos.open(i) == 0
%        pos.colors{i} = 'r'; % 如果pos.open为0，设置为红色
%    else
%        pos.colors{i} = 'b'; % 如果pos.open为1，设置为蓝色
%    end
%end
save([pwd,'.\90009_traj_sep_166165_',load_batch_end_1,'.mat'],'pos');

%%画图
%figure;
%for i = 1:length(pos.x)
%    color = pos.colors{i}; % 从pos.colors获取颜色字符串
%    plot3(pos.x(i), pos.y(i), pos.t(i), 'o', 'MarkerSize', 8, 'MarkerFaceColor', color, 'MarkerEdgeColor', color);
%    disp (i);
%    hold on;
%end
elapsedTime = toc;

% 显示运行时间
fprintf('函数运行时间为 %.4f 秒\n', elapsedTime);