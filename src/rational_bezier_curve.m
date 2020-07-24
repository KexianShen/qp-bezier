function rbc = rational_bezier_curve(n,ControlPoints,weights)
close
%Generate rational Bezier curves.
%	Inputs:
%   control_points = [point 1; point 2; ...]
%	weights = [weight 1, weight 2, ...]
%
%   Outputs:
%   rbc = [point 1; point 2; ...]
%
%   Inputs example:
%   control_points = [0,0;.2,1;2.2,1;2,0];
%   weights = [1 2 2 1];

t_interval = 0.01;

if ~exist('ControlPoints', 'var')
    ControlPoints = [0,0;1.50000000000000,0;2.99999999995000,0;4.50000000000000,0;6,0];
end
% 
% if ~exist('T', 'var')
%     T = 2;
% end
% 
if ~exist('n', 'var')
    n = 4;
end

if ~exist('weights', 'var')
    weights = ones(1, n+1);
end

bvn = zeros(n+1, round(1/t_interval)+1);
rbc = zeros(n+1,2);
for i = 0:1/t_interval
    for vi = 0:n
        bvn(vi+1,i+1) = nchoosek(n,vi)*(i*t_interval)^vi*(1-i*t_interval)^(n-vi)*weights(vi+1); % nchoosek(n,vi) = factorial(n)/factorial(vi)/factorial(n-vi)
    end
%     bvn(:,i+1) = bvn(:,i+1)/sum(bvn(:,i+1),1);
    B = ControlPoints.*bvn(:,i+1); % (n+1)x2 .* (n+1)x1 = (n+1)x2, points * bvn = B
    rbc(i+1,:) = sum(B, 1);
end

% figure
% plot(ControlPoints(:,1),ControlPoints(:,2),'*r',rbc(:,1),rbc(:,2),'b') % comment this line to enable simulink code generation

end