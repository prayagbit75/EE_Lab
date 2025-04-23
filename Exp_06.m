% mag_field.m
% Calculate the net magnetic field produced by a three-phase stator.

clear; clc;

% Basic conditions
bmax = 1;          % Normalize bmax to 1
freq = 60;         % 60 Hz
w = 2 * pi * freq; % Angular velocity (rad/s)

% Time vector (one full cycle, high resolution)
t = 0 : 1/6000 : 1/freq;

% Phase angles (A: 0, B: -120°, C: +120°)
theta_a = 0;
theta_b = -2*pi/3;
theta_c = 2*pi/3;

% Unit phasors for each phase (stationary in space)
ea = cos(theta_a) + 1i*sin(theta_a);
eb = cos(theta_b) + 1i*sin(theta_b);
ec = cos(theta_c) + 1i*sin(theta_c);

% Magnetic field contributions of each phase over time
Baa = bmax * sin(w * t) .* ea;
Bbb = bmax * sin(w * t - 2*pi/3) .* eb;
Bcc = bmax * sin(w * t + 2*pi/3) .* ec;

% Net magnetic field (vector sum)
Bnet = Baa + Bbb + Bcc;

% Reference circle for max magnitude
circle = 1.5 * (cos(w * t) + 1i * sin(w * t));

% Animate the rotating field
for ii = 1:length(t)
    clf;
    
    % Plot reference circle
    plot(real(circle), imag(circle), 'k--'); hold on;
    
    % Plot individual phase contributions
    plot([0 real(Baa(ii))], [0 imag(Baa(ii))], 'k', 'LineWidth', 2);
    plot([0 real(Bbb(ii))], [0 imag(Bbb(ii))], 'b', 'LineWidth', 2);
    plot([0 real(Bcc(ii))], [0 imag(Bcc(ii))], 'm', 'LineWidth', 2);
    
    % Plot net magnetic field vector
    plot([0 real(Bnet(ii))], [0 imag(Bnet(ii))], 'r', 'LineWidth', 3);
    
    % Set plot properties
    axis square;
    axis([-2 2 -2 2]);
    title('Rotating Magnetic Field from 3-Phase Stator');
    xlabel('Real Axis'); ylabel('Imaginary Axis');
    grid on;
    
    drawnow;
end
