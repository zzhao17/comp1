features = csvread('features.csv');

%this is for calculating the weights of each edge.
pairwise_distances = pdist(features).^2;
pairwise_distances = pairwise_distances./(max(pairwise_distances)/2);
pairwise_distances = squareform(pairwise_distances);
pairwise_distances = exp(-pairwise_distances);


W = csvread('Adjacency.csv');%.*pairwise_distances;
k = 10;
Type = 3;
seed = csvread('seed.csv');

[cfinal, L, U] = SpectralClusteringExternal(W, k, Type, seed);

cfinal = cfinal - 1;
cfinal = [linspace(1,12000,12000)' cfinal];

check_accuracy_with_seeds(cfinal,seed);



%%%%%my own implementation of spectral clustering%%%%%

% num_digits = 10;
% 
% A = csvread('Adjacency.csv');
% 
% sqrtD = diag(sum(A,2).^(-1/2));
% L = eye(size(A,1)) - sqrtD*A*sqrtD;
% disp('done making L');
% 
% [eigvec,eigval] = eigs(L,num_digits,'sm');
% disp('done eigvec');
% 
% seed = csvread('seed.csv');
% centroid = zeros(10,10); 
% 
% for i = 1:10
%     centroid(i,:) = eigvec(seed(i,1),:);
% end
% 
% [c1,centers] = kmeans(eigvec,num_digits,'Start',centroid,'MaxIter',10000);
%  
% cfinal = c1 - 1;
% cfinal = [linspace(1,12000,12000)' cfinal];
% csvwrite('spectral_clustering_normalized.csv',cfinal);
% 
% check_accuracy_with_seeds(cfinal,seed)
