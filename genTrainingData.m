function training = genTrainingData(dataMatrix,classLoc,features,trainingSize)
    nFeatures = size(features,2);
    training = zeros(nFeatures+1,trainingSize);
    training(1,:) = dataMatrix(1:trainingSize,classLoc)';
    
    for n = 2:nFeatures+1
        training(n,:) = dataMatrix(1:trainingSize,features(n-1))';
    end



end