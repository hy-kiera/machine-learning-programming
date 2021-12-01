function [avgTP, avgFP, stdTP, stdFP] =  cross_validation(X, y, F_fold, valid_ratio, params)
%CROSS_VALIDATION Implementation of F-fold cross-validation for kNN algorithm.
%
%   input -----------------------------------------------------------------
%
%       o X         : (N x M), a data set with M samples each being of dimension N.
%                           each column corresponds to a datapoint
%       o y         : (1 x M), a vector with labels y \in {1,2} corresponding to X.
%       o F_fold    : (int), the number of folds of cross-validation to compute.
%       o valid_ratio  : (double), Training/Testing Ratio.
%       o params : struct array containing the parameters of the KNN (k,
%                  d_type and k_range)
%
%   output ----------------------------------------------------------------
%
%       o avgTP  : (1 x K), True Positive Rate computed for each value of k averaged over the number of folds.
%       o avgFP  : (1 x K), False Positive Rate computed for each value of k averaged over the number of folds.
%       o stdTP  : (1 x K), Standard Deviation of True Positive Rate computed for each value of k.
%       o stdFP  : (1 x K), Standard Deviation of False Positive Rate computed for each value of k.
%
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
k_range = params.k_range;
K = length(k_range);

avgTP = zeros(1, K);
avgFP = zeros(1, K);
stdTP = zeros(1, K);
stdFP = zeros(1, K);

for i=1:K
    TP_rate = zeros(1, F_fold);
    FP_rate = zeros(1, F_fold);
    for j=1:F_fold
        [X_train, y_train, X_test, y_test] = split_data(X, y, valid_ratio);
        params.k = k_range(i);
        y_est = knn(X_train,  y_train, X_test, params);
        C = confusion_matrix(y_test, y_est);
        TP = C(1, 1);
        FN = C(1, 2);
        FP = C(2, 1);
        TN = C(2, 2);
    
        TP_rate(1, j) = TP / (TP + FN);
        FP_rate(1, j) = FP / (FP + TN);
    end
    avgTP(1, i) = mean(TP_rate);
    avgFP(1, i) = mean(FP_rate);
    stdTP(1, i) = std(TP_rate);
    stdFP(1, i) = std(FP_rate);
end






end