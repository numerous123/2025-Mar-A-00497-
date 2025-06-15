function [v,spk] = LIF_ODE(v_th,v_rest,v0, dt, I, tau)

%v = v0 + dt * (-v0 +I);
v = v0 + (dt / tau) * (-(v0 - v_rest) + I); 
% V = I - exp(-(v0-v_rest))
% v = v0*(1 - dt / tau) + dt*I;
spk = false;
if v >= v_th
    v = v_rest;
    spk = true;
end
        
end

