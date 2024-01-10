%% Lab 2 Prep
% Johannes Schmid & Liam Nolan

% Workspace Init
close all
clear all
clc

%% Underdamped Fitting
% This section loads our step response lab data and fits and underdamped
% curve to this data, control parameters can then be calculated from this

% Data load and manipulation
load("attempt5.mat")
t_under = sensor_v.Time(15574:end)-sensor_v.Time(15574);
y_under = (sensor_v.Data(15574:end)-sensor_v.Data(15574))/(1.8136-1.1193);


% function handle
UD_function = @(params, t) params(3).*(1- (exp(-params(1)*params(2)*t) .*( cos((params(2) .*sqrt(1-params(1)^2))*t) + (params(1)/sqrt(1-params(1)^2)) .*sin((params(2).*sqrt(1-params(1)^2))*t))));

% Init Parameters
UD_init=[0.25,3.5,20];

% perform curve fitting
coeff_UD = lsqcurvefit(UD_function,UD_init,t_under,y_under, [], []);
% fit model
y_UD=UD_function(coeff_UD,t_under);

% plot
plot(t_under,y_under)
hold on;
plot(t_under,y_UD,'r--')
xlabel('t');
ylabel('y(t)');
title('Underdamped Data Fitting')
legend('raw','fitted')
grid on;

%% Observer calculation
zeta_id = coeff_UD(1);
w_n_id = coeff_UD(2);
K_id = coeff_UD(3);

% State space matrices
A_id = [0 1; -w_n_id^2 -2*zeta_id*w_n_id];
B_id = [0; 1];
C_id = K_id*[1, 0];
D_id = 0;


% Observor Poles
zeta_o = 0.9;
t_s_o = 1;
w_n_o = 4/(zeta_o*t_s_o);
s1_o = complex(-zeta_o*w_n_o, w_n_o*sqrt(1-zeta_o^2))
s2_o = complex(-zeta_o*w_n_o, -w_n_o*sqrt(1-zeta_o^2))

poles_obs = [s1_o, s2_o] ;
L=acker(A_id', C_id',poles_obs)';

%% Controller Design

zeta = .9;
t_s = 2.5;
w_n = 4/(zeta*t_s);
s1 = complex(-zeta*w_n, w_n*sqrt(1-zeta^2))
s2 = complex(-zeta*w_n, -w_n*sqrt(1-zeta^2))
s3 = -2;

% Pole Placement 
% s1 = complex(-15, 3);
% s2 = complex(-15, -3);
poles_ctrl = [s1,s2,s3];

A_s = [A_id [0; 0];-C_id 0]

B_s = [B_id;0]
Ki = acker(A_s,B_s,poles_ctrl)

% Init X 
x_init = [0 0];


%% Simulink Models

%% Linearized System
%
% <<LinearSystem.png>>

%% Observer
%
% <<Observer.png>>
%

%% System Response 
%% Step Response 
%
% <<StepResponseScreenshot.png>>
%

%% Sin Wave Response
%
% <<SinResponseScreenshot.png>>
%

%% Random Signal Response
%
% <<RandResponseScreenshot.png>>
%

