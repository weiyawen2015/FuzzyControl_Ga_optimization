function f = my_fuzzyobj(x_bi,parameter)
addpath ./sub_gafunctions
addpath ./sub_fuzzyfunctions
nvar = parameter.nvar; 
xmin = parameter.xmin;
xmax = parameter.xmax;
m = parameter.m;

x_binew = reshape(x_bi,[m nvar]);
for i = 1:nvar
    b(i) = bi2de(x_binew(:,i)');  
end
x = xmin + b.*(xmax-xmin)/(2^m-1);

center_x = [-x(2) -x(1) 0 x(1) x(2)];
width_x = [x(5) x(4) x(3) x(4) x(5)];%һ���

% center_x
% width_x
% center_xmin = [10 65]/100;%PS PL��center
% center_xmax = [60 95]/100;%PS PL��center
% wid_xmin = [2/10 2/10 2/10];%ZO PS PL��width
% wid_xmax = [6 6 6]/10;%ZO PS PL��width


M   = 8;  
m   = 2;     
L   = 0.5;    
g = 9.8;
a = 1/(M+m);
normal.theta = pi/2;    %90��
normal.d_theta = 5*pi/6;%150��
% center_x = [-2/3 -1/3 0 1/3 2/3];
% width_x = [1/3 1/3 1/3 1/3 1/3];%һ���
% center_x = [-2/4 -1/4 0 1/4 2/4];
% width_x = [1/3 1/2 1/2 1/2 1/3];%һ���
 rule ={@NL @NS @ZO @PS @PL};
%% ��þֲ�A B
S = getA_B(center_x,normal);
%% ���ֲ������������
jidian = [-4+5.457i -4-5.457i];
S = get_L(S,jidian);
%% ��ʼֵ
x = [0.1;0];
Ts = 0.05;
T_final = 5;
count = 2;
x_save = zeros(T_final/Ts+1,2);
x_save(1,:) = x';
time_save = zeros(T_final/Ts+1,1);
time_save(1,:) = 0;
u_save = zeros(T_final/Ts+1,1);
time = 0;
opt_x = 1;
stable_flag = 0;
 while(time<T_final&&stable_flag<1)
      time = time+Ts;
    %% ������ö�
    theta =  x(1);
    d_theta = x(2);
    alfa = get_alfa(rule,theta,d_theta,width_x,center_x,normal);
    alfa_norm = alfa/sum(alfa(:));
    %% ���global_L
    global_L = get_global_L(alfa_norm,S);
    u = -global_L*x; 
    x = x +(S(3,3).A*x+S(3,3).B*u)*Ts;
    x_save(count,:) = x';
    time_save(count) = time;
    u_save(count) = u;
    count = count + 1;  
        if count>10
            if max(abs(x_save(count-5:count,1)))<1e-3
                stable_flag = 1;
            end
        end     
        
%    disp(['Time ' num2str(time) '|  stable' num2str(stable_flag)]);
 end
 [Mp ts] = get_evalua(x_save,time_save);
Mp_normal = 0.05;
ts_normal = 2;
f = 0.5*Mp/Mp_normal + 0.5*ts/ts_normal;







