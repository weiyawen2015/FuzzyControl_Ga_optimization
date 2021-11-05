function miu = NL(x,width_x,center_x)
coor1 = [center_x(1) 1];
coor2 = [center_x(1)+width_x(1) 0];
k = (coor1(2)-coor2(2))/(coor1(1)-coor2(1));
if x<=center_x(1)&&x>=-1
    miu=1;
elseif x>=center_x(1)&&x<=center_x(1)+width_x(1)
    miu = k*(x -coor2(1));
else  
    miu = 0;
end
end