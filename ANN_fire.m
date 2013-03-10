function [ action synaps_input] = ANN_fire( neuron, ahead, action, synaps_input )
%ANN_FIRE evaluate the neural network
%   check all neurons. If their threshold is reached fire, apply weights
%   and save the output in the corresponding neurons. It assumes a network
%   where neurons are activated or deactivated, but their firepower is
%   constant before the weight is applied.

output_counter = 1;
size_action = numel(action);

%%  load the input nodes
for z = 1:length(ahead)
    synaps_input(z) = synaps_input(z) + ahead(z,3); %add the current ahead values to the recursive values received from the hidden layer
    
end

%% run the ANN
for x = 1:numel(neuron) %for all neurons
    
    
    
    %% run the hidden layer
    if neuron(x).synapses(1) ~= 0 %if we have synapses...
        for y = 1:numel(neuron(x).synapses)% for all connected(receiving) neurons - calculate weighted spikes
            synaps_input( neuron(x).synapses(y) ) = synaps_input( neuron(x).synapses(y) ) + ( sigmf( (synaps_input(x)+neuron(x).bias),[1 1] ) * neuron(x).weights(y) );
        end
        
    end
    
    %% check for output nodes
    if x > (numel(neuron) - size_action); %if we are at a visible final neuron (number of neurons minus number of action bits)
        if (synaps_input(x)+ neuron(x).bias) >= 0; %if we are triggered
            action(output_counter) = 1;
        else
            action(output_counter) = 0;
        end
        output_counter = output_counter + 1;
        
    end
    synaps_input(x) = 0;
    
    
    
end




end

