function [covar,mean_v] = genCovAndMean(A)

%     Generates the covariance matrix of the input A, and a
%     mean vector where each element is the mean of the corresponding 
%     column of A.

    covar = cov(A);
    mean_v = zeros(size(A,2),1);
    for n = 1:size(A,2)
        mean_v(n) = mean(A(:,n));
    end

end