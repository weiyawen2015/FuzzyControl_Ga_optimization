function S = getA_B(center_x,normal)
global A B


M   = 8;  
m   = 2;     
L   = 0.5;    
g = 9.8;
a = 1/(M+m);
center_t1 = center_x*normal.theta;  %90бу
center_t2 = center_x*normal.d_theta;%150бу
for i_t1 = 1:5
    for i_t2 = 1:5
        t1 = center_t1(i_t1);
        t2 = center_t2(i_t2);
        S(i_t1,i_t2).A = double(vpa(subs(A)));
        S(i_t1,i_t2).B = double(vpa(subs(B)));
    end
end
end