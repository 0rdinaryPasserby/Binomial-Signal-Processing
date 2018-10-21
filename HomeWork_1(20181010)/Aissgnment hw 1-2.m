
% MATLAB PROGRAM ecg_hfn.m



clear all               % clears all active variables
close all
for m=1:1:12;
ecg = load('ecg_hfn.dat');
fs = 1000; %sampling rate = 1000 Hz
s=size(ecg);
downsize=8;
n=length(ecg);
head=80/downsize;
tail=(n-head)/(12 * downsize);
OverlapN=m;

section=tail-head;
ecg5(1,1)=ecg(1,1);

for i=downsize+1:downsize:n
ecg5((i-1)/downsize,1)=ecg(i,1);
end
ecg2(: ,1)=ecg5(head:tail,1);
n=length(ecg5);
[c lag]=xcorr(ecg5,ecg2);
c=c/max(c);
lag1=lag(n:2*n-1);
c1=c(n:2*n-1);


j=0;
ma_x=0;
ma_x2=0;
temp2=0;
k=0;

threshhold=0.6;

for i=1:1:n;
if (c1(i,1)>threshhold);
    k=k+1;
    temp(k,1)=c1(i,1);
    temp(k,2)=i;
   temp2=1 ;
 end;

if (temp2==1) && ( c1(i,1)<threshhold)
 j=j+1;
[M I]= max(temp(:,1));
Save(j,1)=temp(I,2);
Save(j,2)=M;
 temp2=0;
 temp=0;
end 
    
end;


slen = length(ecg2);
slen2 = length(ecg5);
corro=c1(Save(1,1),1);
delay=lag1(Save(1,1));
Temp=delay ;
ecg3=ecg5(Temp:Temp+slen-1,1);


for i=2:1:OverlapN;
corro=c1(Save(i,1),1);
delay=lag1(Save(i,1));
Temp=delay ;
ecg4=ecg5(Temp:Temp+slen-1,1);

ecg3=ecg3+ecg4;
end

ecg3=ecg3/OverlapN;



slen3=length(ecg);
t=[1:slen3]/(fs/downsize);

   
filename=sprintf('D8OneCardCycle%d.png',m);
titlename=sprintf('%d Cycle Average',m);
slen2 = length(ecg3);
t2=[1:slen2]/(fs/downsize);
fig=figure('position', [0, 0, 1000, 300]);
plot(t2, ecg3);
axis([0 0.543 -2.1 2.9]);
title(titlename);
xlabel('Time in seconds');
ylabel('Average One Cardiac Cycle');
saveas(fig,filename);
vars={'ecg3','fig','ecg','ecg5','c','c1'};
clear (vars{:})
end


