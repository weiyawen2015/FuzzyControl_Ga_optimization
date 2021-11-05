function miu = PS(x,width_x,center_x)
coor_mid = [center_x(4) 1];
coor_left = [center_x(4)- width_x(4) 0];
coor_right = [center_x(4)+ width_x(4) 0];

k_left = (coor_left(2)-coor_mid(2))/(coor_left(1)-coor_mid(1));
k_right = (coor_right(2)-coor_mid(2))/(coor_right(1)-coor_mid(1));

if x>=coor_left(1)&&x<=coor_mid(1)
    miu= k_left*(x -coor_left(1));
elseif x>=coor_mid(1)&&x<=coor_right(1)
    miu = k_right*(x -coor_right(1));
else  
    miu = 0;
end
end