function [ y ] = perceptron_out(W_in,W_out,inputs,beta)
   X=[]; 
   for i=1:length(inputs(:,1))
       x_aux=[inputs(i,:) 1]';
       X=[X x_aux];
   end

   out_hidden_layer =tanh( beta*W_in*X);               
   y = tanh(beta*W_out*[out_hidden_layer;1 1 1 1])';
end

