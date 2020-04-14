% diffencode.m
% Differential encoding untuk bit DPSK
% ramhdi 08/04/2020

function bit_encoded = diffencode(bit_in)
  bit_encoded = zeros(1,length(bit_in)+1); % panjang = bit masukan + 1
  bit_encoded(1) = 1; % bit referensi
  
  for iter = 1:1:length(bit_in)
    bit_encoded(iter+1) = bit_in(iter) ~= bit_encoded(iter);
  endfor
endfunction
