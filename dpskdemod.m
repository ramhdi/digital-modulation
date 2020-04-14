% dpskdemod.m
% Demodulator DPSK
% ramhdi 08/04/2020

function [bit_out, mix, iad] = dpskdemod(xr, Rb, oversamp)
  fsamp = Rb*oversamp;
  % delay xr
  xr_delayed = [zeros(1,oversamp) xr];
  xr_padded = [xr zeros(1,oversamp)];
  mix = [-xr_padded.*xr_delayed](oversamp+1:1:length(xr));
  N = length(xr)/oversamp - 1; % jumlah bit sebelum encoded

  % integrate-and-dump
  demodd = reshape(mix,[oversamp N])'; % mencacah mix menjadi matriks, untuk diintegral satu2
  demoddd = zeros(size(demodd));

  % fungsi transfer integrator
  b_int = [0 1/fsamp]; a_int = [1 -1];
  for i=1:1:N
    demoddd(i,:) = filter(b_int,a_int,demodd(i,:)); % integrator
  endfor

  iad = reshape(demoddd',[1 N*oversamp]); % menyusun kembali hasil integrate-and-dump
  bit_out = iad(oversamp-1:oversamp:end) > 0; % sampling bit keluaran
endfunction
