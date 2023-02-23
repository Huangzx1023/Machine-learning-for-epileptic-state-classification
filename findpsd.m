function [out] = findpsd(in,outnumber)
fs=500;
nfft=1024;
[out,~]=pwelch(in,hanning(nfft),nfft/2,nfft,fs);
out=out(1:outnumber,:);
end