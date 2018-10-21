% MATLAB PROGRAM ecg_hfn.m
clear all               % clears all active variables
close all

ecg = load('ecg_hfn.dat');
fs = 1000 ;
s= size(ecg);
n = length(ecg);
% It seem like 12 cycles in ECG , So I decides head = 0 ,  tail = (ecg.row- head) / 12 ;  
head = 80;
tail = (n - head) / 12 ; 
section = tail - head ;
ecg2(: , 1) = ecg(head:tail,1);
% count the lag in ecg2 between ecg ; 
[c lag] = xcorr(ecg2,ecg);
c = c / max(c);

lag1 = lag(1:n); 
c1 = c(1:n);
plot(-lag1/fs ,c1);   % lag/fs = t ; 
axis tight 
xlabel('Time in seconds');
ylabel('Correlation');
grid
