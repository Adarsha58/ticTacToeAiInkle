# author : ADARSHA POUDEL
# title : TIC-TAC-TOE AI
# theme : dark

CONST maxScore = 50
CONST maxMoves = 9
VAR totalMoves = 0
VAR currentPlayer = "AI"

// this represents the board
VAR TL = "-"
VAR TM = "-"
VAR TR = "-"  
VAR ML = "-"
VAR MM = "-"
VAR MR = "-"
VAR BL = "-"
VAR BM = "-"
VAR BR = "-"


->Begin

// MAJOR FUNCTIONS

//* SETS STATE FOR HUMAN'S TURN *// 
=== function HumanTurn(index) ===
    ~ setIndex(index, "O")
    ~ totalMoves = totalMoves + 1

//* SETS STATE FOR AI'S TURN *//  
=== function AITurn ===
    ~ temp bestIndex = -1
    // handle the first-time unnecssary computation
    { totalMoves == 0 : 
        ~ bestIndex = randomCorners()
    - else:
        ~ bestMove(1, bestIndex, -1000)
    }
    ~ setIndex(bestIndex, "X")
    ~ totalMoves = totalMoves + 1

//* FINDS THE BEST MOVE FOR THE AI *//  
=== function bestMove(index, ref bestIndex,  maxS) ===

    { index < 10 :
        { getIndex(index) == "-" && maxS < maxScore :
                ~ setIndex(index, "X")
                ~ temp eval = miniMax(0, totalMoves+1)
                { eval > maxS : 
                    ~ bestIndex = index
                    ~ maxS = eval
                }
                ~ setIndex(index, "-")
        }
        ~ bestMove(index+1, bestIndex, maxS)
    }


//* TYPICAL AI ALOGORITHM *//  
=== function miniMax(isMax, totalMovesMade) ===
    ~ temp heruisticScore = examineBoard()
    { heruisticScore == maxScore || heruisticScore == -maxScore || totalMovesMade == maxMoves :
        ~ return heruisticScore
    }
    ~ temp bestScore = 1000
    {isMax == 1: 
        ~ bestScore = -1000
    }
    ~ miniMaxBackTracking(isMax, totalMovesMade, 1, bestScore)
    ~ return bestScore
    
    
//* HELPER FUNCTION FOR BACKTRACKING *//  
=== function miniMaxBackTracking(isMax, totalMovesMade, index, ref bestScore) ===
    {index < 10: 
        { getIndex(index) == "-" :
            { isMax : 
                - 1 : 
                    ~ setIndex(index, "X")
                    ~ bestScore = max(bestScore, miniMax(0, totalMovesMade + 1))
                    ~ setIndex(index, "-")
                - else : 
                    ~ setIndex(index, "O")
                    ~ bestScore = min(bestScore, miniMax(1, totalMovesMade + 1))
                    ~ setIndex(index, "-")
            }
            
        }
        ~ miniMaxBackTracking(isMax, totalMovesMade, index+1, bestScore)
    }
    

// AUXILLARY FUNCTIONS 

//* PRINTS THE BOARD *//
=== function printBoard ===
    ________________________________________________________ #CLASS: TIC_TAK_BOX_LINE
    ____________ #CLASS: TIC_TAK_BOX
    \|\| {TL} \|\| {TM} \|\| {TR} \|\| #CLASS: TIC_TAK_BOX
    ____________ #CLASS: TIC_TAK_BOX
    \|\| {ML} \|\| {MM} \|\| {MR} \|\| #CLASS: TIC_TAK_BOX
    ____________ #CLASS: TIC_TAK_BOX
    \|\| {BL} \|\| {BM} \|\| {BR} \|\| #CLASS: TIC_TAK_BOX
    ____________ #CLASS: TIC_TAK_BOX
    ________________________________________________________#CLASS: TIC_TAK_BOX_LINE

//* CHECKS IF THE STATE OF THE GAME IS OVER *//
=== function gameIsOver ===
    ~ temp score = examineBoard()
    { score == maxScore:
        AI COMES OUT VICTORIOUS ONE MORE TIME :(
        ~ return 1
    }
    { score == -maxScore :
        You win! Thanks for providing liberation :)
        ~return 1
    }
    { totalMoves == maxMoves:
        It is a tie! Nice try :)
        ~ return 1
    }
    ~ return 0
    
