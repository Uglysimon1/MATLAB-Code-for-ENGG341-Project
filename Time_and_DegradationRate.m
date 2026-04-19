clc; clear; close all; 

%% Constants (SI units)
E = 335000;      % J/mol
M = 0.028;       % kg/mol

%% Select graph type
choice = input('Choose graph type: 1 = TD graph, 2 = KD graph: ');

%% Select plot type
plotType = input('Plot type: 1 = log-log, 2 = linear: ');

%% Inputs (NOW CORRECTLY SEPARATED)
sample_thickness_um = input('Thickness of sample in micrometres: ');
dx_um = input('Enter thickness change dx (micrometres): ');

uvChoice = input('Select UV range: 1 = UVB, 2 = UVC: ');

%% Calculate absorbance (uses SAMPLE thickness only)
switch uvChoice
    case 1  % UVB
        A = 0.01569 * (sample_thickness_um / 30);
    case 2  % UVC
        A = 0.05061 * (sample_thickness_um / 30);
    otherwise
        error('Invalid UV choice. Enter 1 or 2.');
end

if A <= 0
    error('Calculated absorbance must be > 0.');
end

%% Densities
rho_LDPE = 930;
rho_HDPE = 955;

%% SI conversion (ONLY dx goes into physics)
dx = dx_um * 1e-6;

%% Irradiance range
I = logspace(log10(0.05), log10(20), 600);  % W/m^2

%% Conversion factor (m/s → µm/year)
conv = 1e6 * 31536000;

%% ===== CALCULATION =====
switch choice

    case 1
        % ===== TD GRAPH =====
        y1 = (2 * E * rho_LDPE * dx) ./ (I * M * A) / 86400; % days
        y2 = (2 * E * rho_HDPE * dx) ./ (I * M * A) / 86400;

        yLabel = 'Degradation Time (days)';
        plotTitle = 'TD Graph: Degradation Time vs Irradiance';

    case 2
        % ===== KD GRAPH =====
        kd_LDPE = (I .* M .* A) / (2 * E * rho_LDPE);
        kd_HDPE = (I .* M .* A) / (2 * E * rho_HDPE);

        y1 = kd_LDPE * conv;
        y2 = kd_HDPE * conv;

        yLabel = 'Kd (\mum year^{-1})';
        plotTitle = 'KD Graph: Degradation Rate vs Irradiance';

    otherwise
        error('Invalid choice. Enter 1 or 2.');
end

%% ===== PLOTTING =====
figure('Color','w');
hold on;

switch plotType

    case 1
        plot(I, y1, 'b-', 'LineWidth', 2);
        plot(I, y2, 'r-', 'LineWidth', 2);
        set(gca, 'XScale', 'log', 'YScale', 'log');

    case 2
        plot(I, y1, 'b-', 'LineWidth', 2);
        plot(I, y2, 'r-', 'LineWidth', 2);
        set(gca, 'XScale', 'linear', 'YScale', 'linear');

    otherwise
        error('Invalid plot type. Enter 1 or 2.');
end

grid on;
box on;

xlabel('Irradiance, I (W m^{-2})', ...
    'FontSize', 12, 'FontName', 'Times New Roman');

ylabel(yLabel, ...
    'FontSize', 12, 'FontName', 'Times New Roman');

title(plotTitle, ...
    'FontSize', 13, 'FontWeight', 'bold', ...
    'FontName', 'Times New Roman');

legend('LDPE', 'HDPE', 'Location', 'southwest');

set(gca, ...
    'FontSize', 11, ...
    'FontName', 'Times New Roman', ...
    'LineWidth', 1.2, ...
    'XColor','k', ...
    'YColor','k');