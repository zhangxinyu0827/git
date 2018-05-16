function [slope,slope2] = getSplineSlope2(spl, tt)
% Compute the physical speed at each point
% sqrt(dX^2 + dY^2)
%
% if explicit timesteps are not given,
% the entire spline is considered
%
% Note: it is computed wrt framerate, not the actual time!
% 


if nargin<2
    tt=spl.start:spl.end;
end


s1=ppdiff(spl,1);

A1 = ppval(s1,tt); % first derivative
A1x=A1(1,:);A1y=A1(2,:);

slope=sqrt(A1x.^2 + A1y.^2);

t = length(A1x);

s1 = A1x(:,2:t).*A1x(:,1:t-1) + A1y(:,2:t).*A1y(:,1:t-1);

slope2 = s1 ./ (sqrt(A1x(:,2:t).*A1x(:,2:t) + A1y(:,2:t).*A1y(:,2:t)) .* sqrt(A1x(:,1:t-1).*A1x(:,1:t-1) + A1y(:,1:t-1).*A1y(:,1:t-1))); 

end