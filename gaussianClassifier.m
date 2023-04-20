function class = gaussianClassifier(class_data,test,nfeatures)

    prob = @(mean_vec,covar,test) 1/((2*pi)^(size(test,1)/2)*det(covar))*exp(-1/2*(test-mean_vec)'*inv(covar)*(test-mean_vec));
    
    
    
    
    probs = zeros(2,size(class_data,2));
    probs(1,:) = 0:size(class_data,2)-1;
    
    for n = 1:size(class_data,2)
        mean_vec = class_data(2:nfeatures+1,n);
        covar = reshape(class_data(nfeatures+2:end,n),nfeatures,nfeatures);
        probs(2,n) = prob(mean_vec,covar,test);
    end
    
    probs = sortrows(probs',2)';
    probs = flip(probs,2);
    class = probs(1,1);
    

end