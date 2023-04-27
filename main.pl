%edge(a,b) :- !.
%edge(a,c) :- !.
%edge(a,d) :- !.
%edge(a,e) :- !.
%edge(a,f) :- !.
%edge(a,g) :- !.
%edge(a,h) :- !.
%edge(a,i) :- !.
%edge(b,c) :- !.
%edge(b,d) :- !.
%edge(b,e) :- !.
%edge(b,f) :- !.
%edge(b,g) :- !.
%edge(b,h) :- !.
%edge(b,i) :- !.
%edge(c,d) :- !.
%edge(c,e) :- !.
%edge(c,f) :- !.
%edge(c,g) :- !.
%edge(c,h) :- !.
%edge(c,i) :- !.
%edge(d,e) :- !.
%edge(d,f) :- !.
%edge(d,g) :- !.
%edge(d,h) :- !.
%edge(d,i) :- !.
%edge(e,f) :- !.
%edge(e,g) :- !.
%edge(e,h) :- !.
%edge(e,i) :- !.
%edge(f,g) :- !.
%edge(f,h) :- !.
%edge(f,i) :- !.
%edge(g,h) :- !.
%edge(g,i) :- !.
%edge(h,i) :- !.

%edge(a,b) :- !.
%edge(a,c) :- !.
%edge(a,d) :- !.
%edge(b,c) :- !.
%edge(b,d) :- !.
%edge(c,d) :- !.

%edge(1,2) :- !.
%edge(2,3) :- !.
%edge(3,4) :- !.
%edge(4,5) :- !.
%edge(5,1) :- !.
%edge(1,6) :- !.
%edge(2,6) :- !.
%edge(3,6) :- !.
%edge(5,6) :- !.
%edge(3,5) :- !.

:- dynamic cycle/1.
:- dynamic edge/2.
:- dynamic point/1.

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

custom_print([]) :- !.
custom_print([_]) :- !.
custom_print([X,Y|T]) :-
    write(X),
    write('-'),
    write(Y),
    write(' '),
    custom_print([Y|T]).

print_cycles(List) :-
    permutation(List, Perm),
    filter(List, Perm),
    wrap(Perm, Wrapped),
    check_edge(Wrapped),
    reverse(Wrapped, Reversed),
    (\+ cycle(Reversed)),
    asserta((cycle(Wrapped) :- !)),%might need to be true instead of cut
    %write(Wrapped), nl,
    custom_print(Wrapped), nl,
    fail.
print_cycles(_).

%process_input :-
%    read_line_to_string(user_input, Line),
%    sub_atom(Line, 0, 1, _, First),
%    sub_atom(Line, 2, 1, _, Third),
%    assertz((edge(First, Third) :- !)),
%    (((\+ point(First)), asserta((point(First)))) ; true),
%    (((\+ point(Third)), asserta((point(Third)))) ; true),
%    !.

%process_input :-
%    read_line_to_string(user_input, Line),
%    (   Line \= end_of_file ->
%        sub_atom(Line, 0, 1, _, First),
%        sub_atom(Line, 2, 1, _, Third),
%        assertz((edge(First, Third) :- !)),
%        (((\+ point(First)), asserta((point(First)))) ; true),
%        (((\+ point(Third)), asserta((point(Third)))) ; true),
%        process_input
%    ;   true
%    ).

read_line(L,C) :-
    get_char(C),
    (isEOFEOL(C), L = [], !;
    read_line(LL, _),
    [C|LL] = L ).

isEOFEOL(C) :-
    C == end_of_file;
    (char_code(C,Code), Code==10).

read_lines(Ls) :-
    read_line(L, C),
    (C == end_of_file, Ls=[] ;
    (read_lines(LLs), [L|LLs] = Ls)).

main :-
    prompt(_, ''),
	read_lines(INPUT),
    %write(INPUT), nl,
    fill_edges(INPUT),
    findall(X, point(X), POINTS),
    print_cycles(POINTS).
    %remove_duplicates(POINTS, FILTERED),
    %write(FILTERED), nl.

fill_edges([]).
fill_edges([[From,_,To]|Tail]) :-
    %asserta((point(From))),
    %asserta((point(To))),
    (((\+ point(From)), asserta((point(From)))) ; true),
    (((\+ point(To)), asserta((point(To)))) ; true),
    assertz((edge(From, To) :- !)),
    fill_edges(Tail).

%remove_duplicates([], []).
%remove_duplicates([X|Xs], Ys) :-
%    member(X, Xs),
%    remove_duplicates(Xs, Ys).
%remove_duplicates([X|Xs], [X|Ys]) :-
%    \+ member(X, Xs),
%    remove_duplicates(Xs, Ys).
