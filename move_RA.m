function [ robot] = move_RA( robot, action, ahead )
%MOVE_RA moves the robot according to the actions
%   Detailed explanation goes here
if action == 0
    
end

if action == 1; %turning right on spot
    robot.heading = robot.heading+1;
    if robot.heading > 3
        robot.heading = 0;
    end
    
end

if action == 2; %turning left on spot
    robot.heading = robot.heading-1;
    if robot.heading < 0
        robot.heading = 3;
    end
end

if action == 3; %going straight ahead
    robot.position(1) = ahead(2,1);
    robot.position(2) = ahead(2,2);
    
end

end

