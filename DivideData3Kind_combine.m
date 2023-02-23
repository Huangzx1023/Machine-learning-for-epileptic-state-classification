function [W,lable] = DivideData3Kind_combine(WS,WC,WP)

W.C=WC;
W.P=WP;
W.S=WS;
tag={'C','P','S'};

    for j=1:3
        eval(['[~,',tag{j},']=size(W.',tag{j},');']);
    end
    eval(['lable=[zeros(1,C) ones(1,P) 2*ones(1,S)];'])


W=struct2array(W);
end

