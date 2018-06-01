function [ W1po , W2po ] = ucz2 ( W1przed , W2przed , Pucz , Tucz,...
                                  maxLiczbaEpok, liczbaPokazow,...
                                  czestoscWykresow, docelowyBladMSE,...
                                  wspUcz, wspMom)
                              
                              
    liczbaPrzykladow = size(Pucz,2);
    W1 = W1przed;
    W2 = W2przed;
  
    for i = 1 : maxLiczbaEpok,
       W1prev = W1;
       W2prev = W2;
       for j=2:size(W1prev, 2),
        W1prev(j) = W1prev(j-1);
       end
       for j=2:size(W2prev, 2),
        W2prev(j) = W2prev(j-1);
       end
       nrPrzykladu = ceil(rand(1)*liczbaPrzykladow);
       X = Pucz(:,nrPrzykladu);
       X1 = [ -1 ; X];
       [Y1 , Y2 ] = dzialaj2(W1, W2, X);
       X2 = [ -1; Y1 ];
       D2 = Tucz(:,nrPrzykladu)-Y2;
       E2 = D2.*5.*Y2.*(1-Y2);
       D1 = W2(2:end, :)*D2;
       E1 = D1.*5.*Y1.*(1-Y1);
       dW1 = wspUcz*X1*E1'+ wspMom*(W1-W1prev);                      
       dW2 = wspUcz*X2*E2'+ wspMom*(W2-W2prev);  
       W1 = W1+dW1;      
       W2 = W2+dW2; 
    end
    W1po = W1;
    W2po = W2;
end
 
% ucz2 - rysowanie b³êdu œredniokwadratowego
% do ucz2 dodaj
% m - maksymalna liczba krokow uczenia
% e - blad ktory siec ma osiagnac
% - siec bedzie sie uczyc do osiagniecia bledu, ale nie dluzej niz
% - maksymalna liczba krokow
% k - liczba pokazow w kroku
% - liczba przykladow pokazywanych w jednym kroku uczenia