function global_L = get_global_L(alfa_norm,S)
 L_all = zeros(1,2);
    for i_x1 = 1:5
        for i_x2 = 1:5
             L_all=  L_all + alfa_norm(i_x1,i_x2)*S(i_x1,i_x2).L; 
        end
    end 
    global_L =  L_all;
end