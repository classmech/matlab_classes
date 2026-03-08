function dq = dqdt_orbit(q,t)

global mu;

r   = q(1:3);
v   = q(4:6);

rm  = sqrt(r'*r);

er  = -r/rm;

d2r = er*mu/rm^2;

dq = [v;d2r];

