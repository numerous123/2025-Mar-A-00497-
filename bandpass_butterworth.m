function filtered_signal = bandpass_butterworth(inputsignal,cutoff_freqs,Fs,order)
Wn = 2*cutoff_freqs/Fs;% non-dimensional frequency
[filtb,filta] = butter(order,Wn,'bandpass'); % construct the filter
filtered_signal = filter(filtb,filta,inputsignal); % filter the data with zero phase 
end