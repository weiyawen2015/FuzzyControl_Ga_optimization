function [generation_new] = mutation(generation_cross,mutation_probability,parameter)
nvar = parameter.nvar; 
xmin = parameter.xmin;
xmax = parameter.xmax;
m = parameter.m;
num_part = parameter.num_part;
    for i=1:num_part
          x_bi_a = [generation_cross(i).x_bi];
       if rand <= mutation_probability
                 k = randi(nvar*m);
                 if x_bi_a(k)==0
                    x_bi_a(k)==1;
                 else
                    x_bi_a(k)==0;
                 end
              generation_cross(i).x_bi = x_bi_a; 
       else
       end
    end
    generation_new = generation_cross;
end

