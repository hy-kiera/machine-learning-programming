function [F1_overall, P, R, F1] =  f1measure(cluster_labels, class_labels)
%MY_F1MEASURE Computes the f1-measure for semi-supervised clustering
%
%   input -----------------------------------------------------------------
%   
%       o class_labels     : (1 x M),  M-dimensional vector with true class
%                                       labels for each data point
%       o cluster_labels   : (1 x M),  M-dimensional vector with predicted 
%                                       cluster labels for each data point
%   output ----------------------------------------------------------------
%
%       o F1_overall      : (1 x 1)     f1-measure for the clustered labels
%       o P               : (nClusters x nClasses)  Precision values
%       o R               : (nClusters x nClasses)  Recall values
%       o F1              : (nClusters x nClasses)  F1 values
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[~, M] = size(cluster_labels); % number of labeled datapoints (1 720)
c = length(unique(class_labels)); % number of class 4
k = length(unique(cluster_labels)); % number of cluster 5

C = zeros(1, c);
K = zeros(1, k);
R = zeros(k, c);
P = zeros(k, c);
F1 = zeros(k, c);

for i=1:c
    C(i) = sum(class_labels == i); % number of samples in i class (1 c)
end
for i=1:k
    K(i) = sum(cluster_labels == i); % number of samples in k cluster (1 k)
end

for i=1:k
    for j=1:c
        n_ik = sum(class_labels == j & cluster_labels == i);
        R(i, j) = n_ik / C(j);
        P(i, j) = n_ik / K(i);
        if R(i, j) == 0 || P(i, j) == 0 % Handle division by zero
            F1(i, j) = 0;
        else
            F1(i, j) = 2 * R(i, j) * P(i, j) / (R(i, j) + P(i, j));
        end
    end
end

tmp = max(F1, [], 1); % (1 c)
F1_overall = 0;
for i=1:c
    F1_overall = F1_overall + (C(i) / M) * tmp(i);
end

end
