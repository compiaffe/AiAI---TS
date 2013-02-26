function [ neuron ] = ANN_load(neuron,weights,ahead)
%ANN_LOAD_FIRE Takes the prebuild neural network and loads the current weights
%   The weights have the format: weights = [threshold1 w1 w2 w3 ... wn threshold2 w1 w2 w3 ...]

weight_pos = 1;
for x = 1:numel(neuron) %for all neurons
    neuron(x).threshold = weights(weight_pos); %set the threshold
    weight_pos = weight_pos + 1; %look at the next position in the array
   
    if x <= length(ahead) % set the input nodes at 0.5 threshold - maybe change later!!!!!!
        neuron(x).threshold = 0.5;
    end
    
    
    if neuron(x).synapses(1) ~= 0 %unless its a final node
        for y = 1:numel(neuron(x).synapses)%for all synapses at the neuron
            neuron(x).weights(y) = weights(weight_pos); %update the weights from the GA
            weight_pos = weight_pos + 1;
        end
    end
end
end

