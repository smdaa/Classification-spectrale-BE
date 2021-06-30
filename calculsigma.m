function [sigma] = calculsigma(Data)
    [n, p] = size(Data);
    s      = triu(pdist2(Data, Data, 'euclidean'));
    D_max  = max(s(:));
    sigma = D_max / (2*exp(log(n)/p)); 
end
