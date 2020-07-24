function [a, a_abs] = calc_acc(n,t,T,ControlPoints)
%Calculate the curve's velocity given the ControlPoints.
%   Inputs:
%	scalar n : nth polynomial
%	scalar/vector t : 0 <= abs(t) <= 1
%	matrix ControlPoints : [point 1; point 2; point 3...]

%   Outputs:
%   matrix a : [ax, ay]
%   vector a_abs : sqrt(ax^2 + ay^2)

%   Input Example:
%   clear,clc
% 	n = 4;
% 	t = 0:0.01:1;
% 	ControlPoints = [0,0;0.500000000000000,0.250000000000000;1.16666666664722,1.83333333330278;2,3.50000000000000;3,4];

    size_ = max(size(t));
    a = zeros(size_,2);
    for j = 1:size_
        a_ = zeros(1,2);
        for i = 0:n-2
            a_ = a_ + n*(n-1)*nchoosek(n-2,i)*t(j)^i*(1-t(j))^(n-2-i).*(ControlPoints(i+3,:)-2*ControlPoints(i+2,:)+ControlPoints(i+1,:));
        end
        a(j,:) = a_/T/T;
    end
    if nargout > 1
        a_square = a.^2;
        a_abs = sqrt(a_square(:,1)+a_square(:,2));
    end
