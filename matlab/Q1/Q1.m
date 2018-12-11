%% Paramètres

tabl = xlsread('../resources/xls/enveloppe.xls');
val = 100;
img = 0.3;
[x0, x1] = bornes(img, tabl);

%% Exemples

f_val = f(val, tabl);
rep_sec = secante(@(x)f(x, tabl), x0, x1, img, eps);
rep_bis = bissection(@(x)f(x, tabl), x0, x1, img, 2^2 * eps, 2^7 * eps);
fprintf('\nf(%f) = %f\nrep_sec = %f\nrep_bis = %f\n\n', val, f_val, rep_sec, rep_bis);

%% Plots

valeurs_x = tabl(:, 1);
valeurs_y = tabl(:, 2);
x = transpose(valeurs_x(1):valeurs_x(end));
y = f(x, tabl);
plot(valeurs_x, valeurs_y, x, y);
xlabel('Temps [s]');
ylabel('Angle [rad]');
legend('Fichier', 'Spline');
grid on
