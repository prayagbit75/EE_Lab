% torque_speed_curve.m
% Plot torque-speed characteristics for different rotor resistances
% Cases: original R2, doubled R2, and halved R2

clear; clc;

% === Motor Parameters ===
r1 = 0.641;         % Stator resistance (ohms)
x1 = 1.106;         % Stator reactance (ohms)
r2 = 0.332;         % Rotor resistance (ohms)
x2 = 0.464;         % Rotor reactance (ohms)
xm = 26.3;          % Magnetizing reactance (ohms)
v_phase = 460 / sqrt(3);  % Phase voltage (V)

n_sync = 1800;      % Synchronous speed in rpm
w_sync = 188.5;     % Synchronous speed in rad/s

% === Thevenin Equivalent ===
z_th = 1i * xm * (r1 + 1i * x1) / (r1 + 1i * (x1 + xm));
v_th = abs(z_th * v_phase / (r1 + 1i * x1 + z_th));  % Thevenin voltage
z_eq = 1i * xm * (r1 + 1i * x1) / (1i * xm + r1 + 1i * x1);
r_th = real(z_eq);    % Thevenin resistance
x_th = imag(z_eq);    % Thevenin reactance

% === Slip & Speed Vectors ===
s = linspace(0.001, 1, 51);      % Slip from 0.001 to 1
n_run = (1 - s) * n_sync;        % Mechanical speed (rpm)

% === Torque Calculation ===

% Case 1: Original R2
t_ind1 = zeros(size(s));
for ii = 1:length(s)
    t_ind1(ii) = (3 * v_th^2 * r2 / s(ii)) / ...
        (w_sync * ((r_th + r2 / s(ii))^2 + (x_th + x2)^2));
end

% Case 2: Doubled R2
r2_double = 2 * r2;
t_ind2 = zeros(size(s));
for ii = 1:length(s)
    t_ind2(ii) = (3 * v_th^2 * r2_double / s(ii)) / ...
        (w_sync * ((r_th + r2_double / s(ii))^2 + (x_th + x2)^2));
end

% Case 3: Halved R2
r2_half = r2 / 2;
t_ind3 = zeros(size(s));
for ii = 1:length(s)
    t_ind3(ii) = (3 * v_th^2 * r2_half / s(ii)) / ...
        (w_sync * ((r_th + r2_half / s(ii))^2 + (x_th + x2)^2));
end

% === Plotting ===
figure;
plot(n_run, t_ind1, 'b-', 'LineWidth', 2); hold on;
plot(n_run, t_ind2, 'r--', 'LineWidth', 2);
plot(n_run, t_ind3, 'g:', 'LineWidth', 2.5);
xlabel('n_{m} (rpm)', 'FontWeight', 'bold');
ylabel('\tau_{ind} (Nm)', 'FontWeight', 'bold');
title('Induction Motor Torque-Speed Characteristic', 'FontWeight', 'bold');
legend('Original R_2', 'Doubled R_2', 'Halved R_2', 'Location', 'best');
grid on;
axis([0 n_sync 0 max([t_ind1 t_ind2 t_ind3]) * 1.1]);
