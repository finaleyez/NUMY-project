
clc;
clear;
close all;

fprintf('THERMODYNAMIC INTERPOLATION USING HAT FUNCTIONS\n');
fprintf('===============================================\n');

% Select interpolation type
fprintf('\n1. Temperature varies at constant pressure\n');
fprintf('2. Pressure varies at constant temperature\n');

choice = input('\nEnter choice (1 or 2): ');

% Collect independent variable
if choice == 1

    P = input('Enter constant pressure (kPa): ');
    X = input('Enter temperature values [T1 T2 ...]: ');
    Xq = input('Enter desired temperature (C): ');
    xLabel = 'Temperature (C)';
    condition = sprintf('Constant Pressure = %.2f kPa', P);

elseif choice == 2
    T = input('Enter constant temperature (C): ');
    X = input('Enter pressure values [P1 P2 ...]: ');
    Xq = input('Enter desired pressure (kPa): ');
    xLabel = 'Pressure (kPa)';
    condition = sprintf('Constant Temperature = %.2f C', T);

else

    error('Invalid selection.');
end

% Collect enthalpy values
H = input('Enter corresponding enthalpy values [H1 H2 ...]: ');

% Calculate interpolated enthalpy
Hq = linearHatInterp(X, H, Xq);

% Display result
fprintf('\nInterpolated enthalpy: %.6f kJ/kg\n', Hq);

% Generate plotting values
Xplot = linspace(X(1), X(end), 200);

% Evaluate complete hat function sum
Hplot = linearHatInterp(X, H, Xplot);

% Plot
figure;

plot(Xplot, Hplot, 'b-', 'LineWidth', 1.5);
hold on;

scatter(X, H, 50, 'k', 'filled');

scatter(Xq, Hq, 80, 'r', 'filled');

xlabel(xLabel);
ylabel('Enthalpy (kJ/kg)');

title({'Linear Interpolation Using Hat Functions', condition});

legend('Interpolating Function', ...
       'Original Data', ...
       'Requested Value', ...
       'Location', 'best');

grid on;
