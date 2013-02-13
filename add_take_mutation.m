function [ offspring ] = add_take_mutation( offspring, popSize, geneLength, mutationRate )
%ADD_TAKE_MUTATION      Mutate real numbers

%adds or takes a random value between 0 and 1 from the
%gene of mutated. The mutation rate is set elsewhere


for x = 1:popSize                           %for all offspring
    for y = 1:geneLength                    %for each gene
        z=rand(1);                          %flip a coin completely random(like drawing from Gauss distribution?)
        if z < mutationRate                 %implements the probability
            offspring(x).g(y) = offspring(x).g(y) + (-1 + 2.*rand(1));
            
        end
    end
end

end

