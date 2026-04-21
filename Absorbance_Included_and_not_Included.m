clc; clear; close all;

%% Constants (SI units)
E = 335000;      % J/mol
M = 0.028;       % kg/mol

%% Select graph type
choice = input('Choose graph type: 1 = TD graph, 2 = KD graph: ');

%% Select plot type
plotType = input('Plot type: 1 = log-log, 2 = linear: ');

%% Inputs
dx_um = input('Enter thickness change dx (micrometres): ');
A = input('Enter absorbance (dimensionless): ');

%% Safety
A = max(A, eps);

%% SI conversion
dx = dx_um * 1e-6;

%% Irradiance range (IMPORTANT: avoid extreme compression)
I = logspace(log10(0.5), log10(20), 600);  % W/m^2

%% Conversion factor (m/s → µm/year)
conv = 1e6 * 31536000;

A_with = A;
A_without = 1;
rho = 930;

%% ===== CALCULATIONS =====
switch choice

    case 1
        % ===== TD GRAPH =====
        K_with = (2 * E * rho * dx) / (M * A_with);
        K_without = (2 * E * rho * dx) / (M * A_without);

        y1 = (K_with ./ I) / 86400;
        y2 = (K_without ./ I) / 86400;

        % ensure log-safe values
        y1 = max(y1, eps);
        y2 = max(y2, eps);

        yLabel = 'Degradation Time (days)';
        plotTitle = 'TD Graph: Degradation Time vs Irradiance';

    case 2
        % ===== KD GRAPH =====
        kd_with = (I .* M .* A_with) / (2 * E * rho);
        kd_without = (I .* M .* A_without) / (2 * E * rho);

        kd_with = kd_with * conv;
        kd_without = kd_without * conv;

        y1 = kd_with;
        y2 = kd_without;

        y1 = max(y1, eps);
        y2 = max(y2, eps);

        yLabel = 'Degradation Rate (\mum year^{-1})';
        plotTitle = 'kd Graph: Degradation Rate vs Irradiance';

    otherwise
        error('Invalid choice. Enter 1 or 2.');
end

%% ===== PLOT =====
figure('Color','w');
hold on;

switch plotType

    case 1
        % TRUE log-log forcing (fixes your issue)
        loglog(I, y1, 'b-', 'LineWidth', 2);
        loglog(I, y2, 'r-', 'LineWidth', 2);

        set(gca, 'XScale', 'log', 'YScale', 'log');

    case 2
        plot(I, y1, 'b-', 'LineWidth', 2);
        plot(I, y2, 'r-', 'LineWidth', 2);

    otherwise
        error('Invalid plot type. Enter 1 or 2.');
end

grid on;
box on;

xlabel('Irradiance, I (W m^{-2})', 'FontSize', 12, 'FontName', 'Times New Roman');
ylabel(yLabel, 'FontSize', 12, 'FontName', 'Times New Roman');

title(plotTitle, 'FontSize', 13, 'FontWeight', 'bold', 'FontName', 'Times New Roman');

legend('With Absorbance included', 'Without Absorbance included', 'Location', 'southwest');

set(gca, ...
    'FontSize', 11, ...
    'FontName', 'Times New Roman', ...
    'LineWidth', 1.2, ...
    'XColor','k', ...
    'YColor','k');
