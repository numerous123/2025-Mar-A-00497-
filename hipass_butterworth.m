function filtered_signal = lopass_butterworth(inputsignal,cutoff_freq,Fs,order)
Wn = 2*cutoff_freq/Fs;    % non-dimensional frequency
[filtb,filta] = butter(order,Wn,'high'); % construct the filter
filtered_signal = filter(filtb,filta,inputsignal); % filter the data with zero phase
end