//* EXAMINES THE BOARD TO GET A HERUISTIC SOCRE *//
=== function examineBoard ===
    { 
        -   TL == TM && TM == TR: 
               ~ return minOrMax(TL)
        -   ML == MM && MM == MR: 
               ~ return minOrMax(ML)
        -   BL == BM && BM == BR: 
               ~ return minOrMax(BL)
        -   TL == ML && ML == BL: 
               ~ return minOrMax(TL)
        -   TM == MM && MM == BM: 
               ~ return minOrMax(TM)
        -   TR == MR && MR == BR: 
               ~ return minOrMax(TR)
        -   TL == MM && MM == BR: 
               ~ return minOrMax(TL)
        -   TR == MM && MM == BL: 
               ~ return minOrMax(TR)
        -   else :
                ~ return 0
    }

//* MAPS INDEX TO ITS VALUES *//
=== function getIndex(index) ===
    {  index : 
        - 1 : 
            ~ return TL 
        - 2 : 
            ~ return TM 
        - 3 : 
            ~ return TR 
        - 4 : 
            ~ return ML 
        - 5 : 
            ~ return MM 
        - 6 : 
            ~ return MR 
         - 7 : 
            ~ return BL 
        - 8 : 
            ~ return BM 
        - else : 
            ~ return BR
    }

//* SETS THE VALUE OF BOARD AT A GIVEN INDEX  *//
=== function setIndex(index, val) ====
    {  index : 
        - 1 : 
            ~ TL = val
        - 2 : 
            ~ TM = val 
        - 3 : 
            ~ TR = val 
        - 4 : 
            ~ ML = val 
        - 5 : 
            ~ MM = val 
        - 6 : 
            ~ MR = val 
         - 7 : 
            ~ BL = val 
        - 8 : 
            ~ BM = val 
        - else : 
            ~ BR = val 
    }
    
//* HELPER FUNCTION FOR SCORING *//
=== function minOrMax(player) ===
    { player: 
        - "X" : 
            ~ return maxScore
        - "O" : 
            ~ return -maxScore
        - else : 
            ~ return 0
    }
  
//* RETURNS MAXIMUM *//  
=== function max(a,b) ===
	{ a < b:
		~ return b
	- else:
		~ return a
	}
	
//* RETURNS MINIMUM *//  	
=== function min(a,b) ===
	{ a > b:
		~ return b
	- else:
		~ return a
	}

//* RANDOMIZE CORNERS FOR THE FIRST MOVE *// 
=== function randomCorners ===
    ~ temp roll = RANDOM(1, 3)
    { roll == 2: 
        ~ roll = RANDOM(7, 9)	
    }
    { roll == 8 : 
        ~ roll = 7
    }
    ~ return roll
        

	

=== Begin ===
Welcome to the world of TIC-TAC-TOE ....

Vicious AIs have taken over this land. 
Please help this world and people to get the taste of true independence!
        +[Choose to play the game and save the land] -> start_game

=== start_game ===
    Choose one to find out who goes first.
    ~ temp rand = RANDOM(1, 2)
    {rand == 1 :
        ~ currentPlayer = "HUMAN"
    }
    +[head] -> next_turn
    +[tail] -> next_turn


=== next_turn ===
    {printBoard()} 
    {gameIsOver() == true: 
        ->restart
    }
    { currentPlayer == "HUMAN":
        -> ask_human
    - else : 
        -> ai_turn
    }
    
    
== ask_human === 
    Its your turn. Please make a choice :
    + {TL == "-"}[TOP LEFT] -> human_turn(1)
    + {TM == "-"}[TOP CENTER] ->  human_turn(2)
    + {TR == "-"}[TOP RIGHT] ->  human_turn(3)
    + {ML == "-"}[MIDDLE LEFT] ->  human_turn(4)
    + {MM == "-"}[MIDDLE CENTER] -> human_turn(5)
    + {MR == "-"}[MIDDLE RIGHT] -> human_turn(6)
    + {BL == "-"}[BOTTOM LEFT] ->  human_turn(7)
    + {BM == "-"}[BOTTOM CENTER] ->  human_turn(8)
    + {BR == "-"}[BOTTOM RIGHT] ->  human_turn(9)
    = human_turn(index) 
        {HumanTurn(index)}
    ~ currentPlayer = "AI"
    -> next_turn
    


=== ai_turn ===   
    Its AI's turn. AI IS COMPUTING. BEEP BEEP BOOP....
    {AITurn()} 
    AI HAS MADE ITS CHOICE.
    ~ currentPlayer = "HUMAN"
    -> next_turn
    
    


=== restart ===
Do you want to restart the game? 
    *[YES] -> RESET1
    *[NO] -> END



=== RESET1 ==
    #RESTART
->END 
