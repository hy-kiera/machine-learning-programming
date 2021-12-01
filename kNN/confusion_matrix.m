function [C] =  confusion_matrix(y_test, y_est)
%CONFUSION_MATRIX Implementation of confusion matrix 
%   for classification results.
%   input -----------------------------------------------------------------
%
%       o y_test    : (1 x M), a vector with true labels y \in {1,2} 
%                        corresponding to X_test.
%       o y_est     : (1 x M), a vector with estimated labels y \in {1,2} 
%                        corresponding to X_test.
%
%   output ----------------------------------------------------------------
%       o C          : (2 x 2), 2x2 matrix of |TP & FN|
%                                             |FP & TN|.
%        
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
classes = unique(y_test); % {1, 2}
C = zeros(2, 2);

TP = sum(y_test == classes(1) & y_est == classes(1));
FN = sum(y_test == classes(1) & y_est == classes(2));
FP = sum(y_test == classes(2) & y_est == classes(1));
TN = sum(y_test == classes(2) & y_est == classes(2));

C(1, 1) = TP;
C(1, 2) = FN;
C(2, 1) = FP;
C(2, 2) = TN;


end

