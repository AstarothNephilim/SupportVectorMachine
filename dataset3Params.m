function [C, sigma] = dataset3Params(X, y, Xval, yval)
%DATASET3PARAMS returns your choice of C and sigma for Part 3 of the exercise
%where you select the optimal (C, sigma) learning parameters to use for SVM
%with RBF kernel
%   [C, sigma] = DATASET3PARAMS(X, y, Xval, yval) returns your choice of C and 
%   sigma. You should complete this function to return the optimal C and 
%   sigma based on a cross-validation set.
%

% You need to return the following variables correctly.
C_vals = [0.01,0.03,0.1,0.3,1,3,10,30];
sigma_vals = [0.01,0.03,0.1,0.3,1,3,10,30];
error_matrix = zeros(size(C_vals,2),size(sigma_vals,2));

% ====================== YOUR CODE HERE ======================
% Instructions: Fill in this function to return the optimal C and sigma
%               learning parameters found using the cross validation set.
%               You can use svmPredict to predict the labels on the cross
%               validation set. For example, 
%                   predictions = svmPredict(model, Xval);
%               will return the predictions on the cross validation set.
%
%  Note: You can compute the prediction error using 
%        mean(double(predictions ~= yval))
%

C = 0.1;
sigma = 0.1;


for i = 1:size(C_vals,2)
    for j = 1:size(sigma_vals,2)
        model = svmTrain(X, y, C_vals(i), @(x1, x2) gaussianKernel(x1, x2, sigma_vals(j))); 
        predictions = svmPredict(model, Xval);
        error_matrix(i,j) = mean(double(predictions ~= yval));
    end
end

min_error = min(min(error_matrix)); %Searches for min element
idx = error_matrix == min_error; %Creates a logical array

[row,col] = find(idx); %Gives indexes of non 0 elts.
C = C_vals(row);
sigma = sigma_vals(col);

% =========================================================================

end
