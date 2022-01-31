function e = calcEstrain(sigma123,PM,YM)
e = zeros(size(sigma123,1),3);
e(:,1) = (sigma123(:,1) - PM*(sigma123(:,2) + sigma123(:,3))) ./ YM;
e(:,2) = (sigma123(:,2) - PM*(sigma123(:,1) + sigma123(:,3))) ./ YM;
e(:,3) = (sigma123(:,3) - PM*(sigma123(:,1) + sigma123(:,2))) ./ YM;
end
