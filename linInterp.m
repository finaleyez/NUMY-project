function h = linearInterp(T,H,TQuery)

    % Find surrounding temperature interval
    i = find(T <= T_query,1,'last');

    % Handle endpoints
    if T_query < T(1) || T_query > T(end)
        error('Temperature outside table range.');
    end

    if T_query == T(end)
        i = length(T)-1;
    end

    % Linear interpolation
    h = H(i) + ...
        (H(i+1)-H(i))/(T(i+1)-T(i)) ...
        *(T_query-T(i));

end

