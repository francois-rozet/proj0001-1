%% Paramètres

y0 = [0 0 0.002 0];
t = [0 1000];
pas = 1e-3;
vrbl = 3;
RelTol = 1e-3;
AbsTol = 1e-6;

%% Implémentation des méthodes

% Initialisation T, Y et OdeSet
T = {1:4};
Y = {1:4};
OdeSet = odeset('RelTol', RelTol, 'AbsTol', AbsTol);

% Résolutions des systèmes
parfor i = 1:4
    if (i <= 2)
        system = @odefunction_lin;
    else
        system = @odefunction_nl;
    end
    if (mod(i, 2))
        [T{i}, Y{i}] = euler_exp(system, t, y0, pas);
    else
        [T{i}, Y{i}] = ode45(system, t, y0, OdeSet);
    end
end

%% Plots

for i = 1:4
    subplot(2, 2, i);
    plot(T{i}(:), Y{i}(:, vrbl));
    xlabel('Temps (s)');
    if (vrbl == 1)
        ylabel('Position du tablier (m)');
    elseif (vrbl == 3)
        ylabel('Inclinaison du tablier (rad)');
    end
    if (i <= 2)
        system = 'odefunction\_lin';
    else
        system = 'odefunction\_nl';
    end
    if (mod(i, 2))
        method = 'euler\_exp';
    else
        method = 'ode45';
    end
    str=sprintf('%s par %s', system, method);
    title(str);
    grid on
end