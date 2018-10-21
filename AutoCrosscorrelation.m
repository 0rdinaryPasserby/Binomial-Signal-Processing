%%  Problem 1 -1 
% Show the ACF og the 4.2-4.96s segments of f3 and o1 channels 
clear all 
close all

eeg1_f3 = load('eeg1-f3.dat');
eeg1_o1 = load('eeg1-o1.dat');

fs = 100;  

segment_head = 4.2 * fs ; 
segment_tail = 4.96 * fs;
eegf3segments=eeg1_f3(segment_head:segment_tail,1);
atf_eeg1_f3 = autocorr(eegf3segments,40);
t_f3 = (1:length(atf_eeg1_f3))/fs;

segment_head = 4.2 * fs ; 
segment_tail = 4.96 * fs;
eego1segments=eeg1_o1(segment_head:segment_tail,1);
atf_eeg1_o1 = autocorr(eego1segments,40);
t_o1 = (1:length(atf_eeg1_o1))/fs;

figure(1);
subplot(2,1,1);
plot(t_f3,atf_eeg1_f3);
xlabel('Time Delay');
title('eeg1-f3');
axis tight; 
subplot(2,1,2);
plot(t_o1,atf_eeg1_o1);
axis tight; 
xlabel('Time Delay');
title('eeg1-o1');
print('ACF', '-dpng', '-r600');
%% Problem 1-2  and 1-3 

clear all 


eeg1_o1 = load('eeg1-o1.dat');
eeg1_o2 = load('eeg1-o2.dat');
eeg1_f3 = load('eeg1-f3.dat');

fs = 100 ;
cor_head = 4.72 * fs; 
cor_tail = 5.71 * fs; 

eeg_o1_segment = eeg1_o1(cor_head:cor_tail,1); 
eeg_o2_segment = eeg1_o2(cor_head:cor_tail,1); 
eeg_f3_segment = eeg1_f3(cor_head:cor_tail,1); 

cor_o1_o2 = crosscorr(eeg_o1_segment,eeg_o2_segment,25);
cor_o1_f3 = crosscorr(eeg_o1_segment,eeg_f3_segment,25);

t_o1_o2 =  (1:length(cor_o1_o2))/fs;
t_o1_f3 =  (1:length(cor_o1_f3))/fs;

figure(2);
subplot(2,1,1);
plot(t_o1_o2,cor_o1_o2);
xlabel('Time Delay');
title('Crosscorrelation of o1 and o2 ');
axis tight; 
subplot(2,1,2);
plot(t_o1_f3,cor_o1_f3);
axis tight; 
xlabel('Time Delay');
title(' Crosscorrelation of o1 and f3');
print('crosscor o1 vs f3 and o2', '-dpng', '-r600');
