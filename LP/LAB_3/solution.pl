%Лабораторная 3 Вариант 5
%Вдоль доски расположено 7 лунок, в которых лежат 3 черных и 3 белых шара.
%Передвинуть черные шары на место белых, а белые - на место черных.
%Шар можно передвинуть в соседнюю с ним пустую лунку, 
%либо в пустую лунку, находящуюся непосредсвенно за ближайшим шаром.

append([], List2, List2).
append([Head|Tail], List2, [Head|TailResult]):-append(Tail, List2, TailResult).
 
% переходы между состояниями
move(A,B):-
    append(Head,['_','w'|Tail],A),
    append(Head,['w','_'|Tail],B).
    
move(A,B):-
    append(Head,['b','_'|Tail],A),
    append(Head,['_','b'|Tail],B).

move(A,B):-
    append(Head,['_','b','w'|Tail],A),
    append(Head,['w','b','_'|Tail],B).

move(A,B):-
    append(Head,['b','w','_'|Tail],A),
    append(Head,['_','w','b'|Tail],B).

prolong([Temp|Tail],[New,Temp|Tail]):- 
    move(Temp,New),not(member(New,[Temp|Tail])). 
    
show_res([_]). 
show_res([B|Tail]):-show_res(Tail),nl,write(B).	   

%Поиск в глубину:
dsearch(Start, Finish):-
	nl,write('DEPTH-FIRST SEARCH START'),
	get_time(DFS),
	bdth([[Start]], Finish, Way), show_res(Way),
	get_time(DFS1),
    nl,write('DEPTH-FIRST SEARCH END'),nl,
    T1 is DFS1 - DFS,
	write('TIME IS '),write(T1),nl.

dpth([[Finish|Tail]|_],Finish,[Finish|Tail]).

dpth(TempWay,Finish,Way):-
    prolong(TempWay,NewWay),dpth(NewWay,Finish,Way).

%Поиск в ширину:

bsearch(Start,Finish):-
	nl,write('BREADTH-FIRST SEARCH START'),
	get_time(BFS),
	bdth([[Start]],Finish,Way),show_res(Way),
	get_time(BFS1),
    nl,write('BREADTH-FIRST SEARCH END'),nl,
    T1 is BFS1 - BFS,
	write('TIME IS '),write(T1),nl.

bdth([[Finish|Tail]|_],Finish,[Finish|Tail]).

bdth([TempWay|OtherWays],Finish,Way):- 
    findall(W,prolong(TempWay,W),Ways), 
    append(OtherWays,Ways,NewWays), 
    bdth(NewWays,Finish,Way).

%Поиск c итерационным углублением:

int(1).
int(N):-int(M),N is M+1.
isearch(Start,Finish):-
	nl,write('ITER SEARCH START'),
	get_time(ITER),
    int(Level),
    depth_id([Start],Finish,Way,Level),show_res(Way),
    get_time(ITER1),
    nl,write('ITER SEARCH END'),nl,
    T1 is ITER1 - ITER,
	write('TIME IS '),write(T1),nl.

depth_id([Finish|Tail],Finish,[Finish|Tail],0).

depth_id(TempWay,Finish,Way,N):-
    N>0,
    prolong(TempWay,NewWay),
    N1 is N-1,
    depth_id(NewWay,Finish,Way,N1).

% вопросы/запросы
% ?- dsearch(['b','b','b','_','w','w','w'],['w','w','w','_','b','b','b']).
% ?- bsearch(['b','b','b','_','w','w','w'],['w','w','w','_','b','b','b']).
% ?- isearch(['b','b','b','_','w','w','w'],['w','w','w','_','b','b','b']).
% ?- halt.
