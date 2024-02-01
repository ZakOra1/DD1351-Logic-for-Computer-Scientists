verify(InputFileName) :-
    see(InputFileName),
    read(Prems), read(Goal), read(Proof),
    seen,
    valid_proof(Prems,Goal,Proof).

% -------------------------> VALID PROOF <----------------------------%
valid_proof(Prems,Goal,Proof) :-
    valid_proof(Prems, Goal, Proof, Proof).

valid_proof(Prems, Goal, [[Row, Expression, Rule]], Proof) :-       % basfall
    last(Proof, [Row, Expression, Rule]),
    verify_rule(Prems, [Row,Expression,Rule], Proof),
    Expression = Goal.

valid_proof(Prems, Goal, [[Row, Expression, Rule]|Tail], Proof2) :-
    verify_rule(Prems, [Row,Expression,Rule], Proof2),
    valid_proof(Prems,Goal,Tail,Proof2).

valid_proof(Prems, Goal, [[[Row, Expression, assumption]|Tail1]|Tail2], Proof2) :-
    \+member([_,_,assumption], Tail1),

    verify_box(Prems, Goal, Tail1, Tail1, Proof2, Tail2),
    valid_proof(Prems,Goal,Tail2,Proof2).

valid_proof(Prems, Goal, [[[Row, Expression, assumption]|Tail1]|Tail2], Proof2) :-
    %verify_assumption(Row, Expression, Rule)
    \+member([_,_,assumption], Tail1),
    valid_proof(Prems,Goal,Tail2,Proof2).

% -------------------------> VERIFY BOX <-----------------------------%

verify_box(Prems, Goal,  [[Row, Expression, Rule]], BoxProof, OriginalProof, Test) :-
    last(BoxProof, [Row,Expression, Rule]),
    verify_rule(Prems, [Row,Expression,Rule], OriginalProof).
    %valid_proof(Prems,Goal, Test, OriginalProof).

verify_box(Prems, Goal,  [[Row, Expression, Rule]|Tail], BoxProof, OriginalProof, Test) :-
    verify_rule(Prems, [Row,Expression,Rule], BoxProof),
    verify_box(Prems,Goal, Tail, BoxProof, OriginalProof, Test).

% -------------------------------------------------------------------%




% -------------------------- VERIFY RULE ----------------------------%


% Premiss
verify_rule(Prems, [_, Expression, premise], _) :-
    member(Expression, Prems).

% Copy
verify_rule(Prems, [Row, X, copy(Row1)], Proof) :-
    Row > Row1,
    member(Box,Proof),
    member([Row,X,_], Box).

% AndInt
verify_rule(Prems, [Row, and(X1, X2), andint(Row1,Row2)], Proof) :-
    Row > Row1,
    Row > Row2,
    member([Row1,X1,_], Proof),
    member([Row2,X2,_], Proof).

% AndEl1
verify_rule(Prems, [Row, X, andel1(Row1)], Proof) :-
    Row > Row1,
    member([Row1,and(X,_), _], Proof).

% AndEl2
verify_rule(Prems, [Row, X, andel2(Row2)], Proof) :-
    Row > Row2,
    member([Row2,and(_,X), _], Proof).

% OrInt1
verify_rule(Prems, [Row, or(X,_) , orint1(Row1)], Proof) :-
    Row > Row1,
    member([Row1, X, _] , Proof).

% OrInt2
verify_rule(Prems, [Row, X, orint2(Row2)], Proof) :-
    Row > Row2,
    member(X, Proof).

% ImpInt
verify_rule(Prems, [Row, imp(X1,X2), impint(Row1,Row2)], Proof) :-
    Row > Row1,
    Row > Row2,
    member(Box,Proof),
    member([Row1,X1,assumption], Box),
    member([Row2,X2,_], Box).

% ImpEl
verify_rule(Prems, [Row, X, impel(Row1,Row2)], Proof) :-
    Row > Row1,
    Row > Row2,
    member([Row2,imp(Y,X),_], Proof),
    member([Row1,Y,_], Proof).

% NegEl
verify_rule(Prems, [Row, cont, negel(Row1,Row2)], Proof) :-
    Row > Row1,
    Row > Row2,
    member([Row1, X ,_], Proof),
    member([Row2, neg(X) ,_], Proof).

% ContEl
verify_rule(Prems, [Row, _, contel(Row1)], Proof) :-
    Row > Row1,
    member([Row1, cont, _], Proof).

% NegInt
verify_rule(Prems, [Row, neg(X), negint(Row1,Row2)], Proof) :-
    Row > Row1,
    Row > Row2,
    member(Box, Proof),
    member([Row1,X,assumption],  Box),
    member([Row2, cont,_],  Box).

% NegNegInt
verify_rule(Prems, [Row, neg(neg(X)), negnegint(Row1)], Proof) :-
    Row > Row1,
    member([Row1,X,_], Proof).

% NegNegEl
verify_rule(Prems, [Row, X, negnegel(Row1)], Proof) :-
    Row > Row1,
    member([Row1,neg(neg(X)),_], Proof).

% MT
verify_rule(Prems, [Row, neg(X1), mt(Row1,Row2)], Proof) :-
    Row > Row1,
    Row > Row2,
    member([Row1,imp(X1,X2),_], Proof),
    member([Row2, neg(X2),_], Proof).

% PBC
verify_rule(Prems, [Row,X,pbc(Row1,Row2)], Proof) :-
    Row > Row1,
    Row > Row2,
    member(Box, Proof),
    member([Row1,neg(X),assumption], Box),
    member([Row2,cont,_], Box).

% OrEl
verify_rule(Prems, [Row,X,orel(Row1,Row2,Row3,Row4,Row5)], Proof) :-
    Row > Row1,
    Row > Row2,
    Row > Row3,
    Row > Row4,
    Row > Row5,
    member([Row1,or(A,B),_],Proof),
    member([[Row2,A,assumption],[Row3,X,_]],Proof),
    member([[Row4,B,assumption],[Row5,X,_]],Proof).

% LEM
verify_rule(Prems, [_,or(X,neg(X)),lem], Proof).

% Copy
verify_rule(Prems, [Row, X, copy(Row1)], Proof) :-
    Row > Row1,
    member(Box,Proof),
    member([Row,X,_], Box).

% ImpInt
verify_rule(Prems, [Row, imp(X1,X2), impint(Row1,Row2)], Proof) :-
    Row > Row1,
    Row > Row2,
    member(Box,Proof),
    member([Row1,X1,assumption], Box),
    member([Row2,X2,_], Proof).
