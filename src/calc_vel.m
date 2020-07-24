function [v, v_abs] = calc_vel(n,t,T,ControlPoints)
%Calculate the curve's velocity given the ControlPoints.
%   Inputs:

%   Outputs:

%   Input Example:
%   clear,clc
% 	n = 4;
% 	t = 0:0.01:1;
% 	ControlPoints = [0,0;0.500000000000000,0.250000000000000;1.16666666664722,1.83333333330278;2,3.50000000000000;3,4];

    size_ = max(size(t));
    v = zeros(size_,2);
    for j = 1:size_
        v_ = zeros(1,2);
        for i = 0:n-1
            v_ = v_ + n*nchoosek(n-1,i)*t(j)^i*(1-t(j))^(n-1-i).*(ControlPoints(i+2,:)-ControlPoints(i+1,:));
        end
        v(j,:) = v_/T;
    end
    if nargout > 1
        v_square = v.^2;
        v_abs = sqrt(v_square(:,1)+v_square(:,2));
    end
end
