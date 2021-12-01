function [ y_est ] =  knn(X_train,  y_train, X_test, params)
%MY_KNN Implementation of the k-nearest neighbor algorithm
%   for classification.
%
%   input -----------------------------------------------------------------
%   
%       o X_train  : (N x M_train), a data set with M_train samples each being of dimension N.
%                           each column corresponds to a datapoint
%       o y_train  : (1 x M_train), a vector with labels y \in {1,2} corresponding to X_train.
%       o X_test   : (N x M_test), a data set with M_test samples each being of dimension N.
%                           each column corresponds to a datapoint
%       o params : struct array containing the parameters of the KNN (k, d_type)
%
%   output ----------------------------------------------------------------
%
%       o y_est   : (1 x M_test), a vector with estimated labels y \in {1,2} 
%                   corresponding to X_test.
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[~, M_train] = size(X_train);
[~, M_test] = size(X_test);
C = unique(y_train); % Classes
k = params.k;
dist = zeros(M_train, M_test);
y_est = zeros(1, M_test);

for j=1:M_test
    for i=1:M_train
        dist(i, j) = compute_distance(X_train(:,i), X_test(:,j), params);
    end
end

[~, I] = sort(dist, 1, 'ascend');
knn = I(1:k, :); % (k, M_test)

for i=1:M_test
    y_knn = y_train(knn(1:k, i));
    cnt = zeros(1, length(C));
    for j=1:length(C)
        tmp = find(C(j) == y_knn);
        cnt(j) = length(tmp);
    end
    [~, max_arg] = max(cnt);
    y_est(i) = max_arg;
end

end