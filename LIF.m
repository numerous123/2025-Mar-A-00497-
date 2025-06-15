%This program generates a simple LIF neuron using following equation:   
%             taw * v_dot = -(v - v_rest) + I_ext,
%
%where I_ext is external input, which is tantamount to sensory stimulus 
%or the activity of neuronal population around. v_rest is the potential 
%of resting state.
%Figure(1) depicts the sub-threshold activity of membrane potential, and
%figure(2) demonstrates the spike train of neuronal activity.


close all; %clear all;clc

v_th = 0.5;
I_ext = f;
v0 = 0;
dt = .1;  %sampling time
v_rest = 0;
t_f = 50;  %running time
tau = 1;

n_tSteps = t_f/dt +1;
V = zeros(n_tSteps,1);
V(1) = v0;
spike_train = zeros(n_tSteps,1);
T = zeros(n_tSteps,1);
%%
for i=1:n_tSteps -1
   
    [v,spk] = LIF_ODE(v_th,v_rest,v0, dt, I_ext(i),tau);
    T(i+1) = T(i)+dt;
    V(i+1) = v;
    if spk == true
        spike_train(i+1) = 1;
    end
    v0 = v;
end    
    
figure(1);   
plot(T,V)
title('Membrane Potential Dynamics')

figure(2)
plot (T,spike_train)
title('Spike Train')
 









