function [generation_selet] = percent_select(generation_sort,fitness,parameter)
nvar = parameter.nvar; 
xmin = parameter.xmin;
xmax = parameter.xmax;
m = parameter.m;
num_part = parameter.num_part;
fitnesssum = sum(fitness);
  for i=1:num_part
            s=0;
            r=rand*fitnesssum;
            for k=1:num_part
                s=s+fitness(k);
                if r<=s
                    idx=k;
                    break;
                end
            end
           generation_selet(i).x_bi =  generation_sort(idx).x_bi;%Ëæ»ú³õÊ¼
           generation_selet(i).cost =  generation_sort(idx).cost;  
    end  
end

