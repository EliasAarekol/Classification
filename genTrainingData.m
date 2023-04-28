function training = genTrainingData(dataMatrix,classLoc,features,trainingSize)

%     Generates test data for classifier testing.
%     
%     Inputs: 
%             dataMatrix = Matrix containig data where each column is a feature
%                          and each row is a song.
%              classLoc = location of column containing class labels in dataMatrix
%              features = a 1XN vector containg the location of which features extract from the dataMatrix,
%                          N is the number of features.
%              trainingSize = Index of row where trainingdata ends in dataMatrix
%     Outputs:
%              training = A (N+1)xM matrix where each column represents a track and each row
%                         represents its features. The class label is contained in the first row.
%                         N is the number of features and M is the number
%                         of tracks in the training set.
%  
%                       
%     
    nFeatures = size(features,2);
    training = zeros(nFeatures+1,trainingSize);
    training(1,:) = dataMatrix(1:trainingSize,classLoc)';
    
    for n = 2:nFeatures+1
        training(n,:) = dataMatrix(1:trainingSize,features(n-1))';
    end



end