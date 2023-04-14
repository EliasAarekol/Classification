function class = kNNClassifier(k,test,training,nclasses)

    N = length(training);
    diff = zeros(size(training,1)+1,size(training,2));
   % disp(training);
    for n = 1:N
        localdiff = test-training(2:end,n);
        diff(:,n) = [norm(localdiff) ;training(1,n) ; localdiff];
    end
    diff = sortrows(diff',1)';
    disp("diff mattrix is:");
    disp(diff(:,1:10))
    
    classCount = zeros(2,nclasses);
    classCount(1,:) = 0:nclasses-1;
    disp("Classcount is:");
    disp(classCount(:,1:10))

    
    for n = 1:k 
        element = diff(2,n);
        disp(element);
        classCount(2,element+1) = classCount(2,element+1) +1 ;
    end
   
    classCount = sortrows(classCount',2)';
    classCount = flip(classCount,2);
    disp("Classcount is:");
    disp(classCount(:,1:10))
    identicals = zeros(1,k);
    highest = classCount(2,1);
    n = 0;
    exit = 0;
    while not(exit)
        n = n +1;
        
        if classCount(2,n) == highest
            identicals(n) = classCount(1,n);
        else
            exit = 1;
            identicals = identicals(1:n-1);
        end
        exit = exit || n == k;
    end
    
   % disp("identicals are:",identicals);
    
    class = NaN;
    
    for n = 1:k 
        if ismember(classCount(1,n),identicals)
            class = classCount(1,n);
            disp("found class to be:");
            disp(class)
            break
        end
    end
    
    end

  