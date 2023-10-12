# MotionData
用于对数据进行数据处理的函数和结果
1.drawmap.m作用:
读取初始轨迹文件，提取EXCLE经纬度、高程数据、秒时间存入在POS结构体中
保存成“.\90009_traj_sep_1_166164.mat”
2.open.m
读取开合度报文，整理出开合度信息到openValue，存在哪？
3.addition.m
将车辆空满载状态加入到pos.open 存成mat
4.gpsTranse.m
墨卡托法将经纬度信息转换为惯导坐标系
5.divide.m
该函数将车辆空/满载时间分开 存成两个mat数据load_state和unload_state
6.loadCurve.m unloadCurve.m
计算曲率画图