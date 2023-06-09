function class = kNNClassifier(k,test,training,zscore)

%     A general kNN classifier that uses the k nearest data points in the training set
%     to classify an input
%     
%     Inputs:
%             k = number of closest data points in the training set to the input
%             test = the input vector to be classified. A Nx1 vector where N is the number of features, each element is a feature
%             training = the training data set. A N+1xM where N is the number of features and M is the size of the training set.
%                        Every column represents a labeled data point where the first row is the class label,
%                        and the next N rows are the features
%             zscore = Setting this value changes the normalization from min-max to zscore
%     Outputs:
%             class = the classifiers guess at the class of the input


    if exist('zscore','var')
        for n = 2:size(training,1)
        sigma = std(training(n,:));
        mu = mean(training(n,:));
        training(n,:) = (training(n,:)-mu)/sigma;
        test(n-1) = (test(n-1) -mu)/sigma; 
        end
    else
        for n = 2:size(training,1)
        ma = max(training(n,:));
        mi = min(training(n,:));
        training(n,:) = (training(n,:)-mi)/(ma-mi);
        test(n-1) = (test(n-1) -mi)/(ma-mi); 
        end
    end
    
    diff = pdist2(test',training(2:end,:)');
    [sorted,indexes] = sort(diff,2);
    
    kNN_labels = training(1,indexes(:,1:k));
    
    labels = mode(kNN_labels);
    class = labels(1);

    for n = 1:length(kNN_labels)
        if ismember(kNN_labels(n),labels)
            class = kNN_labels(n);
            break
        end
    end 

    
    
    
    
end
