function [cimg, ApList, muList] = compress_image(img, p)
%COMPRESS_IMAGE Compress the image by applying the PCA over each channels 
% independently
%
%   input -----------------------------------------------------------------
%   
%       o img : (width x height x 3), an image of size width x height over
%       RGB channels % (1512 x 2268 x 3)
%       o p : The number of components to keep during projection 
%
%   output ----------------------------------------------------------------
%
%       o cimg : (p x height x 3) The projection of the image on the eigenvectors
%       o ApList : (p x width x 3) The projection matrices for each channels
%       o muList : (width x 3) The mean vector for each channels

    cimg = [];
    ApList = [];
    muList = [];

    for i = 1:3
        ch = img(:,:,i);

        [Mu, C, EigenVectors, EigenValues] = compute_pca(ch);
        [Y, Ap] = project_pca(ch, Mu, EigenVectors, p);
        cimg = cat(3, cimg, Y);
        ApList = cat(3, ApList, Ap);
        muList = cat(2, muList, Mu);
    end
end