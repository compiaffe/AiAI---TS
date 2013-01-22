function [ output_args ] = Rob_Ass_fitness(population, popSize, geneLength )
%ROB_ASS_FITNESS Summary of this function goes here
%   Detailed explanation goes here


for x = 1 : popSize
    population(x).f = 0;
%% set up the world    
    world = [0 0 0 0 0 0 0 0;
        1 1 1 1 1 1 0 0;
        0 0 0 0 0 1 0 0;
        0 0 0 0 0 1 0 0;
        0 0 0 0 0 1 1 1;
        1 0 1 1 0 0 0 1;
        0 0 0 1 1 1 1 1;
        0 0 0 0 0 0 0 0];
    north = 0;
    east = 1;
    south = 2;
    west = 3;
 %starting position and heading   
    position = [2,2];
    heading = east;  
    ahead = [0 0 0];
    
    for day = 1:35
        ahead = read_sensor_RA(world,position, heading);
        action  = look_up_RA(population(x), ahead); %decides and moves - simple lookup table here now
        
        position = move_RA(position, action);
        if (world(position) == 1)
            population(x).f = population(x).f + 1;
            world(position) = 0;
        end
    end
end


end

