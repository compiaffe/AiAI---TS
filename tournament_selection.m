function [ parents ] = tournament_selection(population,popSize,geneLength, tournamentSize)
%TOURNAMENT_SELECTION Summary of this function goes here
%   Detailed explanation goes here

%parents=struct('g',{[]},'f',[]); % this is what parents should be
parents(1:popSize)=struct('g',{[zeros(1,geneLength)]},'f',[0]);

for w = 1:popSize %create a set of parents with the same size as the old population
    
    best_individual = 1;
    bests_fitness = 0;
    for x = 1:tournamentSize
        y =  randi([1,popSize]); %find random individual from population
        if population(y).f > bests_fitness
            best_individual = y;
            bests_fitness = population(y).f;
        end
        
    end
    parents(w) = population(best_individual);
    
end

end

