clear;
clc;
close all;

% ---------------------------
% Data
% ---------------------------
data1 = readtable('Lux to Irradiance.csv');
x1 = smoothdata(data1{:,1}, 'movmean', 12);
y1 = smoothdata(data1{:,2}, 'movmean', 12);

x1(1) = 0;
y1(1) = 0;
x1(123) = 1;
y1(123) = 117000;


% ---------------------------
% Figure styling (key upgrade)
% ---------------------------
figure('Color','w'); % white background (important for reports)

plot(x1, y1, 'b-', 'LineWidth', 2); hold on;
%p = polyfit(x(x1), y_raw(x1), 1);
        %y_fit = polyval(p, x(x1));
        %plot(x(x1), y_fit, style, 'LineWidth', 1.5);
% ---------------------------
% Labels (improved typography)
% ---------------------------
xlabel('Irradiance (Suns)', 'FontSize', 12, 'FontWeight', 'bold');
ylabel('Illuminance (Lux)', 'FontSize', 12, 'FontWeight', 'bold');



% ---------------------------
% Grid and axes styling
% ---------------------------
grid on;
set(gca, 'FontSize', 11, 'LineWidth', 1);
ax = gca;  
ax.YAxis.Exponent = 3;   % shows ×10^6 on y-axis
box on;

% Optional: improve axis limits appearance
xlim([min(x1) max(x1)]);