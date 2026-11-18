function Yq = linearHatInterp(X, Y, Xq)

    % Convert input data into column vectors
    X = X(:);
    Y = Y(:);

    % Validate data; at least two points, increasing, matching sizes so data points correspond
    if length(X) ~= length(Y)
        error('X and Y must have the same number of elements.');
    end

    if length(X) < 2
        error('At least two data points are required.');
    end

    if any(diff(X) <= 0)
        error('X values must be strictly increasing.');
    end

    % Check evaluation points in case they are not normal numerical values
    if ~isnumeric(Xq) || ~isreal(Xq) || isempty(Xq) || any(~isfinite(Xq(:)))
        error('Evaluation points must be finite real values.');
    end

    % Prevent extrapolation outside of the provided values
    if any(Xq(:) < X(1)) || any(Xq(:) > X(end))
        error('Evaluation point is outside the data range.');
    end

    % Define interpolated enthalpy
    Hq = zeros(size(Xq));

    % Add each hat function
    for i = 1:length(X)

        % Evaluate the current hat function
        phi = hatFunction(X, i, Xq);

        % Multiply by corresponding enthalpy and add
        Yq = Yq + Y(i) .* phi;
    end
end

