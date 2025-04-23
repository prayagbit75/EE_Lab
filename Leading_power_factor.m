% term_char_leading.m
% Terminal characteristic for 0.8 PF LEADING load

clear; clc;

% Generator & system specs
e_a = 277.0;            % Internal generated voltage (phase, V)
x_s = 1.0;              % Synchronous reactance (Ω)
i_a = 0:3:60;           % Line currents from 0 to 60 A (21 points)

% Power-factor angle
pf = 0.8;
theta = acos(pf);       % θ = 36.87° (leading means current phasor ∠+θ)

% Preallocate
v_phase = zeros(size(i_a));

% Compute V_phase for each Ia
for k = 1:length(i_a)
    % Current phasor leads voltage by θ → ∠+θ
    I = i_a(k) * (cos(+theta) + 1i*sin(+theta));
    % Voltage drop across reactance = j Xs I
    V_drop = 1i * x_s * I;
    % Terminal phase voltage = Ea – jXs·I
    Vph = e_a - V_drop;
    v_phase(k) = abs(Vph);
end

% Convert to line voltage
v_t = v_phase * sqrt(3);

% Plot
figure;
plot(i_a, v_t, 'b--', 'LineWidth', 2);
grid on; hold on;
xlabel('Line Current I_a (A)', 'FontWeight','bold');
ylabel('Terminal Voltage V_t (V)', 'FontWeight','bold');
title('Terminal Characteristic – 0.8 PF Leading', 'FontWeight','bold');
axis([0 60 400 550]);
