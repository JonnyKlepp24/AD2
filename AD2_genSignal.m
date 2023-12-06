%% Find Available Device
d = daqlist("digilent"); % daqlist creats a device interface for a specific vendor
d(1, :) %displays the device info including name

%% Create a DataAcquisition
dq = daq("digilent")

%% Add an analog OutputChannel
ch_out = addoutput(dq, "AD1", "1", "Voltage");
ch_out.Name = "AD1_1_out"

%% generate a single sample
outVal = 2;
write(dq, outVal);

%% set data acquisition properties and define the output waveform

rate = 300e3;
dq.Rate = rate;

% Generate a 10 Hz sine-wave for half a second. The length of the
% output waveform and the specified output rate define the duration of
% the waveform (totalduration = numscans / rate).

f_Hz = 10;
totalduration = 1;
n = totalduration * rate;
t = (1:n)/rate;
output = sin(2*pi*f_Hz*t)';

%% Gen Data

write(dq, output);