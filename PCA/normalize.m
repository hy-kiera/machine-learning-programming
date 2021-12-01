function [X, param1, param2] = normalize(data, normalization, param1, param2)
%NORMALIZE Normalize the data wrt to the normalization technique passed in
%parameter. If param1 and param2 are given, use them during the
%normalization step
%
%   input -----------------------------------------------------------------
%   
%       o data : (N x M), a dataset of M sample points of N features
%       o normalization : String indicating which normalization technique
%                         to use among minmax, zscore and none
%       o param1 : (optional) first parameter of the normalization to be
%                  used instead of being recalculated if provided
%       o param2 : (optional) second parameter of the normalization to be
%                  used instead of being recalculated if provided
%
%   output ----------------------------------------------------------------
%
%       o X : (N x M), normalized data
%       o param1 : first parameter of the normalization
%       o param2 : second parameter of the normalization

    switch nargin
        case 2
            if eq(normalization, 'minmax')
                param1 = min(data, [], 2); % 10 x 1
                param2 = max(data, [], 2);
                X = (data - param1) ./ (param2 - param1);
            elseif eq(normalization, 'zscore')
                param1 = mean(data, 2);
                param2 = std(data, 0, 2);
                X = (data - param1) ./ param2;
            elseif eq(normalization, none)
                X = data;
            else
                error('Normalization technique should be among minmax, zscore, and none');
            end
        case 4
            if eq(normalization, 'minmax')
                X = (data - param1) ./ (param2 - param1);
            elseif eq(normalization, 'zscore')
                X = (data - param1) ./ param2;
            elseif eq(normalization, none)
                X = data;
            else
                error('Normalization technique should be among minmax, zscore, and none.');
            end
        otherwise
            error('Please input both param1 and param2 or nothing.');
    end
end

