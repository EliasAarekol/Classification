function test = genTestData(dataMatrix,classLoc,features,testStart)

%     Generates test data for classifier testing.
%     
%     Inputs: 
%             dataMatrix = Matrix containig data where each column is a feature
%                          and each row is a song.
%              classLoc = location of column containing class labels in dataMatrix
%              features = a 1XN vector containg the location of which features extract from the dataMatrix,
%                          N is the number of features.
%              testStart = Index of row where testdata starts in dataMatrix
%     Outputs:
%              test = A (N+1)xM matrix where each column represents a track and each row
%                     represents its features. The class label is contained in the first row.
%                     N is the number of features and M is the number of
%                     tracks in the test set.
%     

    nFeatures = size(features,2);
    test = zeros(nFeatures+1,size(dataMatrix,1)-testStart+1);
    test(1,:) = dataMatrix(testStart:end,classLoc)';
    
    for n = 2:nFeatures+1
        test(n,:) = dataMatrix(testStart:end,features(n-1))';
    end
end