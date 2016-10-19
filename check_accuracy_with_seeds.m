function [] = check_accuracy_with_seeds(cfinal,seed)

truth = repmat([0 1 2 3 4 5 6 7 8 9],1,3)';
seedpoints = cfinal(seed(:),2)
accuracy = 0;

for i = 1:30
   if seedpoints(i) == truth(i)
       accuracy = accuracy + 1;
   end
end

accuracy


end