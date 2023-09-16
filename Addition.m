%%数据增补
%opt_original = detectImportOptions('../data/90009轨迹9月.xlsx');
%opt_original.SelectedVariableNames = 4;
%opt_original.DataRange = '2:166164';
%data = readmatrix('../data/90009轨迹9月.xlsx',opt_original);
%TimeSerial = zeros(166163,1);
%for i = 1 : 166163
    %TimeSerial(i) = data(i);
%end
pos.open = zeros(166163,1);
for i = 1 : 166163
    %if openValue(i,3) == pos.linux_time(i)
    %disp (pos.linux_time(i))
    %disp (openValue(i,3))
    if abs(openValue(i,3) - pos.linux_time(i)) < 1e-1
        pos.open(i,1) = openValue(i,2);
    else 
        if i == 1
            newopenValue = [openValue(i+1,1),openValue(i+1,2),pos.linux_time(i)];
        else
            newopenValue = [openValue(i-1,1),openValue(i-1,2),pos.linux_time(i)];
        end
        openValue = [openValue;newopenValue];
        sortedOpenValue = sortrows(openValue, 3);
        openValue = sortedOpenValue;
        clear newopenValue;
        pos.open(i,1) = openValue(i,2);
        disp (i);
    end
end
save('../data/90009_traj_sep_1_166164.mat','pos');