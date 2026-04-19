clear;
clc;
close all;

% ---------------------------
% Data
% ---------------------------
data1 = readtable('2020-2060PackagingPlasticPrediction.csv');
x1 = data1{:,1};
y1 = smoothdata(data1{:,2}, 'movmean', 20);

data2 = readtable('2020-2060ConsumerProductsPlasticPrediction.csv');
x2 = data2{:,1};
y2 = smoothdata(data2{:,2}, 'movmean', 20);

data3 = readtable('2020-2060ConstructionPlasticPrediction.csv');
x3 = data3{:,1};
y3 = smoothdata(data3{:,2}, 'movmean', 20);

% ---------------------------
% Figure styling (key upgrade)
% ---------------------------
figure('Color','w'); % white background (important for reports)

plot(x1, y1, 'b-', 'LineWidth', 2); hold on;
plot(x2, y2, 'r-', 'LineWidth', 2);
plot(x3, y3, 'g-', 'LineWidth', 2);

% ---------------------------
% Labels (improved typography)
% ---------------------------
xlabel('Year', 'FontSize', 12, 'FontWeight', 'bold');
ylabel('Plastic Production (Million Tonnes)', 'FontSize', 12, 'FontWeight', 'bold');
title('Projected Plastic Production by Sector (2020–2060)', ...
    'FontSize', 14, 'FontWeight', 'bold');

% ---------------------------
% Legend styling
% ---------------------------
legend({'Packaging', 'Consumer Products', 'Construction'}, ...
    'Location', 'northwest', ...
    'FontSize', 11);

% ---------------------------
% Grid and axes styling
% ---------------------------
grid on;
set(gca, 'FontSize', 11, 'LineWidth', 1);
box on;

% Optional: improve axis limits appearance
xlim([min(x1) max(x1)]);