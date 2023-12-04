IDENTIFICATION DIVISION.
PROGRAM-ID. BlackjackGame.

DATA DIVISION.
WORKING-STORAGE SECTION.
01 Player-Hand OCCURS 10 TIMES PIC X(2).
01 Dealer-Hand OCCURS 10 TIMES PIC X(2).
01 Player-Total PIC 99.
01 Dealer-Total PIC 99.
01 Card-Values VALUE " 23456789TJQKA".
01 Card-Suits VALUE "CDHS".
01 Deck PIC X(52).

PROCEDURE DIVISION.
    DISPLAY "Welcome to Simple Blackjack!".
    PERFORM Initialize-Deck.
    PERFORM Deal-Initial-Hands.
    PERFORM Play-Game.
    DISPLAY "Thanks for playing Blackjack!".

Initialize-Deck.
    MOVE Card-Values TO Deck.
    MULTIPLY Card-Suits BY 13 GIVING Deck.

Deal-Initial-Hands.
    PERFORM Deal-Card TO Player-Hand.
    PERFORM Deal-Card TO Dealer-Hand.
    PERFORM Deal-Card TO Player-Hand.
    PERFORM Deal-Card TO Dealer-Hand.

Deal-Card.
    MOVE Deck(1:2) TO Card.
    MOVE Deck(3:) TO Deck.
    ADD 1 TO Function RETURNING Card.

Calculate-Hand-Total USING Hand Hand-Total.
    SET Hand-Total TO ZERO.
    PERFORM VARYING I FROM 1 BY 2 UNTIL Hand(I) = SPACE
        COMPUTE Hand-Total = Hand-Total + VALUE Hand(I) IN Card-Values.
    PERFORM VARYING I FROM 2 BY 2 UNTIL Hand(I) = SPACE
        COMPUTE Hand-Total = Hand-Total + VALUE Hand(I) IN Card-Values.
    IF Hand-Total > 21 AND Hand CONTAINS "A "
        SUBTRACT 10 FROM Hand-Total.

Play-Game.
    PERFORM Display-Hands.
    PERFORM Player-Turn UNTIL Player-Total >= 21 OR Function = 'S'.
    PERFORM Dealer-Turn UNTIL Dealer-Total >= 17.
    PERFORM Display-Result.

Player-Turn.
    DISPLAY "Do you want to (H)it or (S)tand?".
    ACCEPT Function.
    IF Function = 'H'
        PERFORM Deal-Card TO Player-Hand
        PERFORM Calculate-Hand-Total USING Player-Hand Player-Total
        DISPLAY "Your total is: " Player-Total
    END-IF.

Dealer-Turn.
    PERFORM Deal-Card TO Dealer-Hand.
    PERFORM Calculate-Hand-Total USING Dealer-Hand Dealer-Total.

Display-Hands.
    DISPLAY "Player's hand: " Player-Hand.
    DISPLAY "Dealer's hand: " Dealer-Hand(1:2) "XX".

Display-Result.
    DISPLAY "Player's total: " Player-Total.
    DISPLAY "Dealer's total: " Dealer-Total.
    IF Player-Total > 21 OR (Dealer-Total <= 21 AND Dealer-Total >= Player-Total)
        DISPLAY "Dealer wins!"
    ELSE IF Dealer-Total > 21 OR Player-Total > Dealer-Total
        DISPLAY "Player wins!"
    ELSE
        DISPLAY "It's a tie!".
