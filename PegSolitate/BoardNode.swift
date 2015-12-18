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
    var moves: [BoardNode]
    let parent: BoardNode?
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
        
        var spaces = board.emptySpaces.filter {$0 != location}
        spaces.append(jumpPoint)
        spaces.append(oldPoint)
        
        let moveDescription = "\(oldPoint.toString()) -> \(location.toString())"
        
        return BoardNode(board: newBoard, parent: self, moveString: moveDescription)
    }
    
    func generateMoves() -> [BoardNode]
    {
        var nextMoves = [BoardNode]()
        for space in board.emptySpaces
        {
            for dir in Direction.tri
            {
                let move = Move(loc: space, dir: dir)
                
                if board.hasMove(move)
                {
                    nextMoves.append(newBoardNodeWithMove(move))
                }
            }
        }
        return nextMoves
    }
}
