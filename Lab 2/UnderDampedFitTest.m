%% Underdamped System
close all
clear all
clc

% Data load and manipulation
load("attempt5.mat")
t_under = sensor_v.Time(15574:end)-sensor_v.Time(15574);
y_under = (sensor_v.Data(15574:end)-sensor_v.Data(15574))*.025;


% function handle
UD_function = @(params, t) params(3).*(1- (exp(-params(1)*params(2)*t) .*( cos((params(2) .*sqrt(1-params(1)^2))*t) + (params(1)/sqrt(1-params(1)^2)) .*sin((params(2).*sqrt(1-params(1)^2))*t))));

UD_init=[0.25,3.5,20];

options = optimset('lsqcurvefit');
options.TolFun = 1e-14;  % Set a more precise tolerance
% perform curve fitting
coeff_UD = lsqcurvefit(UD_function,UD_init,t_under,y_under, [], [], options);
% fit model
y_UD=UD_function(coeff_UD,t_under);

% plot
plot(t_under,y_under)
hold on;
plot(t_under,y_UD,'r--')
xlabel('t');
ylabel('y(t)');
title('Underdamped')
legend('raw','fitted')
grid on;

zeta = coeff_UD(1);
w_n = coeff_UD(2);
K = coeff_UD(3);

A = [0 1; -w_n^2 -2*zeta*w_n];

B = [0; 1];

C = [1, 0];
D = 0;
t_s = 4/(zeta*w_n);

p_os = 100*exp((-zeta*pi)/(sqrt(1-zeta^2)));

zeta = log(p_os)/(sqrt(pi^2+log(p_os)^2));

% s1 = -zeta*w_n+i*w_n*sqrt(1-zeta^2)
% s2 = -zeta*w_n-i*w_n*sqrt(1-zeta^2)
s1 = complex(-15, 3);
s2 = complex(-15, -3);


poles = [s1, s2];

K = acker(A,B,poles);

V=-1/(C*inv(A-B*K)*B);

Pl=0.2*poles;
L=acker(A',C',Pl)';

x_init = [0 0];


