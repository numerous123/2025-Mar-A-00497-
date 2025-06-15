clc
clear all
close all

%% Setting window length
ratio = 1;

emg = downsample(emg,ratio);
fs = 2e3/ratio;
num_chs = 12;
window_len = 0.2*fs; % 200ms

input = emg(:,1);
L = size(input,1);
spike_train = zeros(L+1, num_chs*4);
% k = 1;

for k = 1:num_chs
input = emg(:,k);
% normalization
min_val = min(input);
max_val = max(input);
normalized_input = (input - min_val) / (max_val - min_val);

% Setting cutoff frequencies
cutoff1 = 990/ratio;
cutoff2 = 500/ratio;
cutoff3 = 250/ratio;
cutoff4 = 100/ratio;

order = 4; % The order of butterworth filter

y_filt1 = hipass_butterworth(normalized_input,cutoff2,fs,order);
y_filt2 = bandpass_butterworth(normalized_input,[cutoff3 cutoff2],fs,order);
y_filt3 = bandpass_butterworth(normalized_input,[cutoff4 cutoff3],fs,order);
y_filt4 = lopass_butterworth(normalized_input,cutoff4,fs,order);

t = (1:length(normalized_input))/fs;
%% full-rectifier
y_rectif1 = full_rectifier(y_filt1);
y_rectif2 = full_rectifier(y_filt2);
y_rectif3 = full_rectifier(y_filt3);
y_rectif4 = full_rectifier(y_filt4);

%% spike coding through LIF neuron
v_th = [8e-6 3e-5 8e-5 5e-3 ...
    8e-6 3e-5 8e-5 6e-3 ... 
    3e-6 1e-5 2e-5 5e-3 ...
    5e-6 1e-5 4e-5 7e-3 ...
    1e-5 2e-5 6e-5 7e-3 ...
    1e-5 3e-5 5e-5 4e-3 ...
    5e-6 2e-5 5e-5 4e-3 ...
    2e-5 5e-5 1e-4 4e-3 ...
    1e-5 5e-5 5e-5 5e-3 ...
    4e-6 3e-5 7e-5 3e-3 ...
    25e-6 5e-5 7e-5 3e-3 ...
    1e-5 5e-5 7e-5 3e-3];
% I_ext = y_rectif4;
v0 = 0;
dt = 1/fs;  %sampling time
v_rest = 0;
% t_f = 50;  %running time
tau = 1; %second

    
[spike_train1, T] = spikeLIFcoding(v_th(4*k-3), y_rectif1, v0, dt, v_rest, tau);
[spike_train2, T] = spikeLIFcoding(v_th(4*k-2), y_rectif2, v0, dt, v_rest, tau);
[spike_train3, T] = spikeLIFcoding(v_th(4*k-1), y_rectif3, v0, dt, v_rest, tau);
[spike_train4, T] = spikeLIFcoding(v_th(4*k), y_rectif4, v0, dt, v_rest, tau);

spike_train(:,4*k-3) = spike_train1;
spike_train(:,4*k-2) = spike_train2;
spike_train(:,4*k-1) = spike_train3;
spike_train(:,4*k) = spike_train4;
end
