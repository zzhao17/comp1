features = csvread('features.csv');

[coeff,score,latent] = pca(features,'NumComponents',3);

features = score;

pairwise_distances = pdist(features);
inverse_distance = squareform(pairwise_distances.^-2);
[sorted_dist,idx] = sort(squareform(pairwise_distances),2);


W = csvread('Adjacency.csv').*inverse_distance;
k = 10;
Type = 3;
seed = csvread('seed.csv');

[cfinal, L, U] = SpectralClusteringExternal(W, k, Type, seed, idx);

cfinal = [linspace(1,12000,12000)' cfinal];

csvwrite('spectral_clustering_normalized.csv',cfinal);

check_accuracy_with_seeds(cfinal,seed);



%%%%%my own implementation of spectral clustering%%%%%

% num_digits = 10;
% 
% sqrtD = diag(sum(W,2).^(-1/2));
% L = eye(size(W,1)) - sqrtD*W*sqrtD;
% disp('done making L');
% 
% [eigvec,eigval] = eigs(L,num_digits,'sm');
% disp('done eigvec');
% 
% centroid = zeros(num_digits,num_digits); 
% 
% for i = 1:10
%     centroid(i,:) = eigvec(seed(i,2),:);
% end
% 
% [c1,centers] = kmeans(eigvec,num_digits,'Start',centroid,'MaxIter',10000);
%  
% cfinal = c1 - 1;
% cfinal = [linspace(1,12000,12000)' cfinal];
% csvwrite('spectral_clustering_normalized.csv',cfinal);
% 
% check_accuracy_with_seeds(cfinal,seed)
% figure;
% scatter(linspace(1,100,100),diag(eigval));

