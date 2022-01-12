function E = calcE(N,Ds, Dd,k)
N3 = calcN3(N(1),N(2));
S = N2S(N,k);
 
E(1) = sqrt((N(1)*Dd)^2 + (S(1)*Ds(1))^2);
E(2) = sign(k)*sqrt((N(2)*Dd)^2 + (S(2)*Ds(2))^2);
E(3) = -sqrt((N3*Ds(3))^2 + (S(3)*Dd)^2);

end
