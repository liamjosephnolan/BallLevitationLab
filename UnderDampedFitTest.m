%% Underdamped System
close all
clear all
clc

load("attempt5.mat")

t_under = sensor_v.Time(16250:end);
y_under = sensor_v.Data(16250:end);
%---------------------
% Underdamped
%---------------------

% function handle
UD_function = @(params, t) params(3).*(1- (exp(-params(1)*params(2)*t) .*( cos((params(2) .*sqrt(1-params(1)^2))*t) + (params(1)/sqrt(1-params(1)^2)) .*sin((params(2).*sqrt(1-params(1)^2))*t))))

UD_init=[0.25,3.5,20];

options = optimset('lsqcurvefit');
options.TolFun = 1e-14;  % Set a more precise tolerance
% perform curve fitting
coeff_UD = lsqcurvefit(UD_function,UD_init,t_under,y_under, [], [], options)
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