clc;
p.a = 5; p.b = 8;
p.m = 4;
[t,q] = ode45(@(t,q) dqdt1(t,q,p),0:0.001:10,[1;0],odeset('AbsTol',1e-9));
plot(t,q(:,2));
plot(q(:,1),q(:,2));
max(q(t>3 & t<5,2))
sqrt(q(end,1)^2+q(end,2)^2)


%%
p.a = 1; p.b = 0.25; p.c = 1;
p.m = 10;
[t,q] = ode45(@(t,q) dqdt2(t,q,p),0:0.001:10,[1;0],odeset('AbsTol',1e-9));
plot(t,q(:,1));
plot(q(:,1),q(:,2));
max(q(t>35 & t<45))
sqrt(q(end,1)^2+q(end,2)^2)

%
function dq = dqdt1(t,q,p)
    dq = [0;0];
    x  = q(1); v  = q(2);
    dq(1) = q(2);
    dq(2) = (-p.a*x+2*x*sin(p.b*t))/p.m;
end

%
function dq = dqdt2(t,q,p)
    dq = [0;0];
    x  = q(1); v  = q(2);
    dq(1) = q(2);
    dq(2) = (-p.a*x - p.c*v - p.b*x^3)/p.m;
end
