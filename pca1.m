function [afterpca] = pca(data,k)
% Shuying Tang, cs4786, Competion 1
% Perform PCA, we normalize data in this function, free to comment out
% normalization
% data - MxN matrix of input data  
% k = dimensions we want to reduce to 
[M,N] = size(data); 
% subtract off the mean for each dimension 
mn = mean(data,1); 
data = data - repmat(mn,M,1);
% normalize input data
var = 1/(M-1) * ( sum((data).^2));
for i = 1:1:N
    data (:,i) = sqrt( 1/ (var(:,i)) ) * data(:,i);
end
% calculate the covariance matrix 
covariance = cov(data);
% find the eigenvectors and eigenvalues 
[envec, enval] = eig(covariance);
v = diag(enval);
% sort the diag eigenvalues in decreasing order 
[junk, rindices] = sort(-1*v);
transform = zeros(N,k);
for i=1:k
    col_num = rindices(i,:);
    add = envec(:,col_num);
    transform(:,i) = add;
% project the original data set 
afterpca = data * transform;
end
end 
