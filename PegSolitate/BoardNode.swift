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
    
    var moves: [BoardNode] = [BoardNode]()
    
    init(board: Board, parent: BoardNode? = nil, moveString: String = "")
    {
        self.board = board
        self.parent = parent
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
        
        newBoard[move.end] = .Peg
        newBoard[move.jump] = .Empty
        newBoard[move.start] = .Empty
        
        newBoard.pegCount--
        
        newBoard.emptySpaces.removeAtIndex(emptyIndex)
        newBoard.emptySpaces.append(move.jump)
        newBoard.emptySpaces.append(move.start)
        
        return BoardNode(board: newBoard, parent: self, moveString: move.description)
    }
}
