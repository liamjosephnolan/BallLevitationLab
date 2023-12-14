%% Lab 1 

% Init
clear all
close all
clc

% Hard coded data
Data = [40 1.72;
        35 2.06;
        30 1.82;
        25 1.48;
        20 1.13;
        15 1.05;
        10 0.96;
        05 0.92;
        00 0.88];

% Store data in variables
height = Data(:,1)';
voltage = Data(:,2)';

% Plot measured data
plot(voltage, height, '*')
xlabel("Voltage (V)")
ylabel("Height (Cm)")
hold on

% Fit Data to polynomial
p = polyfit(voltage, height,  3);

% Generate a callable function based on voltage
fit_function = @(V) polyval(p, V);

% Plot fitted function
V_values = linspace(min(voltage), max(voltage), 100); % Adjust the number of points as needed
height_fit = fit_function(V_values);
plot(V_values, height_fit)

legend("Data Values","Fitted Function",location = "southeast")



