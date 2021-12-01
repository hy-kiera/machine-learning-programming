function [rimg] = reconstruct_image(cimg, ApList, muList)
%RECONSTRUCT_IMAGE Reconstruct the image given the compressed image, the
%projection matrices and mean vectors of each channels
%
%   input -----------------------------------------------------------------
%   
%       o cimg : The compressed image
%       o ApList : List of projection matrices for each independent
%       channels
%       o muList : List of mean vectors for each independent channels
%
%   output ----------------------------------------------------------------
%
%       o rimg : The reconstructed image

    rimg = [];
    for i=1:3
        Xhat = reconstruct_pca(cimg(:,:,i), ApList(:,:,i), muList(:,i));
        rimg = cat(3, rimg, Xhat);
    end
end