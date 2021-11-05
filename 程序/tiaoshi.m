clear all
clc
close all
tic
addpath ./sub_gafunctions
addpath ./sub_fuzzyfunctions
%% 导入GA最优
% load width_x_optimi
% load center_x_optimi
% center_x = width_x_optimi;
% width_x = center_x_optimi;


M   = 8;  
m   = 2;     
L   = 0.5;    
g = 9.8;
a = 1/(M+m);
normal.theta = pi/2;    %90°
normal.d_theta = 5*pi/6;%150°

center_x = [-2/3 -1/3 0 1/3 2/3];
width_x = [1/3 1/3 1/3 1/3 1/3];%一半宽


% center_x = [-1/3 -1/6 0 1/6 1/3];
% width_x = [2/3 2/3 2/3 2/3 2/3];%一半宽

 rule ={@NL @NS @ZO @PS @PL};
 
 %% 求导
global A B
M   = 8;  
m   = 2;     
L   = 0.5;    
g = 9.8;
a = 1/(M+m);
syms t1 t2
f = [t2
     (g*sin(t1)-a*m*L*t2^2*sin(2*t1)/2)/(4*L/3-a*m*L*cos(t1)^2)];
A = [diff(f,t1) diff(f,t2)];
B = [0;-a*cos(t1)/(4*L/3-a*m*L*cos(t1)^2)];

%% 获得局部A B
S = getA_B(center_x,normal);
%% 求解局部反馈增益矩阵
jidian = [-4+5.457i -4-5.457i];
S = get_L(S,jidian);
%% 初始值
x = [0.1;0];
Ts = 0.05;
T_final =4;
count = 2;
x_save = zeros(T_final/Ts+1,2);
x_save(1,:) = x';
time_save = zeros(T_final/Ts+1,1);
time_save(1,:) = 0;
u_save = zeros(T_final/Ts+1,1);
time = 0;
opt_x = 1;
stable_flag = 0;
%  while(time<T_final&&stable_flag<1)
while(time<T_final)
      time = time+Ts;
    %% 求解适用度
    theta =  x(1);
    d_theta = x(2);
    alfa = get_alfa(rule,theta,d_theta,width_x,center_x,normal);
    alfa_norm = alfa/sum(alfa(:));
    %% 求解global_L
     global_L = get_global_L(alfa_norm,S);
    u = -global_L*x; 
    x = x +(S(3,3).A*x+S(3,3).B*u)*Ts;
    x_save(count,:) = x';
    time_save(count) = time;
    u_save(count) = u;
    count = count + 1;  
%         if count>10
%             if max(abs(x_save(count-5:count,1)))<1e-3
%                 stable_flag = 1;
%             end
%         end
    disp(['Time ' num2str(time) '|  stable' num2str(stable_flag)]); 
end

 toc

%% Plot
%% 画图
X_result = x_save(2:count-1,:);
F_result = u_save(2:count-1,:);
Time_result = time_save(2:count-1,:);


figure(1)
plot(Time_result, X_result(:,1)*180/pi)
grid on
xlabel('Time [s]')
ylabel('angle [°]')
legend('angle')

figure(2)
plot(Time_result, X_result(:,2)*180/pi)
grid on
xlabel('Time [s]')
ylabel('velocity [°/s]')
legend('velocity')


figure(3)
plot(Time_result,F_result,'r')
grid on
xlabel('Time [s]')
ylabel('force [N]')
legend('force')


 [Mp ts] = get_evalua(x_save,time_save)


%% 画极小值
% X_result = x_save(2:count-1,:);
%  
%  theta = X_result(:,1);
%  countxiao = 1;
% for i = 2:size(theta,1)-1
%       if theta(i)<theta(i-1)&&theta(i)<theta(i+1)
%        jixiao_time(countxiao,1) = Time_result(i);
%        jixiao_value(countxiao,1) = theta(i);
%        countxiao = countxiao+1;
%       end
% end
% 
% jixiao_value = jixiao_value*180/pi;
% 
% if countxiao>1
%     Mp = abs(jixiao_value(1));
% else
%     Mp = 0.1;
% end
% 
% u=find(abs(jixiao_value)<=1e-2)
% 
% if size(u,1)>1
%    ts = jixiao_time(u(1));
% else
%    ts = 2;
% end 
%  figure(15)
% plot(Time_result, X_result(:,1)*180/pi)
% grid on
% xlabel('Time [s]')
% ylabel('angle [°]')
% legend('angle')
% hold on
% plot(jixiao_time,jixiao_value,'b*')
% hold off
% 

 
 
 
 
 
 
 
 
 
 
 
 
 

%% 隶属度函数测试
% NL NS ZO PS PL
%  Num_ux = 1e2;   
%  u_x =linspace(-1,1,Num_ux);
%  rule ={@NL @NS @ZO @PS @PL};
% for i=1:5
%       for j = 1:Num_ux
%         miu_U_part(i,j) = rule{i}(u_x(j),width_x,center_x);
%       end
% end
% clf
% figure(1)
% hold on
% for i=1:5
%     plot(u_x,miu_U_part(i,:),'.-')
% end
%  hold off





%% 判断系统可控
% for i = 1:5
%     for j=1:5
%         A = S(i,j).A;
%         B = S(i,j).B;
%         Q = [B A*B];
%         zhi(i,j) = rank(Q);
%     end
% end
% [u v]=find(zhi<2);
% if size(u,1)>1
%     disp('不可控')
% else
%      disp('完全可控')
% end
% 





