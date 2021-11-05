function S = get_L(S,jidian)
    for i_x1 = 1:5
       for i_x2 = 1:5
        A = S(i_x1,i_x2).A;
        B = S(i_x1,i_x2).B;
        xishu_jidian = [ -sum(jidian) jidian(1)*jidian(2)];
        xishu_A = charpoly(A);
        K_pre = [xishu_jidian(2)-xishu_A(3) xishu_jidian(1)-xishu_A(2)];
        T_c1 = [A*B B]*[1 0;xishu_A(2) 1];
        S(i_x1,i_x2).L = K_pre*T_c1^(-1);    
       end
    end
end