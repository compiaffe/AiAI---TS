function [ neuron ] = ANN_connection_setup(ANN_map)
%ANN_CONNECTION_SETUP set up the ANN structure
%   It takes the ANN_map generated elsewhere and implements the neurons and
%   their synapses as an array of struct. It also initialises the weights
%   and threshold randomly



init_synapses = 1; %change this maybe to prevent on the fly resizing of array...
num_neurons = length(ANN_map);

neuron(1:num_neurons) = struct('synapses',{zeros(1,init_synapses)},'weights',{zeros(1,init_synapses)},'threshold',0,'firepower',1);
for x = 1:num_neurons
    z = 1;
    for y = 1:num_neurons
        if ANN_map(x,y) == 1
            neuron(x).synapses(z) = y;
            neuron(x).weights(z) = rand(1); %set initial weight randomly
            z = z+1;%write next synaps
        end
    end
        neuron(x).threshold = (rand(1)* numel(neuron(x).synapses)); %set initial threshold randomly between 0 and num. of elements

end
end
