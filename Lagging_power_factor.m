% term_char_a.m
% Plot the terminal characteristics of the generator 
% with a 0.8 PF lagging load (Example 5-4 style).

clear; clc;

% Line current values (21 values from 0 to 60 A)
i_a = linspace(0, 60, 21); % current in Amps

% Initialize other values
v_phase = zeros(1, 21);    % phase voltages
e_a = 277.0;               % internal generated voltage (V, phase)
x_s = 1.0;                 % synchronous reactance (Ohms)

% Power factor angle for 0.8 PF lagging
theta_deg = acos(0.8);     % power factor angle in radians
theta = theta_deg;         % already in radians

% Calculate phase voltage for each current level
for ii = 1:21
    i = i_a(ii);
    delta_vr = x_s * i * cos(theta); % real part of voltage drop
    delta_vi = x_s * i * sin(theta); % imaginary part of voltage drop
    
    % Apply vector subtraction: V = E - jXs*Ia
    v_complex = e_a - (delta_vr + 1i * delta_vi);
    v_phase(ii) = abs(v_complex);   % magnitude of phase voltage
end

% Convert phase voltage to line voltage (line-to-line)
v_t = v_phase * sqrt(3);

% Plot the terminal characteristic
plot(i_a, v_t, 'Color', 'k', 'LineWidth', 2.0);
xlabel('Line Current (A)', 'FontWeight', 'bold');
ylabel('Terminal Voltage (V)', 'FontWeight', 'bold');
title('Terminal Characteristic for 0.8 PF Lagging Load', 'FontWeight', 'bold');
grid on;
axis([0 60 400 550]);
