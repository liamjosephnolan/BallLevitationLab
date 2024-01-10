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

fit_function_2 = @(x) -0.000000191794872*x.^5  + 0.000012815850816*x.^4  -0.000235419580420*x.^3 +   0.001575874125874*x.^2 +   0.005415617715617*x + 0.878811188811189;

% Plot fitted function
h_values = linspace(min(height), max(height), 100); % Adjust the number of points as needed
V_fit = fit_function(h_values);
V_fit_2 = fit_function_2(h_values);
plot(h_values, V_fit)
hold on
plot(h_values,V_fit_2);
% Shade the region from height 20 to 30 in light gray
h_shade = [20, 30];
V_shade = [0, 3];

% Fill the shaded region with a light gray color
fill([min(h_shade), min(h_shade), max(h_shade), max(h_shade)], [min(voltage), max(voltage), max(voltage), min(voltage)], 'k', 'FaceAlpha', 0.1);




% Label the shaded region
legend("Data Values","Fitted Function","linear region", location = "southeast")


