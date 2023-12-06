%% practice with AD2 through MATLAB
% *****Ensure Monitor is Unplugged*****
% clear everything
clearvars;
close all
clear all
clc

%% Find Available Device
d = daqlist("digilent"); % daqlist creats a device interface for a specific vendor
d(1, :) %displays the device info including name

%% Create a DataAcquisition
dq = daq("digilent")

%% Add an Analog Input Channel
%addinput( deviceSpecs, "deviceName", "channel_ID", "Type of measurement")
addinput(dq, "AD2_0", "ai0", "Voltage"); %adds an input channel to the device interface for MATLAB to use
               %can place addinput into a var to create a channel object to
               %switch between channels
dq

%% Acquire Timestamped Data
[data, startTime] = read(dq, seconds(5)); %read(deviceSpecs, timeToTakeMeasurements)


%% Change Default Properties of the Acquisition
% *****Ensure Monitor is Unplugged*****
dq.Rate = 50000000; %sets a specific rate
signal = data.AD2_0_ai0;

totalTime = (1/125000)*10 + 1/dq.Rate;

[data, startTime] = read(dq, seconds(totalTime));

signal = data.AD2_0_ai0;

plot(data.Time, data.AD2_0_ai0);
xlabel("Time (s)");
ylabel("Voltage (V)");

xAxis = data.Time(2:end);

figure
plot(xAxis,signal(2:end))