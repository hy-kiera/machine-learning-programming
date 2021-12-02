function [labels, Mu, Mu_init, iter] =  kmeans(X,K,init,type,MaxIter,plot_iter)
%MY_KMEANS Implementation of the k-means algorithm
%   for clustering.
%
%   input -----------------------------------------------------------------
%   
%       o X        : (N x M), a data set with M samples each being of dimension N.
%                           each column corresponds to a datapoint
%       o K        : (int), chosen K clusters
%       o init     : (string), type of initialization {'sample','range'}
%       o type     : (string), type of distance {'L1','L2','LInf'}
%       o MaxIter  : (int), maximum number of iterations
%       o plot_iter: (bool), boolean to plot iterations or not (only works with 2d)
%
%   output ----------------------------------------------------------------
%
%       o labels   : (1 x M), a vector with predicted labels labels \in {1,..,k} 
%                   corresponding to the k-clusters for each points.
%       o Mu       : (N x k), an Nxk matrix where the k-th column corresponds
%                          to the k-th centroid mu_k \in R^N 
%       o Mu_init  : (N x k), same as above, corresponds to the centroids used
%                            to initialize the algorithm
%       o iter     : (int), iteration where algorithm stopped
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% TEMPLATE CODE (DO NOT MODIFY)
% Auxiliary Variable
[D, N] = size(X);  % (2 400)
d_i    = zeros(K, N);
k_i    = zeros(1, N);
r_i    = zeros(K, N);
if plot_iter == [];plot_iter = 0;end
tolerance = 1e-6;
MaxTolIter = 10;

% Output Variables
Mu     = zeros(D, K); % (2 4)
labels = zeros(1, N);


%% INSERT CODE HERE
% In the case where a cluster is empty,
% reassign clusters randomly using the kmeans_init function and reset the number of iterations iter until the situation is resolved.
while true
    Mu = kmeans_init(X, K, init); % (D K)
    Mu_init = Mu;

    % Step 1: Centroid Mu initialization
    Mu_previous = Mu;

    % Step 2: Calculate distances between X and centroid Mu
    d_i = distance_to_centroids(X, Mu_previous, type); % (K N)

    % Step 3: Assignment step - Centroid responsibility
    min_d_i = min(d_i, [], 1);
    for i=1:N
        cnt = 0;
        for j=1:K
            if d_i(j, i) == min_d_i(i)
                if cnt > 1
                    % If a tie happens (i.e. two centroids are equidistant to a data point),
                    % one assigns the data point to the centroid with the smallest winning cluster size.
                    mask1 = k_i == k_i(1, i);
                    mask2 = k_i == j;
                    if numel(k_i(mask1)) >= numel(k_i(mask2))
                        k_i(1, i) = j;
                    end
                else
                    k_i(1, i) = j; % (1 N)
                    cnt = cnt + 1;
                end
            end
        end
    end

    for i=1:N
        for j=1:K
            if k_i(1, i) == j
                r_i(j, i) = 1;
            end
        end
    end
    if ~sum(sum(r_i, 2) == 0)
        break
    end
end

iter = 1;
tol_iter = 1;
while true
    % Step 1: Centroid Mu initialization
    Mu_previous = Mu;

    % Step 2: Calculate distances between X and centroid Mu
    d_i = distance_to_centroids(X, Mu_previous, type); % (K N)

    % Step 3: Assignment step - Centroid responsibility
    min_d_i = min(d_i, [], 1);
    for i=1:N
        cnt = 0;
        for j=1:K
            if d_i(j, i) == min_d_i(i)
                if cnt > 1
                    % If a tie happens (i.e. two centroids are equidistant to a data point),
                    % one assigns the data point to the centroid with the smallest winning cluster size.
                    mask1 = k_i == k_i(1, i);
                    mask2 = k_i == j;
                    if numel(k_i(mask1)) >= numel(k_i(mask2))
                        k_i(1, i) = j;
                    end
                else
                    k_i(1, i) = j; % (1 N)
                    cnt = cnt + 1;
                end
            end
        end
    end

    r_i = zeros(K, N);
    for i=1:N
        for j=1:K
            if k_i(1, i) == j
                r_i(j, i) = 1;
            end
        end
    end

    % Step 4: Update step - Recompute centroids
    for j=1:K
        sum_r = 0;
        tmp = 0;
        for i=1:N
            sum_r = sum_r + r_i(j, i);
            tmp = tmp + r_i(j, i) * X(:,i);
        end
        Mu(:, j) = tmp / sum_r; % (D K)
    end
    
    iter = iter + 1;
    
    % Step 5: Check for convergence
    [has_converged, tol_iter] = check_convergence(Mu, Mu_previous, iter, tol_iter, MaxIter, MaxTolIter, tolerance);
    if has_converged
        break
    end
end


%% TEMPLATE CODE (DO NOT MODIFY)
% Visualize Initial Centroids if N=2 and plot_iter active
colors     = hsv(K);
if (D==2 && plot_iter)
    options.title       = sprintf('Initial Mu with %s method', init);
    ml_plot_data(X',options); hold on;
    ml_plot_centroids(Mu_init',colors);
end


%% INSERT CODE HERE
labels = k_i;



%% TEMPLATE CODE (DO NOT MODIFY)
if (D==2 && plot_iter)
    options.labels      = labels;
    options.class_names = {};
    options.title       = sprintf('Mu and labels after %d iter', iter);
    ml_plot_data(X',options); hold on;    
    ml_plot_centroids(Mu',colors);
end


end