function class = gaussianClassifier(class_data,test,nfeatures)

%     A general plug-in MAP classifier using a gaussian single mixture model.
%     
%     Inputs:
%             class_data = A matrix where each column includes the mean vector and reshaped
%                          covariance matrix for a single class. The matrix is (N+1+N^2)xM, where N is the number of features
%                          and M is the number of classes. The first row is the class label,
%                          the next set of rows is the mean vector and the last rows are the reshaped covar matrix.
%             test = The input vector to be classified. A Nx1 vector where N is the number of features
%             nfeatures = The number of features to be used in classification.
%     Outputs:
%             class = the classifiers guess at the class of the input

    
    
    
    
    probs = zeros(2,size(class_data,2));
    probs(1,:) = 0:size(class_data,2)-1;
    
    for n = 1:size(class_data,2)
        mean_vec = class_data(2:nfeatures+1,n);
        covar = reshape(class_data(nfeatures+2:end,n),nfeatures,nfeatures);
        probs(2,n) = mvnpdf(test,mean_vec,covar);
    end
    
    probs = sortrows(probs',2)';
    probs = flip(probs,2);
    class = probs(1,1);
    

end