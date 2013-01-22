function [ population ] = Rob_Ass_fitness(population, popSize, geneLength )
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
    action = 0;
    %starting position and heading
    robot.position = [1,1];
    robot.heading = east;
    ahead = [0 0 0;
        0 0 0;
        0 0 0];  % [xleft yleft track?; xcenter ycenter track?; xright  ...]
    
    %starting on track?
    if (world(robot.position(1),robot.position(2)) == 1)
        population(x).f = population(x).f + 1;
        world(robot.position(1),robot.position(2)) = 0;
    end
    
    for day = 1:35
        ahead = read_sensor_RA(world,robot);
        action  = look_up_RA(population(x), ahead); %decides on action simple lookup table here now
        
        robot = move_RA(robot,action, ahead);
        if (world(robot.position(1),robot.position(2)) == 1)
            population(x).f = population(x).f + 1;
            world(robot.position(1),robot.position(2)) = 0;
        end
    end
end


end

