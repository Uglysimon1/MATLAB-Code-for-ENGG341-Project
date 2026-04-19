%% Read CSV, sort data, and plot smooth line

filename = 'averaged Transmittance percentage webplotdigitiser.csv';

data = readmatrix(filename, 'NumHeaderLines', 1);

x = data(:,1);
y = data(:,2);

% Sort by x values
[x_sorted, idx] = sort(x);
y_sorted = y(idx);

% Remove duplicate x values
[x_unique, ia] = unique(x_sorted);
y_unique = y_sorted(ia);

% Smooth data (use y_unique!)
y_smooth = smoothdata(y_unique, 'sgolay', 20);

% Plot
figure;
xq = linspace(min(x_unique), max(x_unique), 500);
yq = interp1(x_unique, y_smooth, xq, 'pchip');

plot(xq, yq, 'k-', 'LineWidth', 2);
set(gca, 'FontSize', 12, 'FontName', 'Calibri');
set(gca, 'LineWidth', 1.2);
set(gca, 'TickDir', 'out');
xlabel('Wavelength (nm)');
ylabel('Transmittance Intensity %');
grid minor;