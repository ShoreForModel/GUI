 function Ho = calcHoShoal(H,T,h1)
 %
 %  function Ho = calcHoShoal(H,T,h)
 % function to reverse shoal wave height to deep water equivalent.
 % 
 % kristen, 10
 %
 g = 9.81;
 %Lo = calcLo(T);
 %h2 = 0.6*Lo;   %deep water is d/L>0.5
 Cgo = 1./4.*g.*T./pi;
 Cg=calcCg(h1,T);
 Ks = sqrt(Cgo./Cg);
 Ho = H./(Ks);
 
 