function [generation_cross] = crossover(generation_selet,crossover_probability,parameter)
nvar = parameter.nvar; 
xmin = parameter.xmin;
xmax = parameter.xmax;
m = parameter.m;
num_part = parameter.num_part;
idex_cross = reshape(randperm(num_part,num_part),[num_part/2 2]);

    for i=1:num_part/2
            x_bi_a = [generation_selet(idex_cross(i,1)).x_bi];
            x_bi_b = [generation_selet(idex_cross(i,2)).x_bi];
            if rand <= crossover_probability
                 k = randi(nvar*m-1);
                 generation_selet(idex_cross(i,1)).x_bi = [x_bi_a(1:k) x_bi_b(k+1:nvar*m)];
                 generation_selet(idex_cross(i,2)).x_bi = [x_bi_b(1:k) x_bi_a(k+1:nvar*m)]; 
            else
            end
    end
    
  generation_cross = generation_selet;
end

