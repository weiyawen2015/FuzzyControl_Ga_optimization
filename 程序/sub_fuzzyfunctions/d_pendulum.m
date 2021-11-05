function dxdt = d_pendulum(t,x,u)
% global u
M   = 8;  
m   = 2;     
L   = 0.5;    
g = 9.8;
a = 1/(M+m);
dxdt = zeros(2,1);
% Lagrangian equation
dxdt(1) = x(2);
dxdt(2) = (g*sin(x(1)) - a*m*L*(x(2)^2)*sin(2*x(1))/2 - a*cos(x(1))*u)/(4*L/3 - a*m*L*cos(x(1))^2);
end