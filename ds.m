function [out] = ds(in, newCo)
[~,lie]=size(in);

% a=floor(lie*rand());
% if a+newCo>=lie
%     out=in(:,lie-newCo+1:lie);
% else
%     out=in(:,a+1:a+newCo);

[out,~]=dividerand(in,newCo/lie,1-newCo/lie,0);
end

