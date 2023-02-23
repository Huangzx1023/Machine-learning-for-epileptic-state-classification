function [out] = fuli(in,outnumber)
N=1024;
[~,n]=size(in);
out=zeros(512,n);
for i=1:n
y=in(:,i);
x=fft(y,N);
m=abs(x);
out(:,i)=m(1:N/2);
end
out=out(1:outnumber,:);
end

