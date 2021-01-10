%NewtonRapshon法求解多元非线性方程组
%pos_base:基站位置
%tanA_square，观测值角度的tan平方
%N，观测量的个数
%pos0,观测点大概位置
%err,方程组解算精度要求
%it_max，最大迭代次数

function [X,dx,it_n] = AOA_NewtonRapshon(pos_base,tanA_square,N,pos0,err,it_max)
    if N < 3
        error('N = %d',N);
    end
    if (size(pos_base,1) ~= N) && (size(tanA_square,1)~= N)
        error('size(pos_base,1) ~= N or size(tanA_square,1)~= N');
    end
    
    B = zeros(N,3);
    L = zeros(N,1);

for i = 1:it_max
    
    for j= 1:N
        B(j,1) = 2*tanA_square(j,1)*(pos_base(j,1) - pos0(1));
        B(j,2) = 2*tanA_square(j,1)*(pos_base(j,2) - pos0(2));
        B(j,3) = -2*(pos_base(j,3) - pos0(3));
        
        L(j,1) = tanA_square(j,1)*(pos_base(j,1)-pos0(1))^2 + tanA_square(j,1)*(pos_base(j,2)-pos0(2))^2 - (pos_base(j,3)-pos0(3))^2 ;
    end

    dx = B\L;
    pos0 = pos0+dx';
    if max(dx) < err
        break;
    end
end
X = pos0;
it_n = i;
    

end