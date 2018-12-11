function x = bissection(f, x0, x1, varargin)
%% Paramètres

% Invariants
nbr_entrees = 6;

% Variables
img_par_def = 0;
tol_par_def_y = 1e-3;
tol_par_def_x = 1e-3;
crit_arret = floor(log2(abs(x0 - x1)/eps)) + 1;

%% bissection

%   Description :

%   Trouve une abscisse dont l'image liée par une fonction est relativement
%   proche d'une image visée.

%   Entrée(s) :

%   # f est la fonction donnée.
%   # x0 et x1 sont des abscisses données.
%     Les images liées par la fonction à ces abscisses doivent se trouver
%     de part et d'autre de l'image visée.
%   # img (ou varargin{1}) est l'image visée.
%     Par défaut, si elle n'est pas entrée ou si elle est vide,
%     img = img_par_def.
%   # tol_y (ou varargin{2}) est la tolérance sur les ordonnées.
%     Elle vaut la distance maximale pouvant séparer f(x), l'image liée par
%     la fonction à x, de l'image visée.
%     Par défaut, si elle n'est pas entrée ou si elle est vide,
%     tol_y = tol_par_def_y.
%   # tol_x (ou varargin{3}) est la tolérance sur les abscisses.
%     Elle vaut la distance maximale pouvant séparer x de la "véritable"
%     racine.
%     Par défaut, si elle n'est pas entrée ou si elle est vide,
%     tol_x = tol_par_def_x.

%   Sortie(s) :

%   # x est l'abscisse trouvée.

%% Vérifications des entrées

if (nargin > nbr_entrees)
    error('Trop d''entrées');
end

if (nargin < nbr_entrees)
    tol_x = tol_par_def_x;
    if (nargin < nbr_entrees - 1)
        tol_y = tol_par_def_y;
        if (nargin < nbr_entrees - 2)
            img = img_par_def;
            if (nargin < nbr_entrees - 3)
                error('Trop peu d''entrées.');
            end
        else
            img = varargin{1};
        end
    else
        img = varargin{1};
        tol_y = varargin{2};
    end
else
    img = varargin{1};
    tol_y = varargin{2};
    tol_x = varargin{3};
end

if (isempty(f) || isempty(x0) || isempty(x1))
    error('Entrée(s) nécessaire(s) vide(s).');
end

if (isa(f, 'function_handle') == 0)
    error('Fonction non manipulable.');
end

% Début - Normalisation de la taille des entrées et valeurs par défaut
x0 = x0(1);
x1 = x1(1);

if (isempty(img))
    img = img_par_def;
else
    img = img(1);
end

if (isempty(tol_y))
    tol_y = tol_par_def_y;
else
    tol_y = abs(tol_y(1));
end

if (isempty(tol_x))
    tol_x = tol_par_def_x;
else
    tol_x = abs(tol_x(1));
end
% Fin - Normalisation de la taille des entrées et valeurs par défaut

if (isnan(x0) || isreal(x0) == 0 || isnan(x1) || isreal(x1) == 0 || isnan(img) || isreal(img) == 0 || isnan(tol_y) || isreal(tol_y) == 0 || isnan(tol_x) || isreal(tol_x) == 0)
    error('Entrée(s) non réelle(s).');
end

f_x0 = f(x0);
f_x1 = f(x1);

if (isnan(f_x0) || isreal(f_x0) == 0 || isnan(f_x1) || isreal(f_x1) == 0)
    error('Fonction non réelle.');
end

if ((f_x0 - img) * (f_x1 - img) > 0)
    error('Les images liées par la fonction aux abscisses données ne sont pas de part et d''autre de l''image visée.');
end

%% Algorithme

% Initialisation de a, f_a, b, f_b et i
if ((f_x0 - img) < 0)
    a = x0;
    b = x1;
    f_a = f_x0;
    f_b = f_x1;
else
    a = x1;
    b = x0;
    f_a = f_x1;
    f_b = f_x0;
end
i = 0;

% Boucle
while (i < crit_arret + 1 && (abs(f_b - img) > tol_y || abs(f_a - img) > tol_y || abs((a - b) / 2) > tol_x))
    xi = (a + b) / 2;
    f_xi = f(xi);
    if (isnan(f_xi) || isreal(f_xi) == 0)
        error('Valeur(s) calculée(s) non réelle(s).');
    else
        if (f_xi - img <= 0)
            a = xi;
            f_a = f_xi;
        else
            b = xi;
            f_b = f_xi;
        end
    end
    i = i + 1;
end

%% Vérification des sorties

if (i >= crit_arret + 1)
    error('Les valeurs ne convergent pas ou peu.');
end

if (abs(f_a - img) < abs(f_b - img))
    x = a;
else
    x = b;
end

end