function [accuracy]=kernel_pca_kmeans()
% Shuying Tang, CS4786, Competition 1; Oct 24, 2016
% Conduct Kernel PCA on the features.csv, k = the dimension we want to 
% reduce to, and then do k-means; in this case, k=3.
features = csvread('features.csv');
seed = csvread('seed.csv');
kern = kernel(features,'lin'); %do kernel PCA, get kernel function
data = KPCA(kern,3); % conduct kernel PCA
figure;
scatter3(data(1:12000,1),data(1:12000,2),data(1:12000,3),'b');

pairwise_distances = squareform(pdist(data).^2);
[sorted_dist,idx] = sort(pairwise_distances,2);

num_iterations = 100;
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
csvwrite('kernel_pca_kmeans.csv',cfinal);

truth = repmat([0 1 2 3 4 5 6 7 8 9],1,3)';
seedpoints = cfinal(seed(:),2)
accuracy = 0;

for i = 1:30
   if seedpoints(i) == truth(i)
       accuracy = accuracy + 1;
   end
end

end

function Y = KPCA(Kern,K)

n = size(Kern,1);
Ktilde  = Kern - ones(n,n)*Kern/n - Kern*ones(n,n)/n + ones(n,n)*Kern*ones(n,n)/n^2;

[P,Gamma] = eigs(Ktilde,K);

for j = 1:K
    Alpha(:,j) = P(:,j)/sqrt(n*Gamma(j,j));
end

Y = Ktilde*Alpha;
end


function K = kernel(X,choice)

n = size(X,1);

if(choice == 'sqr')
    for t = 1:n
        for s = 1:n
            K(t,s) = exp(- norm(X(t,:) - X(s,:))^2/8);
        end
    end
elseif(choice == 'lin')
for t = 1:n
        for s = 1:n
            K(t,s) = X(t,:)*(X(s,:))';
        end
    end
elseif(choice == 'rbf')
    for t = 1:n
        for s = 1:n
            K(t,s) = exp(- norm(X(t,:) - X(s,:))^2/8);            
        end
    end
end
end
