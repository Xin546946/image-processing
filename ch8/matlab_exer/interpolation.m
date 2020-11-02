%% linear interpolation

z = interp1q([0 0.6 1]',[0 0.4 1]',linspace(0,1,10)');
plot([0 0.6 1]',[0 0.4 1]','o');

hold on;
plot(linspace(0,1,10),z);
grid;

%% spline interpolation

z = spline([0 0.6 1]',[0 0.4 1]',linspace(0,1,10)');
plot([0 0.6 1]',[0 0.4 1]','o');
hold on;

plot(linspace(0,1,10),z,'r');
grid;