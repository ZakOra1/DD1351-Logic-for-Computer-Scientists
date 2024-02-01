append([],L,L).
append([H|T],L,[H|R]) :- append(T,L,R).

appendEl(X, [], [X]).
appendEl(X, [H | T], [H | Y]) :-
           appendEl(X, T, Y).

length([],0).
length([_|T],N) :- length(T,N1), N is N1+1.

nth(N,L,E) :- nth(1,N,L,E).
nth(N,N,[H|_],H).
nth(K,N,[_|T],H) :- K1 is K+1, nth(K1,N,T,H).

subset([], []).
subset([H|T], [H|R]) :- subset(T, R).
subset([_|T], R) :- subset(T, R).

select(X,[X|T],T).
select(X,[Y|T],[Y|R]) :- select(X,T,R).

member(X,L) :- select(X,L,_).
memberchk(X,L) :- select(X,L,_), !.

% - Startar här
remove_duplicates(ListIn, X) :-
    remove_duplicates(ListIn, X, []).

% - Basfall
remove_duplicates([], [], _).

remove_duplicates([H|T], R, SubList) :- 
    ((member(H,SubList)) 
        % - Om Head är member i sublist gör ingeting
        -> (R = Rs, SubListTemp = SubList)
        % - Om Head inte är member i sublist lägg till Head i sublist och i ResulatListan 
        ;  (R = [H|Rs], SubListTemp = [H|SubList])
    ),
    % - Hoppa fram ett steg i listan
    remove_duplicates(T, Rs ,SubListTemp).



