function Cg=calcCg(h,T);
%function to calculate group velocity, Cg.
h=h(:);
T=T(:);
 g = 9.81;
% L = calcL(T,h);
% C=L./T;
% hL=h./L;
% n=0.5.*(1+4.*pi.*hL./sinh(4.*pi.*hL));
% Cg=n.*C;
%k = dispsol2(h, 1./T,0);
%%%calc k from mark linear
y=4.03*h./(T.^2);
kd2=y.^2 + y ./ ...
    (1+(0.666.*y)+(0.355.*y.^2)+(0.161.*y.^3)+(0.0632.*y.^4)+(0.0218.*y.^5)+(0.00564.*y.^6));
%k=sqrt(kd2)./h;

%kh = k(:).*h(:);
kh=sqrt(kd2);
Cg = g.*T./(2.*pi).*(tanh(kh)).*(0.5.*(1+2.*kh./sinh(2.*kh)));
