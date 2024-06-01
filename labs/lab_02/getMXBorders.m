function [lm, hm] = getMXBorders(gamma, s_2, mu, n)

    alpha = (1.0 + gamma) / 2.0; % alpha1 = alpha2
    
    quantile = tinv(alpha, n - 1); 
                                   
    border = (sqrt(s_2) * quantile) / sqrt(n);
    
    lm = mu - border;
    hm = mu + border;
end

