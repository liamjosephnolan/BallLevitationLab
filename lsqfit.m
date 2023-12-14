%% Underdamped System
close all
clear all
clc

load("attempt5.mat")

t_under = sensor_v.Time(16250:end)-32.5;
y_under_ad = sensor_v.Data(16250:end);
y_under = (y_under_ad-1.55)/.025;
% Define the function to fit
function_under = @(x, t) x(3) * (1 - exp(-x(1) * x(2) * t) .* (cos(x(2) * sqrt(1 - x(1)^2) * t) + (x(1) / sqrt(1 - x(1)^2)) .* sin(x(2) * sqrt(1 - x(1)^2) * t)));

% Initial guess for parameters
initial_params = [10    01    10];
% Create fit options
options = optimset('lsqcurvefit');
options.TolFun = 1e-10;  % Set a more precise tolerance

% Use lsqcurvefit to fit the curve
fit_params_under = lsqcurvefit(function_under, initial_params, t_under, y_under,[],[], options);

% Generate fitted curve using the obtained parameters
y_fit = function_under(fit_params_under, t_under);

% Plot the actual data and the fitted curve
figure;
plot(t_under, y_under, '.', 'DisplayName', 'Actual Data');
hold on;
plot(t_under, y_fit, 'LineWidth', .5, 'DisplayName', 'Fitted Curve');
title('Underdamped');
xlabel('Time (seconds)');
ylabel('Voltage Normalized');
legend('show',location='southeast');
grid on;
hold off;
