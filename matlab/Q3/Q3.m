%% Paramètres

pas = 0.03;
alpha = transpose(pas:pas:0.3);
x0 = 0;
x1 = 40000;
img_tens = 7900;
tol_y = 1;
tol_x = 1;

%% Boucle

% Initialisation de tens, tab_error et k
ampli = zeros(size(alpha, 1), 1);
tab_error = struct;

% Boucle
tic
parfor i = 1:size(alpha, 1)
    try
        ampli(i) = bissection(@(A)f(A, alpha(i)), x0, x1, img_tens, tol_y, tol_x);
    catch MyError
        tab_error(i).alpha = alpha(i);
        tab_error(i).erreur = MyError;
        ampli(i) = NaN;
    end
    %fprintf('%d', i);
end
toc

%% Plots

warning ('off', 'all');
if (size(alpha, 1) > 1)
    ampli_bis = spline(alpha, ampli, alpha);
    plot(alpha, ampli_bis);
    xlabel('Paramètre du modèle du câble (1/m)');
    ylabel('Amplitude de rupture (N)');
    grid on
end
warning ('on', 'all');
