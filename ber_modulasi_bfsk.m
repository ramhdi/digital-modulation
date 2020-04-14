% ber_modulasi_bfsk.m
% Menghitung BER dari modulasi BFSK melalui GNU Octave
% ramhdi 09/04/2020
pkg load communications
clear;
% syarat ortogonal: fc2-fc1 = Rb
fc1 = 2e2; % carrier 1
fc2 = 3e2; % carrier 2
Rb = 1e2; % bitrate
oversamp=12; % minimum oversamp = 4fc2/Rb
N = 100;

fsamp = Rb*oversamp;
Ts = 1/fsamp;

SNR = 0:5:20;
ber = zeros(1,length(SNR));
ber_theo = zeros(1,length(SNR));
%n_iter = 500;

for iter_snr = 1:1:length(SNR)
  if SNR(iter_snr)
  endif
  ber_theo(iter_snr) = qfunc(sqrt(10^(SNR(iter_snr)/10)));
  n_iter = min(1e4,2*ceil((1/ber_theo(iter_snr))/(N^2))*N)
  Noe = 0; Nod = 0;
  fprintf('SNR = %d\n', SNR(iter_snr));
  for iter_n = 1:1:n_iter
    bit_in = randn(1,N)>0;
    Nod = Nod + length(bit_in);
    [xt,bit_expand,n] = bfskmod(bit_in, fc1, fc2, Rb, oversamp);
    noise =  sqrt(fsamp*0.5*10^(-SNR(iter_snr)/10))*randn(1,length(xt));%noise = zeros(1,length(xt));
    xr = xt + noise; %xr = awgn(xt, SNR(iter_snr),'measured');
    [bit_out, mix1, mix2, iad1, iad2, iad] = bfskdemod(xr, fc1, fc2, Rb, oversamp);
    Noe = Noe + sum(bit_in ~= bit_out); fprintf('.');
  endfor
  fprintf('\n');
  ber(iter_snr) = Noe/Nod;
  fprintf('BER = %d\n', ber(iter_snr));
  fprintf('BER_theo = %d\n', ber_theo(iter_snr));
endfor

figure;
semilogy(SNR, ber, SNR, ber_theo);
%hasil = [SNR' ber' ber_theo']
%dlmwrite('ber_bfsk.csv', hasil);