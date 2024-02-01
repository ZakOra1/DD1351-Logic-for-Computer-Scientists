node(a).
node(b).
node(c).
node(d).

edge(a,b).
edge(b,c).
edge(c,d).
edge(d,b).
edge(a,d).



% startar här 
path(X, Y, Path) :-

	% [X] är här ackumulatorn för de noder vi gått igenom.
	path(X, Y, [X], C),
	reverse(Path,C).

% stop här
path(X, X, Visited, Visited).

% Loopdetektion, Går igenom alla noder
path(X, Z, Visited, Path):-
	edge(X, Y),
	\+ memberchk2(Y, Visited),
	% Om vi inte har varit i Y så läggs den in i Visited
	path(Y, Z, [Y|Visited], Path).




memberchk2(X, [X|Y]) :- !.
memberchk2(X, [Y|Z]) :- memberchk2(X, Z).