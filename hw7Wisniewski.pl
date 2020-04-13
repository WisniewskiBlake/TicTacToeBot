% how to win on column
ordered_line(1, 4, 7).
ordered_line(2, 5, 8).
ordered_line(3, 6, 9).

% how towin on diagonal
ordered_line(1, 5, 9).
ordered_line(3, 5, 7).

% how to win on row
ordered_line(1, 2, 3).
ordered_line(4, 5, 6).
ordered_line(7, 8, 9).

% move decision
line(A, B, C) :- ordered_line(A, B, C).
line(A, B, C) :- ordered_line(A, C, B).
line(A, B, C) :- ordered_line(B, A, C).
line(A, B, C) :- ordered_line(B, C, A).
line(A, B, C) :- ordered_line(C, A, B).
line(A, B, C) :- ordered_line(C, B, A).

full(A) :- x(A).
full(A) :- o(A).
empty(A) :- \+(full(A)).
same(A, A).
different(A, B) :- \+(same(A, B)).

% checking for a possible move
move(A) :- good(A), empty(A), !.

% block condition is checked for any win condition for computer and player
good(A) :- blockCheck(A).

% this is a move set for the computer to win. win chance is increased by starting
% in the corners of the board.
good(1). good(9). good(7). good(3). good(2). good(4). good(6). good(8). good(5).

% have to check for win condition first
win(A) :- x(B), x(C), line(A,B,C).

% checking for cat game(draw)
all_full :- full(1), full(2), full(3), full(4), full(5),
full(6), full(7), full(8), full(9).

% once computer check for win condition, if there is one, then make move
% if not, computer blocks user from winning move
blockCheck(A) :- win(A).

%checking if player can make winning move
blockCheck(A) :- o(B), o(C), line(A,B,C).

% players move
getmove:- ordered_line(A, B, C), x(A), x(B), x(C), printboard, write('I won.'), nl.

getmove :- playerMove, done.

playerMove :- all_full.
playerMove :- repeat, write('Please enter a move: '), read(X), empty(X), !, assert(o(X)).

% move has been made
done :- ordered_line(A, B, C), o(A), o(B), o(C), printboard, write('You won.'), nl.
done :- all_full, write('Draw'), nl.

% computers move
makemove :- move(X), !, assert(x(X)).

% printing the board
printsquare(N) :- o(N), write(' o ').
printsquare(N) :- x(N), write(' x ').
printsquare(N) :- empty(N), write('   ').
printboard :- printsquare(1), printsquare(2), printsquare(3), nl,
printsquare(4), printsquare(5), printsquare(6), nl,
printsquare(7), printsquare(8), printsquare(9), nl.
clear :- retractall(x(_)), retractall(o(_)).

% Main
play :- clear, repeat, respond, getmove.
respond :- makemove, printboard.


