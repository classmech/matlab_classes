function r = rel(t,dv,w0)


r = zeros(length(t),3);


r(:,1) = dv(1)*sin(w0*t)/w0 - 2*dv(2)*cos(w0*t)/w0 + 2*dv(2)/w0;

r(:,2) = 2*dv(1)*(cos(w0*t)-1)/w0 + 4*dv(2)*sin(w0*t)/w0 - 3*dv(2)*t;

r(:,3) = dv(3)*sin(w0*t)/w0;






