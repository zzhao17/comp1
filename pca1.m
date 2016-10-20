function [afterpca] = pca1()
% PCA1: Perform PCA
% data - MxN matrix of input data 
% (M dimensions, N trials) 
data = csvread('features.csv');
dim = 10;
[M,N] = size(data); 
% subtract off the mean for each dimension 
mn = mean(data,2); 
data = data - repmat(mn,1,N);
% normalize
var = 1/(M-1) * ( sum((data).^2));
for i = 1:1:N
    data (:,i) = sqrt( 1/ (var(:,i)) ) * data(:,i);
end
% calculate the covariance matrix 
covariance = cov(data);
% find the eigenvectors and eigenvalues 
[envec, enval] = eig(covariance);
v = diag(enval);
% sort the variances in decreasing order 
[junk, rindices] = sort(-1*v);
transform = [];
for i=1:dim
    row_num = rindices(i,:);
    add = envec(:,row_num);
    transform = [transform add];
% project the original data set 
afterpca = data * transform;
end
end 
