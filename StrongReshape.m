function [NewMatrix] = StrongReshape(A,RowNumber)
base=length(A);
ColunmNumber=floor(base/RowNumber);
NewMatrix=reshape(A(1:RowNumber*ColunmNumber),[RowNumber,ColunmNumber]);
end

