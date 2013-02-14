%% This is the AiAI - Genetic Algorithm - Assignment
%   Raphael Nagel
%   22/Jan/2013
clc
clear all
close all
hold off


%% VARIABLES !!!!!EDIT HERE!!!!!
popSize=80;
%geneLength=16; %2^3*2 - 3 sensor positions with on/off(8) -- 4 possible actions (2^2 = 2bits)==>16
geneLength = 128; %as above but with memory of previous sensor reading (2^6*2) - 3 current and 3 previous sensor positions
generations=50;
maxCycles = 5; %how often to redo different the evolution from initiation

mutationRate=0.1/geneLength; % we should just about have one mutation per genom
coRate = 1;                   % how often we cross over
tournamentSize = 5;
%


%% set up thearray, etc.

%% set up the ANN
% the ANN architecture - at the moment defined by hand, later possibly by a GA

ANN_map = [
    0 0 0 1 1 0 1 0 0;
    0 0 0 0 1 1 0 0 0;
    0 0 0 1 1 1 1 0 0;
    0 0 0 0 0 0 0 1 0;
    0 0 0 0 0 0 0 1 1;
    0 0 0 0 0 0 0 1 1;
    0 0 0 0 0 0 0 0 1;
    0 0 0 0 0 0 0 0 0;
    0 0 0 0 0 0 0 0 0];
neuron = ANN_connection_setup(ANN_map); %!!!!!!!!!!!!!! We need to adjust the genom length to the number of weights and thresholds that need catering for

%% find the necessary genom parameters
numWeights = sum(sum(ANN_map));
numThresholds = length(ANN_map);
geneLength = numWeights + numThresholds;

%struct to hold the individuals  %population=struct('g',{[]},'f',[]); backup in case the other stuff doesntwork

population(1:popSize)=struct('g',{[zeros(1,geneLength)]},'f',[0]);
offspring(1:popSize)=struct('g',{[zeros(1,geneLength)]},'f',[0]);
parents(1:popSize)=struct('g',{[zeros(1,geneLength)]},'f',[0]);
rescued=struct('g',{[]},'f',[]); %will just hold the single best individual from population

% set up output for over time plotting
output=struct('bestFit',zeros(generations,maxCycles),'averageFit',zeros(generations,maxCycles),'avgBest5',zeros(generations,1),'avgAvg5',zeros(generations,1)); %preload the output file for all X cycles with nulls %per evolution




%% redo the whole GA to show how parameters influence the outcome

for evoCycles = 1:maxCycles
    
    
    %% initiate the GA with random genes
    %population = generate_binary_gene_population(population,popSize,geneLength);
    population = generate_realnum_0_1_gene_population(population,popSize,geneLength);
    
    
    
    %% !!!!!! START THE EVOLUTION !!!!!
    for genCycles = 1:generations
        
        
        %% calculate individual fitness by summing each genes with 1 per individual
        %population = n1s_fitness(population,popSize,geneLength);
        
        %% calculate individual fitness based on paired genes (gene(n) == gene(n+1))
        %population = pair1s_fitness(population,popSize,geneLength);
        
        %% calculate individual fitness based on paired genes
        % population = strict_pairs1s_fitness(population,popSize,geneLength);
        
        %% calculate individual fitness for a TSP problem
        %population = tsp_fitness(population, popSize, geneLength, distanceChartTSP);
        
        
        %% calculate individual fitness for the assignment problem
        %population = Rob_Ass_fitness_1_mem_lookup(population, popSize);
        %population = Rob_Ass_fitness_simple_lookup(population, popSize, geneLength );
        
        %% calculate individual fitness using an ANN
        population = ANN_fitness(population,popSize, neuron);
        
        %% calculate overall fitness,find and save best individual - it assumes a bigger number is a better fitness.
        
        totPopFitness=0;
        maxFitness = 0;
        for x = 1:popSize
            totPopFitness = (totPopFitness + population(x).f);
            if population(x).f > maxFitness
                maxFitness = population(x).f;
                rescued(1) = population(x); %save the single surviver
            end
        end
        
        
        %% also save in array
        
        output.bestFit(genCycles,evoCycles) = maxFitness;
        output.averageFit(genCycles,evoCycles) = (totPopFitness / popSize);
        
        
        %% find the parents
        %Begin summing the fitnesses
        %of the individuals in the population again until the running sum is
        % greater than or equal to the randomly chosen number.
        
        %parents = roulette_wheel_selection(population,popSize, totPopFitness);
        parents = tournament_selection(population,popSize,geneLength, tournamentSize);
        
        %% Recombination - one point cross over
        %offspring = one_point_CO(parents,popSize,geneLength);
        
        %% Recombination - two point cross over
        offspring = two_point_CO(parents,popSize,geneLength,coRate);
        
        %% Recombination - uniform cross over
        %offspring = uniform_CO(parents,popSize,geneLength,coRate);
        
        
        
        %% TSP crossover TBD!!!!!!!!!!!!!
        %offspring = order1_TSP_CO(parents, popSize, geneLength);
        %% Mutation
        % standart binary mutation
        %offspring = binary_mutation(offspring, popSize, geneLength, mutationRate);
        
        % add or take mutation
        offspring = add_take_mutation(offspring, popSize, geneLength, mutationRate);
        % swapTSP mutation
        %offspring = swapTSP_Mutation(offspring, popSize, geneLength);
        
        %% Survivor Selection
        
        
        population = offspring; % first overwrite the whole population with offspring
        y = randi([1,popSize]);  %select random position to overwrite with the rescued surviver
        population(y)= rescued(1); %reinsert this fittest individual of the old population
        
        
        
    end %ends the evolution
    
end
output.avgBest5 = mean(output.bestFit,2);
output.avgAvg5 = mean(output.averageFit,2);

hold on
grid on
figure(1)
subplot(2,2,1);
plot(output.bestFit,'DisplayName','output.bestFit','YDataSource','output.bestFit');figure(gcf)
xlabel('Generations - best fitness for all 5 runs');ylabel('Fitness');
subplot(2,2,2);
plot(output.averageFit,'DisplayName','output.averageFit','YDataSource','output.averageFit');figure(gcf)
xlabel('Generations - average fitness for all 5 runs');ylabel('Fitness');
subplot(2,2,3);
plot(output.avgBest5,'r','LineWidth',3,'DisplayName','output.avgBest5','YDataSource','output.avgBest5');figure(gcf)
xlabel('Generations - Average of best fitness over 5 runs');ylabel('Fitness');
subplot(2,2,4);
plot(output.avgAvg5,'b','LineWidth',3,'DisplayName','output.avgAvg5','YDataSource','output.avgAvg5');figure(gcf)
xlabel('Generations - Average of average fitness over 5 runs');ylabel('Fitness');
hold off


