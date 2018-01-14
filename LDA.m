data = xlsread('xxx\LDA\watermelon_data'); %从excel中导入数据。
x_data_1 = (data(:,1))';
x_data_2 = (data(:,2))';
x_data = [x_data_1;x_data_2];
y_data = (data(:,3))';
%计算均值
u = zeros(2,1);
for i = 1:8
    u = u+x_data(:,i);
end
u_good = u./8;
u = zeros(2,1);
for i = 1:9
    u = u+x_data(:,i+8);
end
u_bad = u./9;
clear u;
%计算协方差
COV_good = cov(x_data(:,1:8)');  %cov的用法：每行为每一个观测点  每列为一个观测点的一个变量
COV_bad = cov(x_data(:,9:17)');
%类内散度矩阵
S_w1 = zeros(2,2);
for i = 1:8
    S_w1 = S_w1+(x_data(:,i) - u_good)*(x_data(:,i) - u_good)';
end
S_w2 = zeros(2,2);
for i = 1:8
    S_w2 = S_w2+(x_data(:,i+8) - u_bad)*(x_data(:,i+8) - u_bad)';
end
S_w = S_w1 + S_w2;
%奇异值分解S_w
[U,S,V] = svd (S_w);
w = (V/S*(U'))*(u_good-u_bad);
%作图
for i=1:17     
    if y_data(i) == 1
       plot(x_data(1,i),x_data(2,i),'+r');
       hold on;
    else if y_data(i) == 0
       plot(x_data(1,i),x_data(2,i),'og');    
       hold on;
        end
    end
end
refline(-w(1,:)/w(2,:));

xlabel('密度');
ylabel('含糖率');
title('线性判别分析（LDA）'); 
