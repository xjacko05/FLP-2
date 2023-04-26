edge(a,b) :- !.
edge(a,c) :- !.
edge(a,d) :- !.
edge(a,e) :- !.
edge(a,f) :- !.
edge(a,g) :- !.
edge(a,h) :- !.
edge(a,i) :- !.
edge(b,c) :- !.
edge(b,d) :- !.
edge(b,e) :- !.
edge(b,f) :- !.
edge(b,g) :- !.
edge(b,h) :- !.
edge(b,i) :- !.
edge(c,d) :- !.
edge(c,e) :- !.
edge(c,f) :- !.
edge(c,g) :- !.
edge(c,h) :- !.
edge(c,i) :- !.
edge(d,e) :- !.
edge(d,f) :- !.
edge(d,g) :- !.
edge(d,h) :- !.
edge(d,i) :- !.
edge(e,f) :- !.
edge(e,g) :- !.
edge(e,h) :- !.
edge(e,i) :- !.
edge(f,g) :- !.
edge(f,h) :- !.
edge(f,i) :- !.
edge(g,h) :- !.
edge(g,i) :- !.
edge(h,i) :- !.

%edge(a,b) :- !.
%edge(a,c) :- !.
%edge(a,d) :- !.
%edge(b,c) :- !.
%edge(b,d) :- !.
%edge(c,d) :- !.

edge(1,2) :- !.
edge(2,3) :- !.
edge(3,4) :- !.
edge(4,5) :- !.
edge(5,1) :- !.
edge(1,6) :- !.
edge(2,6) :- !.
edge(3,6) :- !.
edge(5,6) :- !.
edge(3,5) :- !.

:- dynamic
    cycle/1.

filter([H|_], [H|_]).
filter(_, _) :- fail.

check_edge([]) :- !.
check_edge([_]) :- !.
check_edge([X,Y|T]) :-
    !,
    (edge(X,Y); edge(Y,X)),
    !,
    check_edge([Y|T]).

wrap([H|List], Result) :-
    append([H|List], [H], Result).

print_permutations(List) :-
    permutation(List, Perm),
    filter(List, Perm),
    wrap(Perm, Wrapped),
    check_edge(Wrapped),
    reverse(Wrapped, Reversed),
    (\+ cycle(Reversed)),
    asserta((cycle(Wrapped) :- true)),
    write(Wrapped), nl,
    fail.
print_permutations(_).