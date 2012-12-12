function [ offspring ] = order1_TSP_CO( parents,popSize,geneLength )
%ORDER1_TSP_CO Summary of this function goes here
%   Detailed explanation goes here
offspring(1:popSize)=struct('g',{[zeros(1,geneLength)]},'f',[0]);
for p = 1:popSize %for the whole population
    y = randi([1,popSize]);%find parents n1
    z = randi([1,popSize]);%find parent n2
    
    s1 = randi([1,geneLength]); %finds the one point on the string we will copy from the parents
    s2 = randi([1,geneLength]);%finds the other point on the string we will copy from the parents
    
    
    if  s1 <= s2    %ensures s1 is the start position of the string we copy
        start = s1;
        finish = s2;
    else
        start = s2;
        finish = s1;
    end
    %% first step - copy string of parent 1's genome to child
    for x = start:finish
        offspring(p).g(x) = parents(y).g(x);
    end
    %% second step - copy remaining items from parent 2
    parent_pos = inc_wrap(finish,geneLength); %increments the parents position and handles wrapping.
    offspring_pos = inc_wrap(finish,geneLength);%sets the parent and offspring position to the finish_position + 1
    
    while offspring_pos ~= start
        double_flag = 0;
        for v = 1:geneLength %check the genome to prevent double entries
            
            if offspring(p).g(v) == parents(z).g(parent_pos)
                double_flag = 1;
                break;
                
                
            end

        end
        if double_flag == 1 %if this gene is already in there
            parent_pos = inc_wrap(parent_pos,geneLength);
        else
            offspring(p).g(offspring_pos) = parents(z).g(parent_pos);
            parent_pos = inc_wrap(parent_pos,geneLength);
            offspring_pos = inc_wrap(offspring_pos,geneLength);
        end
        
    end
end

