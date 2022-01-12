function [ang2] = make180(ang1)
ang1 = make360(ang1);
n1 = length(ang1);
ang2(1:n1) = 0;
for ii=1:n1
   if (ang1(ii) > 180)
       ang2(ii) = ang1(ii)-360;
   else
       ang2(ii) = ang1(ii);
   end
   
   
end

end