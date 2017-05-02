function P = calcPb(H,T)
%function to calculate wave power at breaking
%P = ECn, where E = wave Energy, Cn=Cg = group velocity

g=9.81;
rho = 1025;
gamma=0.78;
E = 1./16.*rho.*g.*H.^2;
Cg=sqrt(g.*H./gamma);
P=E.*Cg;
