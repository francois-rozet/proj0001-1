function [x0, x1] = bornes(img, tabl)
%% Paramètres

% Invariants
nbr_entrees = 2;

%% bornes

%   Description :

%   Trouve deux abscisses dont les images entourent l'image visée.

%   Entrée(s) :

%   # img est l'image visée.
%   # tabl est le tableau de valeurs donné.

%   Sortie(s) :

%   # x0 et x1 sont les abscisses trouvées.

%% Vérifications des entrées

if (nargin < nbr_entrees)
    error('Pas assez d''entrées.');
end

if (isempty(img) || isempty(tabl))
    error('Entrée(s) nécessaire(s) vide(s).');
end

if (size(tabl, 2) < 2)
    error('Trop peu de colonnes dans la seconde entrées.');
end

% Début - Normalisation de la taille des entrées
img = img(1);
tabl = tabl(:, 1:2);
% Fin - Normalisation de la taille des entrées

if (isnan(img) || isreal(img) == 0)
    warning('Entrée(s) non réelle(s).');
end

for i = 1:size(tabl, 1)
    for j = 1:2
        if (isnan(tabl(i, j)) || isreal(tabl(i, j)) == 0)
            warning('Entrée(s) non réelle(s).');
        end
    end
end

%% Calculs des bornes

% Initialisation de tabl et k
tabl(:, 2) = tabl(:, 2) - img;
k = 2;

% Boucle
while (tabl(k - 1, 2) * tabl(k, 2) > 0 && k < size(tabl, 1) + 1)
    k = k + 1;
end

if (k < size(tabl, 1) + 1)
    x0 = tabl(k - 1, 1);
    x1 = tabl(k, 1);
else
    x0 = tab(1, 1);
    x1 = tabl(end, 1);
end

end

