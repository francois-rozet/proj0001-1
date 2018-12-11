function dy  = odefunction_nl(t, y, varargin)
%% Paramètres

% Invariants
nbr_entrees = 4;
nbr_var = 4;

% Variables
m = 2500;
l = 6;
c_y = 25;
c_theta = 300;
K = 1000;
w = 3;
A_par_def = 27500;
alpha_par_def = 0.1;

%% odefunction_nl

%   Description :

%   Calcule les dérivées directes d'une série de variables à partir d'un système d'équations différentielles.

%   Entrée(s) :

%   # t est le temps donné.
%   # y est la matrice de nbr_var lignes donnée.
%     Elle contient [y; y'; theta; theta'].
%   # A (ou varargin{1}) est l'amplitude du vent donnée.
%     Par défaut, si elle n'est pas entrée ou si elle est vide,
%     A = A_par_def.
%   # alpha (ou varargin{2}) est le paramètre du modèle du câble.
%     Par défaut, si elle n'est pas entrée ou si elle est vide,
%     alpha = alpha_par_def.

%   Sortie(s) :

%   # dy est la matrice de nbr_var lignes sortie.
%     Elle contient [y'; y''; theta'; theta''].

%% Vérifications des entrées

if (nargin > nbr_entrees)
    error('Trop d''entrées.');
end

if (nargin < nbr_entrees)
    alpha = alpha_par_def;
    if (nargin < nbr_entrees - 1)
        A = A_par_def;
        if (nargin < nbr_entrees - 2)
            error('Trop peu d''entrées.');
        end
    else
        A = varargin{1};
    end
else
    A = varargin{1};
    alpha = varargin{2};
end

if (isempty(t) || isempty(y))
    error('Entrée(s) nécessaire(s) vide(s).');
end

if (size(y, 1) < nbr_var)
    error('Trop peu de lignes dans la seconde entrée.');
end

% Début - Normalisation de la taille des entrées et valeurs par défaut
t = t(1);
y = y(1:nbr_var, :);

if (isempty(A))
    A = A_par_def;
else
    A = A(1);
end

if (isempty(alpha))
    alpha = alpha_par_def;
else
    alpha = alpha(1);
end
% Fin - Normalisation de la taille des entrées et valeurs par défaut

if (isnan(t) || isreal(t) == 0 || isnan(A) || isreal(A) == 0 || isnan(alpha) || isreal(alpha) == 0)
    warning('Entrée(s) non réelle(s).');
end

for i = 1:nbr_var
    for j = 1:size(y, 2)
        if (isnan(y(i, j)) || isreal(y(i, j)) == 0)
            warning('Entrée(s) non réelle(s).');
        end
    end
end

%% Système

% Initialisation de dy, val_1 et val_2
dy = zeros(nbr_var, size(y, 2));
val_1 = alpha * y(1, :);
val_2 = alpha * l * sin(y(3, :));

% Le système
dy(1, :) = y(2, :);
dy(2, :) = (A * sin(w * t) - K / alpha * (exp(val_1 + val_2) + exp(val_1 - val_2) - 2) - c_y * y(2, :)) / (m);
dy(3, :) = y(4, :);
dy(4, :) = (3 * K * l / alpha * cos(y(3, :)) * (exp(val_1 - val_2) - exp(val_1 + val_2)) - 3 * c_theta * y(4, :)) / (m * l^2);

end

