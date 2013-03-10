function [ neuron ] = ANN_load(neuron,weights)
%ANN_LOAD_FIRE Takes the prebuild neural network and loads the current weights
%   The weights have the format: weights = [threshold1 w1 w2 w3 ... wn threshold2 w1 w2 w3 ...]

bias_pos = 1;
for x = 1:numel(neuron) %for all neurons
    neuron(x).bias = weights(bias_pos); %set the bias
    bias_pos = bias_pos + 1; %look at the next position in the array
    
   % if x <= length(ahead) % set the input nodes bias to 0 - no bias
   %     neuron(x).bias = 0;
   % end
       
    if neuron(x).synapses(1) ~= 0 %unless its a final node
        for y = 1:numel(neuron(x).synapses)%for all synapses at the neuron
            neuron(x).weights(y) = weights(bias_pos); %update the weights from the GA
            bias_pos = bias_pos + 1;
        end
    end
end
end

