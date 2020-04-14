% ber_modulasi_bask.m
% Menghitung BER dari modulasi BASK melalui GNU Octave
% ramhdi 09/04/2020
pkg load communications
clear;

fc = 2e2; % carrier
Rb = 1e2; % bitrate
oversamp=8; % minimum oversamp = 4fc/Rb
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
  ber_theo(iter_snr) = qfunc(sqrt((10^(SNR(iter_snr)/10))/2));
  n_iter = min(1e4,2*ceil((1/ber_theo(iter_snr))/(N^2))*N)
  Noe = 0; Nod = 0;
  fprintf('SNR = %d\n', SNR(iter_snr));
  for iter_n = 1:1:n_iter
    bit_in = randn(1,N)>0;
    Nod = Nod + length(bit_in);
    [xt,bit_expand,n] = baskmod(bit_in, fc, Rb, oversamp);
    noise =  sqrt(fsamp*0.5*10^(-SNR(iter_snr)/10))*randn(1,length(xt));
    xr = xt + noise; %xr = awgn(xt, SNR(iter_snr),'measured');
    [bit_out,mix,iad] = baskdemod(xr, fc, Rb, oversamp);
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
%dlmwrite('ber_bask.csv', hasil);