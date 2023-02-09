% scripts from Remi

close all

nb_time_points = 100;

data = generate_dummy_eye_movement(nb_time_points);

displacement = compute_displacement(data);

plot_eye_movement(data, displacement);

%% helper function

function data = generate_dummy_eye_movement(nb_time_points)
% normaly distributed data centered around 0
% simulate subject fixating
data = randn(nb_time_points, 2) * 10;
end

function plot_eye_movement(data, displacement)
figure('name', 'eye movemvent', ...
    'position', [50 50 500 1000]);

subplot(5,2,1:4)
hold on
scatter(data(:,1), data(:,2));
plot(0,0,'.k', 'markersize', 20);
MAX = max(data(:));
axis([-MAX MAX -MAX MAX])
title('fixation')

subplot(5,2,5:6)
hold on
plot(data(:,1));
axis([0 size(data, 1) -MAX MAX]);
title('x position')

subplot(5,2,7:8)
hold on
plot(data(:,2));
axis([0 size(data, 1) -MAX MAX]);
title('y position')

subplot(5,2,9:10)
hold on
plot(displacement);
title('displacement')

end

function displacement = compute_displacement(data)
% compute displacement for every time point t
%
% ( (x_{t} - x_{t-1})^2 + (y_{t} - y_{t-1})^2 )^0.5
%
%
displacement = diff(data);
displacement = (displacement(:,1).^2 + displacement(:,2).^2).^0.5;
% pad first row with NaN 
% because we want displacement to have same length as initial data 
displacement = [nan;displacement];
end