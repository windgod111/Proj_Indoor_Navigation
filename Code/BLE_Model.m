% 蓝牙室内定位模型建立
%IN 热点到观测点的距离D(m)
%IN 观测点的信号强度(dbm)
%IN 观测量的权重
%OUT 模型参数 a*log10(x)+b
function [a,b] =BLE_Model(D,RSSI,RSSI_Weights)

fo = fitoptions('Method','NonlinearLeastSquares','StartPoint',[D(2) RSSI(2)],'Robust','On','Weights',RSSI_Weights);
f = fittype('a*log10(x)+b'); % 拟合对数函数的形式
fit1 = fit(D,RSSI,f,fo);
a = fit1.a;
b = fit1.b

%display
%RSSI_Model = feval(fit1,D); % 用拟合函数来计算y
%figure;
% plot(D,RSSI,'b-*');
% hold on
% plot(D,RSSI_Model,'r-*');
% hold off
% box on;
% grid on;
end