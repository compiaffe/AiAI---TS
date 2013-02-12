function [ output ] = ANN_fire( neuron )
%ANN_FIRE evaluate the neural network
%   check all neurons. If their threshold is reached fire, apply weights
%   and save the output in the corresponding neurons. It assumes a network
%   where neurons are activated or deactivated, but their firepower is
%   constant before the weight is applied.

output_counter = 1;
for x = 1:numel(neuron)
    if numel(neuron(x).synapses) == 0 %if we are at a visible final neuron
        output(output_counter) = neuron(x).firepower;
        output_counter = output_counter + 1;
    else
        if neuron(x).input >= neuron(x).threshold; %if we are triggered
            for y = 1:numel(neuron(x).synapses)%calculate weighted spikes
                neuron(neuron(x).synapses(y)) = neuron(neuron(x).synapses(y)) + (neuron(x).weights(y)*neuron(x).firepower); %update and sum the output
            end
        end
        
    end
end




end

