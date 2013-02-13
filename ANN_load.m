function [ neuron ] = ANN_load(neuron,weights)
%ANN_LOAD_FIRE Takes the prebuild neural network and loads the current weights
%   The weights have the format: weights = [threshold1 w1 w2 w3 ... wn threshold2 w1 w2 w3 ...]
weight_pos = 1;
for x = 1:numel(neuron)
    neuron(x).threshold = weights(weight_pos);
    weight_pos = weight_pos + 1;
    
    for y = 1:numel(neuron(x).weights)
        neuron(x).weight(y) = weights(weight_pos):
        weight_pos = weight_pos + 1;
    end
end
end

