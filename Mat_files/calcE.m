function E = calcE(N,Ds, Dd,k)

% S(:,1) = -sqrt((1-N(:,1).^2-N(:,2).^2)./(1-N(:,2).^2+(N(:,1).^2).*((((k.^2) .* (1-N(:,1).^2))./N(:,2).^2)+2.*k)));
% S(:,2) = (S(:,1).*N(:,1).*k./N(:,2));
% E(:,1) = N(:,1).*Dd(:,1).*Ds(:,1) - S(:,1).*Ds(:,1);
% E(:,2) = N(:,2).*Dd(:,2).*Ds(:,2) + S(:,2).*Ds(:,2);

S(1) = -sqrt((1-N(1)^2-N(2)^2)/(1-N(2)^2+(N(1)^2)*((((k^2) * (1-N(1)^2))/N(2)^2)+2*k)));
S(2) = (S(1)*N(1)*k/N(2));
E(1) = N(1)*Dd(1)*Ds(1) - S(1)*Ds(1);
E(2) = N(2)*Dd(2)*Ds(2) + S(2)*Ds(2);
end
