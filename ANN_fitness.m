function [ population ] = ANN_fitness( population, popSize, neuron)
%ANN_FITNESS loads and fires the ANN for the allowed 35
%days.
%   Detailed explanation goes here


for x = 1:popSize
    population(x).f = 0;
    
    
    
    
    %% set up the world
    world = [
        0 0 0 0 0 0 0 0;
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
    action = [0 0]; %define the size of the action array we need
    
    
    %starting position and heading
    robot.position = [2,1];
    robot.heading = east;
    robot.currentPos = 1;
    
    current_ahead = [0 0 0;
        0 0 0;
        0 0 0];  % [xleft yleft track?; xcenter ycenter track?; xright  ...]
    
    
    neuron = ANN_load(neuron,population(x).g,current_ahead); %load the evolved weights
    
    
    %starting on track?
    if (world(robot.position(1),robot.position(2)) == 1)
        population(x).f = population(x).f + 1;
        world(robot.position(1),robot.position(2)) = 0;
    end
    
    for day = 1:35
        
        current_ahead = read_sensor_RA(world,robot);
        
        %% ANN to calculate the next behaviour
        action = ANN_fire(neuron, current_ahead,action);
        
        %%move the robot
        robot = move_RA(robot,action, current_ahead);
        
        %%the last position
        
        %% update fitness & map
        if (world(robot.position(1),robot.position(2)) == 1)
            population(x).f = population(x).f + 1;
            world(robot.position(1),robot.position(2)) = 0;
            robot.lastPos = robot.currentPos;
            robot.currentPos = 1;
            
        else
            robot.lastPos = robot.currentPos;
            
            robot.currentPos = 0;
        end
    end
    clear synaps_input; %reset the synapses input !!!!! CHECK IF THIS WORKS!!!!
end
end

