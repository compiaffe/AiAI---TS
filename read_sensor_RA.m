function [ sensor_out ahead] = read_sensor_RA( world,robot, sensor_out )
%READ_SENSOR_RA read the sensor of our Assignment robot
% takes the current position and orientation to find the 3 sensor readings
% ahead.
north = 0;
east = 1;
south = 2;
west = 3;
ahead = zeros(3,3);

if (robot.heading == north)
    ahead = [robot.position(1)-1      robot.position(2)-1       0;
        robot.position(1)-1       robot.position(2)         0;
        robot.position(1)-1       robot.position(1)+1       0];
end

if (robot.heading == east)
    ahead = [robot.position(1)-1      robot.position(2)+1       0;
        robot.position(1)        robot.position(2)+1        0;
        robot.position(1)+1     robot.position(2)+1        0];
    
end


if (robot.heading == south)
    ahead = [robot.position(1)+1      robot.position(2)+1       0;
        robot.position(1)+1      robot.position(2)          0;
        robot.position(1)+1      robot.position(2)-1        0];
    
end


if (robot.heading == west)
    ahead = [robot.position(1)+1      robot.position(2)-1       0;
        robot.position(1)        robot.position(2)-1        0;
        robot.position(2)-1      robot.position(1)-1        0];
end

for x = 1:3 %%check for edge wrapping
    for y = 1:2
        if (ahead(x,y) < 1)
            ahead(x,y) = 8;
        end
        if (ahead(x,y) > 8)
            ahead(x,y) = 1;
        end
    end
end
for x = 1:3 %%memory of the last sensor measurement
    sensor_out(x+3) = sensor_out(x);
end


for x = 1:3 %%
    if world(ahead(x,1),ahead(x,2)) == 1
    ahead(x,3) = 1;
    sensor_out(x) = 1;

    else
    ahead(x,3) = -1;  
    sensor_out(x) = -1;

    end
    
end


end

