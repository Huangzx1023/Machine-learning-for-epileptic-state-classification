function [out] = fuli1024(in)
N=1024;
[~,n]=size(in);
out=zeros(1024,n);
for i=1:n
y=in(:,i);
x=fft(y,N);%
m=abs(x);
out(:,i)=m(1:N);
end

end

