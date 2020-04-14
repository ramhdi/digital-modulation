% ber_modulasi.m
% Menghitung BER dari berbagai modulasi digital melalui GNU Octave
% ramhdi 14/04/2020

dat_bask = dlmread('ber_bask.csv');
dat_bfsk = dlmread('ber_bfsk.csv');
dat_bpsk = dlmread('ber_bpsk.csv');
dat_dpsk = dlmread('ber_dpsk.csv');

SNR = dat_bask(:,1)';
SNR_theo = 0:2:20;
ber_bask_sim = dat_bask(:,2)'; ber_bask_theo = qfunc(sqrt((10.^(SNR_theo/10))/2));
ber_bfsk_sim = dat_bfsk(:,2)'; ber_bfsk_theo = qfunc(sqrt(10.^(SNR_theo/10)));
ber_bpsk_sim = dat_bpsk(:,2)'; ber_bpsk_theo = qfunc(sqrt(2*(10.^(SNR_theo/10))));
ber_dpsk_sim = dat_dpsk(:,2)'; ber_dpsk_theo = 0.5*exp(-10.^(SNR_theo/10));

figure;hold on;
semilogy(SNR_theo, ber_bask_theo, 'g');
semilogy(SNR, ber_bask_sim, '--*g');
semilogy(SNR_theo, ber_bfsk_theo, 'b');
semilogy(SNR, ber_bfsk_sim, '--*b');
semilogy(SNR_theo, ber_bpsk_theo, 'r');
semilogy(SNR, ber_bpsk_sim, '--*r');
semilogy(SNR_theo, ber_dpsk_theo, 'm');
semilogy(SNR, ber_dpsk_sim, '--*m');
hold off;
axis([0 20 1e-6 1]);
title('BER vs E_b/N_0 in various digital modulations under AWGN');
xlabel('E_b/N_0 (dB)'); ylabel('BER');
legend([...
'Coherent BASK (theoretical)';'Coherent BASK (simulated)';...
'Coherent BFSK (theoretical)';'Coherent BFSK (simulated)';...
'Coherent BPSK (theoretical)';'Coherent BPSK (simulated)';...
'Noncoherent DPSK (theoretical)';'Noncoherent DPSK (simulated)'...
]);
grid on;