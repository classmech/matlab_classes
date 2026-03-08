
global mu;

Rz = 6371000;

mu = 398600.4415e9;

ha = 500000;
hp = 500000;

ra = Rz + ha;
rp = Rz + hp;

% Большая полуось
a  = (ra + rp)*0.5;
% Период обращения
T  = 2*pi*a^1.5/sqrt(mu);
% Эксцентрисистет
e  = (ra-rp)/(ra+rp);
% фокальный параметр
p  = rp*(1+e);
% Скорость в перигее
vp = sqrt(mu/p)*(1+e);
% Скорость в апогее
va = sqrt(mu/p)*(1-e);

fprintf('Скорость в перигее %4.2f \n',vp);
fprintf('Скорость в апогее  %4.2f \n',va);

r0 = [ra; 0;0];
v0 = [0 ;vp;0];

dv = [0.0;1.0;0.0];
v1 = v0+dv;

r0v0_0 = [r0;v0];
r0v0_1 = [r0;v1];

if is_octave
% OCTAVE
  lsode_options('relative tolerance',1e-9);
  lsode_options('absolute tolerance',1e-9);
  t = linspace(0,2*T,360);
  rv0 = lsode(@dqdt_orbit,r0v0_0,t);
  rv1 = lsode(@dqdt_orbit,r0v0_1,t);
else
% MATLAB
  t = linspace(0,2*T,360);
  opt = odeset('RelTol',1e-9,'AbsTol',1e-9);
  [t, rv0] = ode113(@dqdt_orbit_matlab,t,r0v0_0,opt);
  [t, rv1] = ode113(@dqdt_orbit_matlab,t,r0v0_1,opt);  
end  
  
Rnorm = sqrt(sum(rv0(:,1:3).^2,2));
ex    = rv0(:,1:3)./repmat(Rnorm,1,3);

ev    = rv0(:,4:6)./repmat(sqrt(sum(rv0(:,4:6).^2,2)),1,3);

ez    = cross(ex,ev,2);
ez    = ez./repmat(sqrt(sum(ez.^2,2)),1,3);

ey    = cross(ez,ex,2);

dr    = rv1(:,1:3)-rv0(:,1:3);

xrel  = sum(dr.*ex,2);
yrel  = sum(dr.*ey,2);
zrel  = sum(dr.*ez,2);

% plot(yrel,xrel);

w0 = 2*pi/T;
rrel  = rel(t,dv,w0);

abser = sqrt(sum([rrel(:,1)-xrel,rrel(:,2)-yrel,rrel(:,3)-zrel].^2,2));

plot(t,abser);
