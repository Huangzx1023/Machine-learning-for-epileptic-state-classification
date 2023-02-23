function [out] = charac(Con,Pre10,Pre30,Ser)
[~,base]=size(Ser);
out=zeros(3,9*base);
out(1,1:4*base)=mean(Con);
out(1,4*base+1:6*base)=mean(Pre10);
out(1,6*base+1:8*base)=mean(Pre30);
out(1,8*base+1:9*base)=mean(Ser);

temp=Con.^2;
out(2,1:4*base)=mean(temp);
temp=Pre10.^2;
out(2,4*base+1:6*base)=mean(temp);
temp=Pre30.^2;
out(2,6*base+1:8*base)=mean(temp);
temp=Ser.^2;
out(2,8*base+1:9*base)=mean(temp);

out(3,:)=sqrt(out(2,:));
end

