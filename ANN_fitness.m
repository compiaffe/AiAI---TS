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
    
    
    %     current_ahead = [0 0 0;
    %         0 0 0;
    %         0 0 0];  % [xleft yleft track?; xcenter ycenter track?; xright  ...]
         sensor_reading = [-1 1 -1];
    
    
    neuron = ANN_load(neuron,population(x).g); %load the evolved weights
    synaps_input = zeros(1,numel(neuron)); % initialise the input values to the synaps.
    
    
    %starting on track?
    if(world(robot.position(1),robot.position(2)) == 1)
        population(x).f = population(x).f + 1;
        world(robot.position(1),robot.position(2)) = 0;
    end
    
    
    for day = 1:35
        
        [sensor_reading current_ahead] = read_sensor_RA(world,robot, sensor_reading);
        
        %% ANN to calculate the next behaviour
        [action synaps_input] = ANN_fire(neuron, sensor_reading, action, synaps_input);
        
        %%move the robot
        robot = move_RA(robot, action, current_ahead);
        
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
end
end

