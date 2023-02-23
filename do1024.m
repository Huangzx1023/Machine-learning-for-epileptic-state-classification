function [out] = do1024(in,RowNumber,OverlopNumber)
if RowNumber>length(in)
    error("RowNumber过大或OverlopTag输入参数过小，无法提取出样本")
end
if RowNumber<OverlopNumber
    error("OverlopNumber不应大于RowNumber")
end
index=1;
n=length(in);
while index-OverlopNumber+RowNumber<n
    if index==1
       out=[];
       out(1:RowNumber,1)=in(1:RowNumber);
       index=RowNumber;
    else
        out=[out,in(index-OverlopNumber+1:index-OverlopNumber+RowNumber)];
        index=index-OverlopNumber+RowNumber;
    end
end


% [base,~]=size(in);
% time=((RowNumber/OverlopNumber)+1)/2;
% out=zeros(RowNumber,floor(base/RowNumber*(time)));
% for i=1:floor(base/RowNumber*(time))
% %     fprintf("%d\n",i);
% %     fprintf("%d\n",512*(i-1)+RowNumber);
%     out(:,i)=in(OverlopNumber*(i-1)+1:OverlopNumber*(i-1)+RowNumber);
% end
end

