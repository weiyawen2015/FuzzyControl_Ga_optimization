clear all
clc
close all
addpath ./sub_gafunctions
addpath ./sub_fuzzyfunctions
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

%% 获取优化前响应图像
center_x_init = [-2/3 -1/3 0 1/3 2/3];
width_x_init = [1/3 1/3 1/3 1/3 1/3];%一半宽
get_rule_figu(center_x_init,width_x_init,0)
[f Mp_init ts_init] = get_Mpts(center_x_init,width_x_init,0)
save Mp_init  Mp_init 
save ts_init ts_init

%% GA优化算法

%% 参数
parameter.nvar = 5;
center_xmin = [15 65]/100;%PS PL的center
center_xmax = [60 95]/100;%PS PL的center
wid_xmin = [1/10 1/10 1/10];%ZO PS PL的width
wid_xmax = [40 40 40]/10;%ZO PS PL的width
parameter.xmin = [center_xmin wid_xmin];
parameter.xmax = [center_xmax wid_xmax];
parameter.m = 30; 
parameter.k = 15;%控制适配值之间差异的常数
parameter.num_part =4;%种群数量
itermax = 3;
crossover_probability = 0.5;
mutation_probability = 0.001;
num_part = parameter.num_part;
nvar = parameter.nvar; 
xmin = parameter.xmin;
xmax = parameter.xmax;
m = parameter.m;
   %% 初始化
    generation = repmat([], num_part, 1);
    for i = 1:num_part
       i
        generation(i).x_bi = randi([0,1],1,parameter.nvar*parameter.m);%随机初始
        generation(i).cost = my_fuzzyobj(generation(i).x_bi,parameter);
    end
   generation_new =generation;   
   dert_mean_cost = 1;
iter = 1;
while(dert_mean_cost>1e-5&&iter<=itermax)
    
generation = generation_new;
%% 复制选择
[cost_sort index] = sort([generation.cost]');
generation_sort = generation(index);%从小到大 对应
   for i = 1:num_part
      fitness(i) = parameter.k*(num_part-i)/num_part;
   end 
fitness_percent = fitness/sum(fitness);
[generation_selet] = percent_select(generation_sort,fitness,parameter); 
%% 交叉
 [generation_cross] = crossover(generation_selet,crossover_probability,parameter);
%% 变异，                     
[generation_new] = mutation(generation_cross,mutation_probability,parameter);
best(iter).cost = 10;
for i = 1:num_part
    generation_new(i).cost = my_fuzzyobj(generation_new(i).x_bi,parameter);
    if generation_new(i).cost< best(iter).cost
        best(iter).cost = generation_new(i).cost;
        best(iter).x_bi = generation_new(i).x_bi;
    end
end
    meancost(iter) = mean([generation_new.cost]);
  disp(['Iteration ' num2str(iter) '| mean cost ' num2str(meancost(iter)) '| best_cost ' num2str(best(iter).cost)]);
     if  iter==1
        dert_mean_cost = 1;
     else
          dert_mean_cost = abs(meancost(iter) - meancost(iter-1));
     end
    iter = iter + 1;
end
  disp('平均最优值')
 meanobj = meancost(iter-1)
  disp('全局最优值')
 bestobj =  best(iter-1).cost
 disp('最优值对应自变量')
nvar = parameter.nvar; 
xmin = parameter.xmin;
xmax = parameter.xmax;
m = parameter.m;
x_obj = best(iter-1).x_bi;
x_binew = reshape(x_obj,[m nvar]);
for i = 1:nvar
    b(i) = bi2de(x_binew(:,i)');  
end
x = xmin + b.*(xmax-xmin)/(2^m-1);
center_x_optimi = [-x(2) -x(1) 0 x(1) x(2)];
width_x_optimi = [x(5) x(4) x(3) x(4) x(5)];%一半宽
center_x_optimi
width_x_optimi


%% 获取优化后响应图像
get_rule_figu(center_x_optimi,width_x_optimi,1)
[f Mp_optimi ts_optimi] = get_Mpts(center_x_optimi,width_x_optimi,1)
save center_x_optimi center_x_optimi
save width_x_optimi width_x_optimi
save Mp_optimi  Mp_optimi 
save ts_optimi ts_optimi
save GA_guocheng
 %% 画优化曲线
   figure(4)
 plot(1:iter-1,[best.cost]);
   title('最优个体适配值曲线');
  frame1 = getframe(gcf);
  imwrite(frame1.cdata,'最优个体适配值曲线.jpg')
 
 figure(5)
 plot(1:iter-1,meancost(1:iter-1));
    title('平均适配值曲线');
  frame2 = getframe(gcf);
  imwrite(frame2.cdata,'平均适配值曲线.jpg')
    