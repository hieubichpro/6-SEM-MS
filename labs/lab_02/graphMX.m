function graphMX(X, n, gamma)
    mus = zeros(n, 1);
    s2s = zeros(n, 1);
    lowerMus = zeros(n, 1);
    upperMus = zeros(n, 1);
    
    for i = 1:n
        currentSample = X(1:i);
        [mus(i)] = mean(currentSample);
        [s2s(i)] = var(currentSample);
        [lowerMus(i), upperMus(i)] = getMXBorders(gamma, s2s(i), mus(i), i);
    end
    plot([15, n], [mus(n), mus(n)], 'b');
    n_values = 15:n;
    plot(n_values, lowerMus(15:n), 'g--');
    plot(n_values, upperMus(15:n), 'r-.');
    plot(n_values, mus(15:n), 'm:', 'Linewidth',2);
    legend('\mu\^(x_N)', '_{--}\mu^(x_n)', '^{--}\mu^(x_n)', '\mu\^(x_n)');
end
