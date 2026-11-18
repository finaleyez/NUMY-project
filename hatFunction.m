function phi = hatFunction(X, i, Xq)
% Evaluates one piecewise linear hat function.
% INPUTS:
%   X  - Independent variable data points
%   i  - Index of the hat function
%   Xq - Evaluation point(s)
% OUTPUT:
%   phi - Value of the selected hat function

    % Convert X to column vector
    X = X(:);

    % Check input
    if length(X) < 2
        error('At least two data points are required.');
    end

    if any(~isfinite(X)) || ~isreal(X)
        error('X must contain finite real values.');
    end

    if any(diff(X) <= 0)
        error('X values must be strictly increasing.');
    end

    if ~isscalar(i) || i ~= floor(i) || i < 1 || i > length(X)
        error('Invalid hat function index.');
    end

    if ~isnumeric(Xq) || ~isreal(Xq) || ...
       isempty(Xq) || any(~isfinite(Xq(:)))
        error('Evaluation points must be finite real values.');
    end

    % Empty vector
    phi = zeros(size(Xq));

    % First hat function
    if i == 1

        mask = Xq >= X(1) & Xq <= X(2);

        phi(mask) = (X(2) - Xq(mask)) / (X(2) - X(1));

    % Last hat function
    elseif i == length(X)

        mask = Xq > X(end-1) & Xq <= X(end);

        phi(mask) = (Xq(mask) - X(end-1)) / (X(end) - X(end-1));

    % Interior hat functions
    else

        % Left side of the hat
        leftMask = Xq >= X(i-1) & Xq <= X(i);

        phi(leftMask) = (Xq(leftMask) - X(i-1)) / (X(i) - X(i-1));

        % Right side of the hat
        rightMask = Xq > X(i) & Xq <= X(i+1);

        phi(rightMask) = (X(i+1) - Xq(rightMask)) / (X(i+1) - X(i));
    end
end
