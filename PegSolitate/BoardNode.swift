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
    let moveString: String
    
    var moves: [BoardNode]
    
    init(board: Board, parent: BoardNode? = nil, moveString: String = "")
    {
        self.board = board
        self.parent = parent
        self.moves = [BoardNode]()
        self.moveString = moveString
    }
    
    func generateMoves()
    {
        for (index, space) in board.emptySpaces.enumerate()
        {
            for dir in Direction.tri
            {
                let move = Move(loc: space, dir: dir)
                
                if board.hasMove(move)
                {
                    moves.append(newBoardNodeWithMove(move, emptyIndex: index))
                }
            }
        }
    }
    
    private func newBoardNodeWithMove(move: Move, emptyIndex: Int) -> BoardNode
    {
        var newBoard = board
        
        let location = move.location
        let jumpPoint = move.firstStep
        let oldPoint = move.secondStep
        
        newBoard[location] = .Peg
        newBoard[jumpPoint] = .Empty
        newBoard[oldPoint] = .Empty
        
        newBoard.pegCount--
        
        newBoard.emptySpaces.removeAtIndex(emptyIndex)
        newBoard.emptySpaces.append(jumpPoint)
        newBoard.emptySpaces.append(oldPoint)
        
        return BoardNode(board: newBoard, parent: self, moveString: move.description)
    }
}
