%Лабораторная 4 Вариант 3
%Реализовать синтаксический анализатор арифметического выражения и вычислить его числовое значение.
%В выражении допустимы операции + - * / степень ^.
%Учитывать приоритеты операций.

% запрос: ?- calculate([5, '+', 3, '^', 2], X).
% результат: X=14

pow(_,0,1):-!.
    pow(X,Y,Z):-
            Y>0, YY is Y-1,
            pow(X,YY,ZZ), Z is ZZ*X,!;
            YY is Y+1,
            pow(X,YY,ZZ), Z is ZZ/X,!.    
    
  
expr(Y) --> slag(Y1),[+], expr(Y2) , {Y is Y1 + Y2}.
expr(Y) --> slag(Y1), [-], expr(Y2) , {Y is Y1 - Y2}.
expr(Y) --> slag(Y).

slag(Y) --> mnojitel(Y1), [*], slag(Y2), {Y is Y1 * Y2}.
slag(Y) --> mnojitel(Y1), [/], slag(Y2), {Y is Y1 / Y2}.
slag(Y) --> mnojitel(Y).

slag(Y) --> ['('], expr(Y1), [')', *], slag(Y2), {Y is Y1 * Y2}.
slag(Y) --> ['('], expr(Y1), [')', /], slag(Y2), {Y is Y1 / Y2}.
slag(Y) --> ['('], expr(Y1), [')', ^], slag(Y2), {pow(Y1, Y2, Y)}.
slag(Y) --> ['('], expr(Y),[')'].

mnojitel(Y) --> power(Y1), [^] , mnojitel(Y2), {pow(Y1, Y2, Y)}. 
mnojitel(Y) --> power(Y).

power(Y) --> num(Y).
num(D) --> [D], {number(D)}.
calculate(L, V) :- expr(V, L, []).

