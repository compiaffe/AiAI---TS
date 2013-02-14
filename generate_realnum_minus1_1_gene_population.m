function [ population ] = generate_realnum_minus1_1_gene_population( population,popSize,geneLength )
%GENERATE_ generates a population with an array of real numbers between -1
%and 1 as its genom. 
% In an ANN, having a negative threshold will effectively allow for excitationary and inhibitionary neurons 


for x =1:popSize
        for y=1:geneLength
            population(x).g(y)=-1 +(2).*rand(1);
            population(x).f=0;
        end
    end

end

