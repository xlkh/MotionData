%%对重复的数据进行处理
% 删除变量或数据
for i = 1 : 54837
    if openValue(i,3) == openValue(i+1,3)
      openValue(i,:) = [];
    end 
end
sortedOpenValue = sortrows(openValue, 3);
openValue = sortedOpenValue;