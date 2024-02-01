% Alla consecutive listor av List
partstring(List,Length,Prefix) :- 
    % - Tar fram alla möjliga suffix 
    append2(_,Suffix,List), 

    % - Tar fram alla möjliga prefix av suffixet 
    append2(Prefix,_,Suffix), 

    % - Tar fram längden på prefixet och förhindrar tomma listan
    length(Prefix,Length), Length > 0.

append2([],L,L).
append2([H|T],L,[H|R]) :- append2(T,L,R).