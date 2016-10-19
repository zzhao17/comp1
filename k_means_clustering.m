data = csvread('features.csv');
seed = csvread('seed.csv');

pairwise_distances = squareform(pdist(data).^2);

[sorted_dist,idx] = sort(pairwise_distances,2);

num_iterations = 10;
centroid = zeros(10,size(data,2));
cNearFinal = zeros(12000,num_iterations);

for i = 1:num_iterations
    for j = 1:10
        topIndices = idx(:,randi(100));
        seed_neighbors_indices = topIndices(seed(j,randi(3)),:);
        seed_neighbors = data(seed_neighbors_indices(:),:);
        centroid(j,:) = mean(seed_neighbors,1);
    end
    [c1,centers] = kmeans(data,10,'Start',centroid);
    cNearFinal(:,i) = c1 - 1;
end

cfinal = mode(cNearFinal,2);
cfinal = [linspace(1,12000,12000)' cfinal];
csvwrite('simple_k_means.csv',cfinal);

check_accuracy_with_seeds(cfinal,seed)

