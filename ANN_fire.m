function [ action ] = ANN_fire( neuron, ahead, action )
%ANN_FIRE evaluate the neural network
%   check all neurons. If their threshold is reached fire, apply weights
%   and save the output in the corresponding neurons. It assumes a network
%   where neurons are activated or deactivated, but their firepower is
%   constant before the weight is applied.

output_counter = 1;
%persistent synaps_input;
synaps_input = zeros(1,numel(neuron));
if isempty(synaps_input)
    synaps_input = zeros(1,numel(neuron));
end
size_action = numel(action);

%%  load the input nodes
for z = 1:length(ahead)
    synaps_input(z) = ahead(z,3); %load the current ahead values into the input nodes
    neuron(z).input_num = 1; % every input node has one input
    
end

%% run the ANN
for x = 1:numel(neuron) %for all neurons
    
    
    
    %% check for output nodes
    if x > (numel(neuron) - size_action); %if we are at a visible final neuron (number of neurons minus number of action bits)
        if (synaps_input(x)+ neuron(x).bias) >= 0; %if we are triggered
            action(output_counter) = 1;
        else
            action(output_counter) = 0;
        end
        output_counter = output_counter + 1;
    end
    
    
    
    %% run the hidden layer
    if neuron(x).synapses(1) ~= 0 %if we have synapses...- not at the output nodes
        for y = 1:numel(neuron(x).synapses)% for all connected(receiving) neurons - calculate weighted spikes
       synaps_input( neuron(x).synapses(y) ) = synaps_input( neuron(x).synapses(y) ) + ( sigmf( (synaps_input(x)+neuron(x).bias),[1 1] ) * neuron(x).weights(y) );
        end
        
        %         if synaps_input(x) > (neuron(x).threshold*neuron(x).input_num); %if we are triggered
        %             synaps_input(x) = 0;
        %             for y = 1:numel(neuron(x).synapses)% for all connected(receiving) neurons - calculate weighted spikes
        %                 synaps_input(neuron(x).synapses(y)) = synaps_input(neuron(x).synapses(y)) + (neuron(x).weights(y)*neuron(x).firepower); %update and sum the output
        %             end
        %         else
        %             synaps_input(x) = 0;
        %
        %         end
    end
    
    
end




end

