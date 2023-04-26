function class = kNNClassifie(k,test,training,nclasses,zscore)
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
