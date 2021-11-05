function [f Mp ts] = get_Mpts(center_x,width_x,flag)
addpath ./sub_gafunctions
addpath ./sub_fuzzyfunctions
M   = 8;  
m   = 2;     
L   = 0.5;    
g = 9.8;
a = 1/(M+m);
normal.theta = pi/2;    %90°
normal.d_theta = 5*pi/6;%150°
 rule ={@NL @NS @ZO @PS @PL};
%% 获得局部A B
S = getA_B(center_x,normal);
%% 求解局部反馈增益矩阵
jidian = [-4+5.457i -4-5.457i];
S = get_L(S,jidian);
%% 初始值
x = [0.1;0];
Ts = 0.05;
T_final = 4;
count = 2;
x_save = zeros(T_final/Ts+1,2);
x_save(1,:) = x';
time_save = zeros(T_final/Ts+1,1);
time_save(1,:) = 0;
u_save = zeros(T_final/Ts+1,1);
time = 0;
opt_x = 1;
stable_flag = 0;
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
[Mp ts jixiao_time jixiao_value] = get_evalua(x_save,time_save);
Mp_normal = 0.05;
ts_normal = 2;
f = 0.5*Mp/Mp_normal + 0.5*ts/ts_normal;

%% 画图
X_result = x_save(2:count-1,:);
F_result = u_save(2:count-1,:);
Time_result = time_save(2:count-1,:);

 if flag == 0
     
     figure(1)
    plot(Time_result, X_result(:,1)*180/pi)
    grid on
    xlabel('Time [s]')
    ylabel('angle [°]')
    legend('angle')
      frame1 = getframe(gcf);
      
    figure(2)
    plot(Time_result, X_result(:,2)*180/pi)
    grid on
    xlabel('Time [s]')
    ylabel('velocity [°/s]')
    legend('velocity')
      frame2 = getframe(gcf);

    figure(3)
    plot(Time_result,F_result)
    grid on
    xlabel('Time [s]')
    ylabel('force [N]')
    legend('force')
      frame3 = getframe(gcf);
       imwrite(frame1.cdata,'angle_initi.jpg')
       imwrite(frame2.cdata,'velocity_initi.jpg')
       imwrite(frame3.cdata,'force_initi.jpg')
 
 else
    ts = jixiao_time(2); 
    figure(21)
    plot(Time_result, X_result(:,1)*180/pi)
    grid on
%     hold on
%     plot(jixiao_time,jixiao_value,'b*')
%     hold off
    xlabel('Time [s]')
    ylabel('angle [°]')
    legend('angle')
      frame1 = getframe(gcf);
    figure(22)
    plot(Time_result, X_result(:,2)*180/pi)
    grid on
    xlabel('Time [s]')
    ylabel('velocity [°/s]')
    legend('velocity')
      frame2 = getframe(gcf);

    figure(23)
    plot(Time_result,F_result)
    grid on
    xlabel('Time [s]')
    ylabel('force [N]')
    legend('force')
      frame3 = getframe(gcf);
   imwrite(frame1.cdata,'angle_optimi.jpg')
   imwrite(frame2.cdata,'velocity_optimi.jpg')
   imwrite(frame3.cdata,'force_optimi.jpg')
 end










