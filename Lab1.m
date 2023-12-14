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
plot(height, voltage, '*')
ylabel("Voltage (V)")
xlabel("Height (Cm)")
hold on

% Fit Data to polynomial
p = polyfit(height, voltage,  5);

% Generate a callable function based on voltage
fit_function = @(h) polyval(p, h);

% Plot fitted function
h_values = linspace(min(height), max(height), 100); % Adjust the number of points as needed
V_fit = fit_function(h_values);
plot(h_values, V_fit)
% Shade the region from height 20 to 30 in light gray
h_shade = [20, 30];
V_shade = [0, 3];

% Fill the shaded region with a light gray color
fill([min(h_shade), min(h_shade), max(h_shade), max(h_shade)], [min(voltage), max(voltage), max(voltage), min(voltage)], 'k', 'FaceAlpha', 0.1);




% Label the shaded region
legend("Data Values","Fitted Function","linear region", location = "southeast")


