function graphDX(X, n, gamma)
    s2s = zeros(n, 1);
    lowerSigma = zeros(n, 1);
    upperSigma = zeros(n, 1);
    
    for i = 1:n
        currentSample = X(1:i);
        [s2s(i)] = var(currentSample);
        [lowerSigma(i), upperSigma(i)] = getDXBorders(gamma, s2s(i), i);
    end
    
    plot([15, n], [s2s(n), s2s(n)], 'b');
    n_values = 15:n;
    plot(n_values, lowerSigma(15:n), 'g--');
    plot(n_values, upperSigma(15:n), 'r-.');
    plot(n_values, s2s(15:n), 'm:', 'Linewidth',2);
    legend('S^2(x_N)', '_{--}\sigma^2(x_n)', '^{--}\sigma^2(x_n)', 'S^2(x_n)');
end