X = [12.80,10.91,10.69,10.46,13.08,11.35,13.07,12.46,13.29,11.09,10.34,...
    12.57,12.99,12.28,12.62,12.43,12.06,13.72,11.64,11.81,10.47,13.94,...
    13.31,13.31,11.11,11.06,11.84,12.28,13.14,9.80,11.27,12.56,11.15,...
    11.65,11.92,11.31,12.07,12.06,11.53,12.04,12.44,13.89,10.72,11.75,...
    11.14,12.70,13.64,12.64,11.37,10.12,11.87,13.86,12.53,12.52,10.65,...
    9.84,11.15,9.54,11.39,11.57,14.00,10.98,10.81,12.11,12.24,10.42,...
    15.21,13.00,11.63,11.40,13.41,10.78,11.98,12.51,12.95,11.59,11.04,...
    10.99,11.91,10.72,11.74,11.82,12.45,11.70,12.49,12.10,10.99,12.58,...
    12.99,10.09,12.00,13.19,12.89,11.72,13.80,11.37,12.15,10.98,11.93,...
    10.83,12.41,12.52,12.21,12.82,12.38,11.59,13.60,12.82,13.52,13.73,...
    12.53,10.78,13.69,10.41,11.13,11.28,11.28,10.40,10.47,10.51];

N = length(X);

mu = sExpectation(X);
fprintf('mu = %.6f\n', mu);

s_2 = correctedSampleVariance(X);
fprintf('s_2 = %.6f\n', s_2);

gamma = 0.9;
alpha = (1.0 - gamma) / 2.0;
fprintf('gamma = %.2f, apha = %.6f, N = %d\n', gamma, alpha, N);

[lmu, umu] = getMXBorders(gamma, s_2, mu, N);
fprintf("%.6f < MX < %.6f\n", lmu, umu);

[ls, hs] = getDXBorders(gamma, s_2, N);
fprintf("%.6f < DX < %.6f\n", ls, hs);

figure(1);
grid on;
hold on;
xlabel('n');
ylabel('\mu');
graphMX(X, N, gamma);

figure(2);
grid on;
hold on;
xlabel('n');
ylabel('\sigma');
graphDX(X, N, gamma);

function graphDX(X, n, gamma)
    s2s = zeros(n, 1);
    lowerSigma = zeros(n, 1);
    upperSigma = zeros(n, 1);
    
    for i = 1:n
        currentSample = X(1:i);
        [s2s(i)] = correctedSampleVariance(currentSample);
        [lowerSigma(i), upperSigma(i)] = getDXBorders(gamma, s2s(i), i);
    end
    
    plot([1, n], [s2s(n), s2s(n)], 'b');
    plot(lowerSigma, 'g--');
    plot(upperSigma, 'r-.');
    plot(s2s, 'm:', 'Linewidth',2);
    legend('S^2(x_N)', '_{--}\sigma^2(x_n)', '^{--}\sigma^2(x_n)', 'S^2(x_n)');
end

function [ls, hs] = getDXBorders(gamma, s_2, n)


    alpha1 = (1 + gamma) / 2;
    alpha2 = (1 - gamma) / 2;
    
    quantile1 = chi2inv(alpha1, n - 1);
    quantile2 = chi2inv(alpha2, n - 1);
    
    ls = ((n - 1) * s_2) / quantile1;
    hs = ((n - 1) * s_2) / quantile2;
end

function graphMX(X, n, gamma)
    mus = zeros(n, 1);
    s2s = zeros(n, 1);
    lowerMus = zeros(n, 1);
    upperMus = zeros(n, 1);
    
    for i = 1:n
        currentSample = X(1:i);
        [mus(i)] = sExpectation(currentSample);
        [s2s(i)] = correctedSampleVariance(currentSample);
        [lowerMus(i), upperMus(i)] = getMXBorders(gamma, s2s(i), mus(i), i);
    end
    plot([1, n], [mus(n), mus(n)], 'b');
    plot(lowerMus, 'g--');
    plot(upperMus, 'r-.');
    plot(mus, 'm:', 'Linewidth',2);
    legend('\mu\^(x_N)', '_{--}\mu^(x_n)', '^{--}\mu^(x_n)', '\mu\^(x_n)');
end

function [lm, hm] = getMXBorders(gamma, s_2, mu, n)
    alpha = (1.0 + gamma) / 2.0; % alpha1 = alpha2
    
    quantile = tinv(alpha, n - 1);
    border = (sqrt(s_2) * quantile) / sqrt(n);
    
    lm = mu - border;
    hm = mu + border;
end

function s_2 = correctedSampleVariance(X)
    s_2 = var(X);
end

function mu = sExpectation(X)
    mu = mean(X);
end