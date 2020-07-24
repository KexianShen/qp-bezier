%% qpip solver
clear,clc,close

addpath('./src')

start_end_points =  [0,0; 30,3];
start_end_vel =     [2,0; 10,0];
a_limit = 2;
T = 5;
plot_flag = 1;

n = 4;

Qsub = [ 1/3     -5/6	1/2     1/6 	-1/6; % n = 4
        -5/6	7/3     -2      1/3     1/6;
        1/2     -2      3       -2      1/2;
        1/6     1/3     -2      7/3     -5/6;
        -1/6    1/6     1/2     -5/6    1/3];

Q = [   Qsub        zeros(5);
        zeros(5)	Qsub];

b = zeros(10,1);

Aeq = [ 1 zeros(1,9); % P
        zeros(1,4)  1   zeros(1,5);
        -1 1 zeros(1,8); % v
        zeros(1,3) -1 1 zeros(1,5);
        zeros(1,5)	1   zeros(1,4);
        zeros(1,9)  1;
        zeros(1,5) -1 1 zeros(1,3);
        zeros(1,8) -1 1];

start_end_vel = start_end_vel/n*T;

beq = reshape([start_end_points;start_end_vel],[],1);

Aieq = [    1	-2	1	zeros(1,7);
            zeros(1,5)  1   -2  1   zeros(1,2);
            zeros(1,2)	1   -2  1	zeros(1,5);
            zeros(1,7)	1   -2  1;
            -1	2	-1	zeros(1,7);
            zeros(1,5)  -1	2	-1	zeros(1,2);
            zeros(1,2)	-1  2   -1	zeros(1,5);
            zeros(1,7)	-1  2   -1];

bieq = a_limit*ones(8,1)/n/(n-1)*T*T;

[vars,status,stats] = qpip(Q,b,Aieq,bieq,Aeq,beq);
ControlPoints = reshape(vars.x,[],2);
rbc = rational_bezier_curve(n,ControlPoints);
[v, v_abs] = calc_vel(n,0:0.01:1,T,ControlPoints);
[a, a_abs] = calc_acc(n,0:0.01:1,T,ControlPoints);

if plot_flag
    figure
    timeIndex = (0:0.01:1)*T;
    subplot(5,2,[1 2]),plot(ControlPoints(:,1),ControlPoints(:,2),'*r',rbc(:,1),rbc(:,2),'b'),ylabel('y');xlabel('x');
    subplot(5,2,[3 4]),plot(timeIndex,v_abs,'b'),ylabel('|v|');xlabel('t');
    subplot(5,2,5),plot(timeIndex,v(:,1),'b'),ylabel('vx');xlabel('t');
    subplot(5,2,6),plot(timeIndex,v(:,2),'b'),ylabel('vy');xlabel('t');
    subplot(5,2,[7 8]),plot(timeIndex,a_abs,'b'),ylabel('|a|');xlabel('t');
    subplot(5,2,9),plot(timeIndex,a(:,1),'b'),ylabel('ax');xlabel('t');
    subplot(5,2,10),plot(timeIndex,a(:,2),'b'),ylabel('ay');xlabel('t');
end