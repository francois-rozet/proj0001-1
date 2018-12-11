function [T, Y] = euler_exp(f, t, y0, pas)
%% Paramètres

% Invariants
nbr_entrees = 4;

%% euler_exp

%   Description :

%   Résout un système d'équations différentielles par la méthode d'euler
%   explicite.

%   Entrée(s) :

%   # f est le système d'équations différentielles.
%   # t est le vecteur ligne contenant les temps initiaux et finaux.
%   # y0 est le vecteur ligne contenant les valeurs initiales.
%   # pas est le pas utilisé dans la méthode d'euler explicite.

%   Sortie(s) :

%   # T est le vecteur colonne contenant tous les temps.
%   # Y est la matrice de toutes les solutions du système calculées.

%% Vérifications des entrées

if (nargin < nbr_entrees)
    error('Trop peu d''entrées.')
end

if (isempty(f) || isempty(t) || isempty(y0) || isempty(pas))
    error('Entrée(s) nécessaire(s) vide(s).');
end

if (isa(f, 'function_handle') == 0)
    error('Fonction non manipulable.');
end

if (size(t, 2) < 2)
    error('Trop peu de valeurs dans la seconde entrée.');
end

% Début - Normalisation de la taille des entrées
t = t(1, 1:2);
y0 = y0(1, :);
nbr_var = size(y0, 2);
pas = abs(pas(1));
% Fin - Normalisation de la taille des entrées

if (isnan(pas) || isreal(pas) == 0)
    error('Entrée(s) non réelle(s).');
end

for i = 1:2
    if (isnan(t(i)) || isreal(t(i)) == 0)
        error('Entrée(s) non réelle(s).');
    end
end

for i = 1:nbr_var
    if (isnan(y0(i)) || isreal(y0(i)) == 0)
        warning('Entrée(s) non réelle(s).');
    end
end

if (t(1) > t(2))
    error('Le temps final doit être plus grand que le temps initial.');
end

%% Algorithme

% Initialisation T et Y
T = transpose(t(1):pas:t(2));
if (T(end) < t(2))
    T = [T(:); t(2)];
end
nbr_itr = size(T, 1);
Y = zeros(nbr_itr, nbr_var);
Y(1, :) = y0(1, :);

% Boucle
for i = 2:nbr_itr
    dyi = f(T(i - 1), transpose(Y(i - 1, :)));
    if (size(dyi, 1) ~= nbr_var)
        error('Incompatibilité de dimensions à l''affectation.');
    end
    for k = 1:nbr_var
        if (isnan(dyi(k)) || isreal(dyi(k)) == 0)
            error('Valeur(s) calculée(s) non réelle(s).');
        end
    end
    Y(i, :) = Y(i - 1, :) + pas * transpose(dyi);
end

end

