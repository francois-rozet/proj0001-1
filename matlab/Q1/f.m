function y = f(x, tabl)
%% Paramètres

% Invariants
nbr_entrees = 2;

%% f

%   Description :

%   Lie à une abscisse donnée une image "probable" calculée par
%   interpolation sur les valeurs d'un tableau.

%   Entrée(s) :

%   # x est l'abscisse donnée.
%   # tabl est le tableau de valeurs donné.

%   Sortie(s) :

%   # y est l'image trouvée.

%% Vérifications des entrées

if (nargin < nbr_entrees)
    error('Pas assez d''entrées.');
end

if (isempty(x) || isempty(tabl))
    error('Entrée(s) nécessaire(s) vide(s).');
end

if (size(tabl, 2) < 2)
    error('Trop peu de colonnes dans la seconde entrées.');
end

% Début - Normalisation de la taille des entrées
x = x(:);
tabl = tabl(:, 1:2);
% Fin - Normalisation de la taille des entrées

for i = 1:size(x, 1)
    if (isnan(x(i)) || isreal(x(i)) == 0)
        warning('Entrée(s) non réelle(s).');
    end
end

for i = 1:size(tabl, 1)
    for j = 1:2
        if (isnan(tabl(i, j)) || isreal(tabl(i, j)) == 0)
            warning('Entrée(s) non réelle(s).');
        end
    end
end

%% Interpolation

y = spline(tabl(:, 1), tabl(:, 2), x);

end