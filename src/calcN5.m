function [N, Ds, Dd, W] = calcN5(e, guess,sigma123,w)
lsqnonlinoptions=optimset('Algorithm','Levenberg-Marquardt','display','off');
lsqnonlinoptions2=optimset('display','off');

% .   1 . 2 . 3 4   5 . 6 
%     N1 N2 Ds1 Ds2 Ds3 Dd
% ub = [1,  1, 1, 1,  1, 1]; % setting the 6th number to 0 for Dd =0
% lb = [-1,-1,-1,-1, -1, 0];

% fun = @(inputs) compEeWw(inputs,e,sigma123,w)-[e,3,0,0.25,0.1];% setting the last number to 0.1 forces Dd< Ds
fun = @(inputs) compEeWw(inputs,e,sigma123,w)-[e,3,0,0.25];% 

outputs = lsqnonlin(fun,guess,[],[],lsqnonlinoptions);
% outputs = lsqnonlin(fun,guess,lb,ub,lsqnonlinoptions2);

N = outputs(1:2);
N(3) = calcN3(N(1),N(2));
Ds = outputs(3:5);
Dd = outputs(6);
k = e(2) / e(1);
W = calcWork(sigma123, N(1:2), Ds,k,Dd);

end
