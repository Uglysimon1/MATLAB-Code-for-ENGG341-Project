% File names
files = { ...
    'Bead Shrinking Radius.csv', ...
    'Bead Const Radius.csv', ...
    'Fibre Shrinking Radius.csv', ...
    'Fibre Const Radius.csv', ...
    'Film Const Area.csv'};

% Load data
data = cell(1, length(files));
for i = 1:length(files)
    data{i} = readmatrix(files{i});
end

% Create figure
figure;

% Two axes (broken x-axis)
ax1 = axes('Position',[0.1 0.1 0.35 0.8]); % 0–5
ax2 = axes('Position',[0.55 0.1 0.35 0.8]); % 0–1500

hold(ax1, 'on');
hold(ax2, 'on');

% Colours
beadColor = 'b';
fibreColor = 'r';
filmColor = 'g';

for i = 1:length(data)

    x = data{i}(:,1);
    y_raw = data{i}(:,2);

    % Style
    switch i
        case 1, style = [beadColor '-'];   % Bead Shrinking
        case 2, style = [beadColor '--'];  % Bead Const
        case 3, style = [fibreColor '-'];  % Fibre Shrinking
        case 4, style = [fibreColor '--']; % Fibre Const
        case 5, style = [filmColor '-'];   % Film
    end

    % ---------- RIGHT AXIS (0–1500) ----------
    if i ~= 5
        idx2 = x >= 0 & x <= 1500;

        if i == 1 || i == 3
            % Smoothed curves for shrinking cases
            y_plot = smoothdata(y_raw, 'sgolay', 35);
            plot(ax2, x(idx2), y_plot(idx2), style, 'LineWidth', 1.5);

        else
            % Linear fit for const radius cases
            idx_fit = x >= 0 & x <= 1500;
            if sum(idx_fit) > 1
                p = polyfit(x(idx_fit), y_raw(idx_fit), 1);
                y_fit = polyval(p, x(idx_fit));
                plot(ax2, x(idx_fit), y_fit, style, 'LineWidth', 1.5);
            end
        end
    end

    % ---------- LEFT AXIS (0–5, all straight fits) ----------
    idx1 = x >= 0 & x <= 5;

    if sum(idx1) > 1
        p = polyfit(x(idx1), y_raw(idx1), 1);
        y_fit = polyval(p, x(idx1));
        plot(ax1, x(idx1), y_fit, style, 'LineWidth', 1.5);
    end
end

% Axis limits
xlim(ax1, [0 5]);
xlim(ax2, [0 1500]);

% Link y-axes
linkaxes([ax1 ax2], 'y');
ylim(ax1, [0 100]);
ylim(ax2, [0 100]);

% Labels
xlabel(ax1, 'Time (Years)');
xlabel(ax2, 'Time (Years)');
ylabel(ax1, 'Relative Mass %');

set(ax2, 'YTickLabel', []);

% Legend
legend(ax2, { ...
    'Bead With Shrinking Radius', ...
    'Bead With Constant Radius', ...
    'Fibre With Shrinking Radius', ...
    'Fibre With Constant Radius', ...
    'Film Const Area'}, ...
    'Location', 'best');

grid(ax1, 'on');
grid(ax2, 'on');

% Break marks
annotation('line',[0.48 0.52],[0.55 0.65],'Color','k');
annotation('line',[0.48 0.52],[0.45 0.55],'Color','k');