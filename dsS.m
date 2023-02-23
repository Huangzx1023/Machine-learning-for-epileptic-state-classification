function [out] = dsS(in, newCo)
[~,lie]=size(in);

% out=[];
% for i=1:10
%     [temp,~]=dividerand(in(:,(i-1)*floor(lie/10)+1:i*floor(lie/10)),newCo/lie,1-newCo/lie,0);
%     out=[out temp];
% end

[out,~]=dividerand(in,newCo/lie,1-newCo/lie,0);
end
