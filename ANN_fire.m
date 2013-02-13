function [ action ] = ANN_fire( neuron, ahead )
%ANN_FIRE evaluate the neural network
%   check all neurons. If their threshold is reached fire, apply weights
%   and save the output in the corresponding neurons. It assumes a network
%   where neurons are activated or deactivated, but their firepower is
%   constant before the weight is applied.

output_counter = 1;
persistent synaps_input;
if isempty(synaps_input)
    synaps_input = zeros(1,numel(neuron));
end

for z = 1:length(ahead)
    synaps_input(z) = ahead(z,3); %load the current ahead values into the input nodes
end

for x = 1:numel(neuron)
    if numel(neuron(x).synapses) == 0 %if we are at a visible final neuron
        action(output_counter) = neuron(x).firepower;
        output_counter = output_counter + 1;
    else
        if synaps_input(x) >= neuron(x).threshold; %if we are triggered
            for y = 1:numel(neuron(x).synapses)%calculate weighted spikes
                synaps_input(neuron(x).synapses(y)) = synaps_input(neuron(x).synapses(y)) + (neuron(x).weights(y)*neuron(x).firepower); %update and sum the output
            end
        end
        
    end
end




end

