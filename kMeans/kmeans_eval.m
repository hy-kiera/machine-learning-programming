function [RSS_curve, AIC_curve, BIC_curve] =  kmeans_eval(X, K_range,  repeats, init, type, MaxIter)
%KMEANS_EVAL Implementation of the k-means evaluation with clustering
%metrics.
%
%   input -----------------------------------------------------------------
%   
%       o X           : (N x M), a data set with M samples each being of dimension N.
%                           each column corresponds to a datapoint
%       o repeats     : (1 X 1), # times to repeat k-means
%       o K_range     : (1 X K_range), Range of k-values to evaluate
%       o init        : (string), type of initialization {'sample','range'}
%       o type        : (string), type of distance {'L1','L2','LInf'}
%       o MaxIter     : (int), maximum number of iterations
%
%   output ----------------------------------------------------------------
%       o RSS_curve  : (1 X K_range), RSS values for each value of K in K_range
%       o AIC_curve  : (1 X K_range), AIC values for each value of K in K_range
%       o BIC_curve  : (1 X K_range), BIC values for each value of K in K_range
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
RSS_curve = zeros(1, length(K_range));
AIC_curve = zeros(1, length(K_range));
BIC_curve = zeros(1, length(K_range));

for k=1:K_range
    total_RSS = 0;
    total_AIC = 0;
    total_BIC = 0;
    for i=1:repeats
        [labels, Mu, ~] = kmeans(X, k, init, type, MaxIter, false);
        [RSS, AIC, BIC] = compute_metrics(X, labels, Mu);
        total_RSS = total_RSS + RSS;
        total_AIC = total_AIC + AIC;
        total_BIC = total_BIC + BIC;
    end
    RSS_curve(k) = total_RSS / repeats;
    AIC_curve(k) = total_AIC / repeats;
    BIC_curve(k) = total_BIC / repeats;
end





end