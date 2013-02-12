function [ neuron ] = ANN_load(neuron,weights )
%ANN_LOAD_FIRE Takes the prebuild neural network and loads the current weights
%   Detailed explanation goes here
weight_pos = 1;
for x = 1:numel(neuron)
    
    for y = 1:numel(neuron(x).weights)
        neuron(x).weight(y) = weights(weight_pos):
        weight_pos = weight_pos + 1;
    end
end
end

