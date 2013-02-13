function [ population ] = generate_realnum_0_1_gene_population( population,popSize,geneLength )
%GENERATE_ generates a population with an array of real numbers between 0
%and 1 as its genom
%   Detailed explanation goes here
 for x =1:popSize
        for y=1:geneLength
            population(x).g(y)=rand(1);
            population(x).f=0;
        end
    end

end

