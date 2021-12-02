function [RSS, AIC, BIC] =  compute_metrics(X, labels, Mu)
%MY_METRICS Computes the metrics (RSS, AIC, BIC) for clustering evaluation
%
%   input -----------------------------------------------------------------
%   
%       o X        : (N x M), a data set with M samples each being of dimension N.
%                           each column corresponds to a datapoint
%       o labels   : (1 x M), a vector with predicted labels labels \in {1,..,k} 
%                   corresponding to the k-clusters.
%       o Mu       : (N x k), matrix where the k-th column corresponds
%                          to the k-th centroid mu_k \in R^N
%
%   output ----------------------------------------------------------------
%
%       o RSS      : (1 x 1), Residual Sum of Squares
%       o AIC      : (1 x 1), Akaike Information Criterion
%       o BIC      : (1 x 1), Bayesian Information Criteria
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
RSS = 0;
[~, M] = size(X);
[N, K] = size(Mu);
for k=1:K
    mask = find(labels==k);
    ck = X(1:N, mask);
    [~, l_ck] = size(ck);
    for j=1:l_ck
        RSS = RSS + sum(power(abs(ck(1:end, j) - Mu(1:end, k)), 2), "all");
    end
end

B = K * N;
AIC = RSS + 2 * B;
BIC = RSS + log(M) * B;


end