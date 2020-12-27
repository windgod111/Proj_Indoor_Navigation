%蓝牙室内定位AOA方法模拟
clear;
baseposition_path = 'G:\Indoor Navigation\Data_UPINLBS2019\BasePosition.txt';
basedata = importdata(baseposition_path,' ');
%选取B1、B2、B3、B4点
Bi = basedata.data(1:4,:);
%观测点的位置
obsposition_path = 'G:\Indoor Navigation\Data_UPINLBS2019\ObservationPosition.txt';
obsposition = load(obsposition_path);
obs1 = [obsposition(1,:) 0.8];%观测点1的位置
%display
figure
plot3(Bi(:,1),Bi(:,2),Bi(:,3),'r*');
hold on
plot3(obs1(1),obs1(2),obs1(3),'b*');
hold off
box on;
grid on;

Vi = [];
for i=1:4
    d = sqrt((Bi(i,2) - obs1(2))^2+(Bi(i,1) - obs1(1))^2+(Bi(i,3) - obs1(3))^2);
    a = Bi(i,3) - obs1(3);
    b = sqrt((Bi(i,2) - obs1(2))^2+(Bi(i,1) - obs1(1))^2);
    Vi(i,:) =a/b;
end
tanA_square = Vi.*Vi;
%使用fsolve求解多元非线性方程组
X_b1 = Bi(1,1);
Y_b1 = Bi(1,2);
Z_b1 = Bi(1,3);
X_b2 = Bi(2,1);
Y_b2 = Bi(2,2);
Z_b2 = Bi(2,3);
X_b3 = Bi(3,1);
Y_b3 = Bi(3,2);
Z_b3 = Bi(3,3);
tanA1 = tanA_square(1);
tanA2 = tanA_square(2);
tanA3 = tanA_square(3);

f=@(x)[(x(3)-Z_b1)^2/((x(1)-X_b1)^2+(x(2)-Y_b1)^2)-tanA1;(x(3)-Z_b2)^2/((x(1)-X_b2)^2+(x(2)-Y_b2)^2)-tanA2;(x(3)-Z_b3)^2/((x(1)-X_b3)^2+(x(2)-Y_b3)^2)-tanA3];

%(obs1(3)-Z_b1)^2/((obs1(1)-X_b1)^2+(obs1(2)-Y_b1)^2)-tanA1

x0=[(X_b1+X_b2+X_b3)/3,(Y_b1+Y_b2+Y_b3)/3,1];
[x,fval]=fsolve(f,x0);










