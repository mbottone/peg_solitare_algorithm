//
//  BoardNode.swift
//  PegSolitate
//
//  Created by Michael Bottone on 12/18/15.
//  Copyright © 2015 Michael Bottone. All rights reserved.
//

import Foundation

class BoardNode
{
    let board: Board
    let parent: BoardNode?
    
    var moves: [BoardNode]
    var moveString: String
    
    init(board: Board, parent: BoardNode?, moveString: String)
    {
        self.board = board
        self.parent = parent
        self.moves = [BoardNode]()
        self.moveString = moveString
    }
    
    func newBoardNodeWithMove(move: Move) -> BoardNode
    {
        var newBoard = board
        
        let location = move.location
        let jumpPoint = move.firstStep
        let oldPoint = move.secondStep
        
        newBoard[location] = .Peg
        newBoard[jumpPoint] = .Empty
        newBoard[oldPoint] = .Empty
        
        newBoard.pegCount--
        
        newBoard.emptySpaces = board.emptySpaces.filter {$0 != location}
        newBoard.emptySpaces.append(jumpPoint)
        newBoard.emptySpaces.append(oldPoint)
        
        return BoardNode(board: newBoard, parent: self, moveString: move.description)
    }
    
    func generateMoves()
    {
        for space in board.emptySpaces
        {
            for dir in Direction.tri
            {
                let move = Move(location: space, direction: dir)
                
                if board.hasMove(move)
                {
                    moves.append(newBoardNodeWithMove(move))
                }
            }
        }
    }
}
