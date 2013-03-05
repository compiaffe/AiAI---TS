function [ offspring ] = binary_mutation( offspring, popSize, geneLength, mutationRate )
%BINARY_MUTATION Summary of this function goes here
%   Detailed explanation goes here
for x = 1:popSize                           %for all offspring
    for y = 1:geneLength                    %for each gene
        z=rand(1);                          %flip a coin completely random(like drawing from Gauss distribution?)
        if z < mutationRate                 %implements the probability
            if offspring(x).g(y)==1;        %flip the gene
                offspring(x).g(y) = 0;
            else
                offspring(x).g(y) = 1;
            end
            
        end
    end
end
end


