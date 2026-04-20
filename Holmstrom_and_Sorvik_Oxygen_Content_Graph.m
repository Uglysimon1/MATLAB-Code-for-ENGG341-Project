% Read the CSV files
lowData = readmatrix('Low Oxygen Content.csv');
medData = readmatrix('Medium Oxygen Content.csv');
highData = readmatrix('High Oxygen Content.csv');

% Extract x and y values
x_low = lowData(:,1);
y_low = lowData(:,2);

x_med = medData(:,1);
y_med = medData(:,2);

x_high = highData(:,1);
y_high = highData(:,2);

% Apply smoothing (you can adjust method and window size)
y_low_smooth = smoothdata(y_low, 'gaussian', 20);
y_med_smooth = smoothdata(y_med, 'gaussian', 20);
y_high_smooth = smoothdata(y_high, 'gaussian', 20);

% Create the plot
figure;
plot(x_low, y_low_smooth, '-', 'LineWidth', 1.8); hold on;
plot(x_med, y_med_smooth, '-', 'LineWidth', 1.8);
plot(x_high, y_high_smooth, 'g-', 'LineWidth', 1.8);

% Labels and legend
xlabel('t (Mins)');
ylabel('% of inital weight');
title('Oxygen Content Comparison');
legend('Low Oxygen Content (0.00028%)', 'Medium Oxygen Content (0.105%)', 'High Oxygen Content (1.160%)', ...
       'Location', 'southwest');

% Grid for better readability
grid minor;
hold off;