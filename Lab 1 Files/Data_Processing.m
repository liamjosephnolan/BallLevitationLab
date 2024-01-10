
clear all


data = "attempt5.mat";

dataplot(data)

function [] = dataplot(data)
    
    load(data)
    time = sensor_v.time;
    sensor_v = sensor_v.Data;
    fan_v = fan_v.Data;
    figure
    title(data)
    subplot(2, 1, 1);
    plot(time,sensor_v)
    subplot(2, 1, 2);
    plot(time,fan_v)
end

