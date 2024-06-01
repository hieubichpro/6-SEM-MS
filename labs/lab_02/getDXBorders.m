function [ls, hs] = getDXBorders(gamma, s_2, n)

    alpha1 = (1 + gamma) / 2;
    alpha2 = (1 - gamma) / 2;
    
    quantile1 = chi2inv(alpha1, n - 1);
    quantile2 = chi2inv(alpha2, n - 1);
    
    ls = ((n - 1) * s_2) / quantile1;
    hs = ((n - 1) * s_2) / quantile2;
end

