function [covar,mean_v] = genCovAndMean(A)

    covar = cov(A);
    mean_v = zeros(size(A,2),1);
    for n = 1:size(A,2)
        mean_v(n) = mean(A(:,n));
    end

end