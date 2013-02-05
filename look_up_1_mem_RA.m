function [ action ] = look_up_1_mem_RA( individual, ahead, lastPosOcc )
%LOOK_UP_RA decodes the genome and outputs action 
%   the genome is a binary string bitmapping all 8 possible sensor
%   values(ahead) to one of 4 actions
%   stay = 0;
%   turn_right = 1;
%   turn_left = 2;
%   move_fwd = 3;

%Encode the binary sensor input possibilities to decimal to serve as the
%left column of our look up table
sensor_table_position = ahead(1,3)+(2*ahead(2,3))+(4*ahead(3,3))+(8*lastPosOcc); 
%Encode the binary string of our individuals genom in decimal from two
%non overlapping adjacent bits
action = 2*individual.g(1+(sensor_table_position))+individual.g(2+(sensor_table_position));

end
