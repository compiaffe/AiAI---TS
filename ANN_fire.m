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

%%  load the input nodes
for z = 1:length(ahead)
    synaps_input(z) = ahead(z,3); %load the current ahead values into the input nodes
end

%% run the ANN
for x = 1:numel(neuron) %for all neurons
    
    %% check for output nodes
    if neuron(x).synapses == 0 %if we are at a visible final neuron (no/synaps to 0)
        if synaps_input(x) >= neuron(x).threshold; %if we are triggered
            action(output_counter) = neuron(x).firepower;
        else
            action(output_counter) = 0;
            
        end
        output_counter = output_counter + 1;
        %% run the hidden layer
    else
        if synaps_input(x) >= neuron(x).threshold; %if we are triggered
            for y = 1:numel(neuron(x).synapses)%calculate weighted spikes
                synaps_input(neuron(x).synapses(y)) = synaps_input(neuron(x).synapses(y)) + (neuron(x).weights(y)*neuron(x).firepower); %update and sum the output
            end
        end
        
    end
end




end

