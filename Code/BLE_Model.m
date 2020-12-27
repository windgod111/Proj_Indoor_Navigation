% �������ڶ�λģ�ͽ���
%IN �ȵ㵽�۲��ľ���D(m)
%IN �۲����ź�ǿ��(dbm)
%IN �۲�����Ȩ��
%OUT ģ�Ͳ��� a*log10(x)+b
function [a,b] =BLE_Model(D,RSSI,RSSI_Weights)

fo = fitoptions('Method','NonlinearLeastSquares','StartPoint',[D(2) RSSI(2)],'Robust','On','Weights',RSSI_Weights);
f = fittype('a*log10(x)+b'); % ��϶�����������ʽ
fit1 = fit(D,RSSI,f,fo);
a = fit1.a;
b = fit1.b

%display
%RSSI_Model = feval(fit1,D); % ����Ϻ���������y
%figure;
% plot(D,RSSI,'b-*');
% hold on
% plot(D,RSSI_Model,'r-*');
% hold off
% box on;
% grid on;
end