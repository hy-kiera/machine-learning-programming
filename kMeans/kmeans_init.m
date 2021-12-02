function [Mu] =  kmeans_init(X, k, init)
%KMEANS_INIT This function computes the initial values of the centroids
%   for k-means algorithm, depending on the chosen method.
%
%   input -----------------------------------------------------------------
%   
%       o X     : (N x M), a data set with M samples each being of dimension N.
%                           each column corresponds to a datapoint (2 400)
%       o k     : (double), chosen k clusters
%       o init  : (string), type of initialization {'sample','range'}
%
%   output ----------------------------------------------------------------
%
%       o Mu    : (N x k), an N x k matrix where the k-th column corresponds
%                          to the k-th centroid mu_k \in R^N (2 4)             
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[N, ~] = size(X); % 2 400

if strcmp(init, "sample")
    Mu = datasample(X, k, 2, 'Replace', false);
elseif strcmp(init, "range")
    Mu = [];
    for i=1:N
        X_min = min(X(i, 1:end));
        r = fix(range(X(i, 1:end)));
        tmp = randsample(r, k) + X_min;
        Mu = [Mu;tmp'];
    end
end

end