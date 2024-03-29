% Load model, initial state and formula from file.
verify(Input) :-
    see(Input), read(T), read(L), read(S), read(F),
    seen,
    check(T, L, S, [], F).
    % check(T, L, S, U, F)
    % T - The transitions in form of adjacency lists
    % L - The labeling
    % S - Current state
    % U - Currently recorded states
    % F - CTL Formula to check.
    %
    % Should evaluate to true iff the sequent below is valid.
    %
    % (T,L), S |- F
    % U

% S�tt up regler f�r alla tillst�nd ax, ag ,af, ex ,eg, ef
% S�tt up de andra reglerna ocks�


% Literal
check(_, Labeling, State, _, X) :-
    get_list(State, Labeling, Labels),
    member(X, Labels).

% Literal Negation
check(_, Labeling, State, _, neg(X)) :-
    get_list(State, Labeling, Labels),
    not(member(X, Labels)).

% AND
check(Transitions, Labeling, State, _, and(F, G)) :-
    check(Transitions, Labeling, State, [], F), check(Transitions, Labeling, State, [], G).

% OR
check(Transitions, Labeling, State, _, or(F, G)):-
    check(Transitions, Labeling, State, [], F);
    check(Transitions, Labeling, State, [], G).

% EX (N�gon v�g n�sta tillst�nd) Klar
check(Transitions, Labeling, State, [], ex(X)) :-
    get_list(State, Transitions, Neighbours),
    member(NextState, Neighbours),
    check(Transitions, Labeling, NextState, [], X).

% AX (I n�sta tillst�nd) Klar
check(Transitions, Labeling, State, Visisted, ax(X)) :-
    get_list(State, Transitions, Neighbours),
    check_all_states(Transitions, Labeling, Neighbours, Visisted, X).

% AG (alla v�gar �ver alla tillst�nd) Klar
check(_, _, State, Visisted, ag(_)) :-
    member(State, Visisted), !.

check(Transitions, Labeling, State, Visisted, ag(X)) :-
    check(Transitions, Labeling, State, [], X),
    get_list(State, Transitions, Neighbours),
    check_all_states(Transitions, Labeling, Neighbours, [State|Visisted], ag(X)).

% AF (Alla v�gar �ver n�got tillst�nd)
check(Transitions, Labeling, State, Visisted, af(X)) :-
    not(member(State, Visisted)),
    check(Transitions, Labeling, State, [], X).

check(Transitions, Labeling, State, Visisted, af(X)) :-
    not(member(State, Visisted)),
    get_list(State, Transitions, Neighbours),
    check_all_states(Transitions, Labeling, Neighbours, [State|Visisted], af(X)).

% EG (N�gon v�g alla tillst�nd)
check(_, _, State, Visisted, eg(_)) :-
    member(State, Visisted), !.

check(Transitions, Labeling, State, Visisted, eg(X)) :-
    check(Transitions, Labeling, State, [], X),
    get_list(State, Transitions, Neighbours),
    member(NextState,Neighbours),
    check(Transitions, Labeling, NextState, [State|Visisted], eg(X)).

% EF (N�gon v�g n�got tillst�nd)
check(Transitions, Labeling, State, Visisted, ef(X)) :-
    not(member(State, Visisted)),
    check(Transitions, Labeling, State, [], X).

check(Transitions, Labeling, State, Visisted, ef(X)) :-
    not(member(State, Visisted)),
    get_list(State, Transitions, Neighbours),
    member(NextState,Neighbours),
    check(Transitions, Labeling, NextState, [State|Visisted], ef(X)).

get_list(Head, [[Head, Tail]| _], Tail).

get_list(State, [_|T], List):-
    get_list(State, T, List).




% Basfall
check_all_states(_,_,[],_,_).

check_all_states(Transitions, Labeling, [Head|Tail], Visisted, X) :-
    check(Transitions, Labeling, Head, Visisted, X),
    check_all_states(Transitions, Labeling, Tail, Visisted, X).
