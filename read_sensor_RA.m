function [ ahead ] = read_sensor_RA( world,position, heading )
%READ_SENSOR_RA read the sensor of our Assignment robot
%   Detailed explanation goes here
north = 0;
east = 1;
south = 2;
west = 3;

if (heading == north)
    if(position(1) == 1)
        ahead = [position(1)]
    end
    
end


if (position == east)
end


if (position == south)
end


if (position == west)
end



end
