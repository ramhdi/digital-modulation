% bfskdemod.m
% Demodulator BFSK
% ramhdi 06/04/2020

function [bit_out, mix1, mix2, iad1, iad2, iad] = bfskdemod(xr, fc1, fc2, Rb, oversamp)
  % demodulator menggunakan integrate-and-dump
  n = 0:1:(length(xr)-1); % sampel ke-n
  fsamp = Rb*oversamp; % frekuensi sampling
  N = length(xr)/oversamp; % jumlah bit
  c1 = sqrt(2*Rb)*cos(2*pi*fc1*n/fsamp); % fungsi basis dari c1(n) carrier bit 0
  c2 = sqrt(2*Rb)*cos(2*pi*fc2*n/fsamp); % fungsi basis dari c2(n) carrier bit 1
  mix1 = xr.*c1; % mixer 1
  mix2 = xr.*c2; % mixer 2
  
  % integrate-and-dump
  mix11 = reshape(mix1,[oversamp N])'; % mencacah mix menjadi matriks, untuk diintegral satu2
  mix111 = zeros(size(mix11));

  % integrate-and-dump
  mix22 = reshape(mix2,[oversamp N])'; % mencacah mix menjadi matriks, untuk diintegral satu2
  mix222 = zeros(size(mix22));

  % fungsi transfer integrator
  b_int = [0 1/fsamp]; a_int = [1 -1];
  for i=1:1:N
    mix111(i,:) = filter(b_int,a_int,mix11(i,:)); % integrator
    mix222(i,:) = filter(b_int,a_int,mix22(i,:)); % integrator
  endfor

  iad1 = reshape(mix111',[1 N*oversamp]); % menyusun kembali hasil integrate-and-dump
  iad2 = reshape(mix222',[1 N*oversamp]);
  iad = iad2 - iad1;
  bit_out = iad(oversamp:oversamp:end) > 0; % sampling bit keluaran
endfunction
