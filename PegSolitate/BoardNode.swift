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
    
    func newBoardNodeWithMove(loc: Point, dir: Direction) -> BoardNode
    {
        var newBoard = board
        let jumpPoint = loc.pointForDirection(dir)
        let oldPoint = jumpPoint.pointForDirection(dir)
        
        newBoard.data[loc.y][loc.x] = .Peg
        newBoard.data[jumpPoint.y][jumpPoint.x] = .Empty
        newBoard.data[oldPoint.y][oldPoint.x] = .Empty
        
        var spaces = emptySpaces.filter {$0 != loc}
        spaces.append(jumpPoint)
        spaces.append(oldPoint)
        
        let move = "\(oldPoint.toString()) -> \(loc.toString())"
        
        return BoardNode(board: newBoard, parent: self, moveString: move)
    }
    
    func generateMoves() -> [BoardNode]
    {
        var nextMoves = [BoardNode]()
        for space in emptySpaces
        {
            for dir in Direction.tri
            {
                if board.hasMove(space, dir: dir)
                {
                    nextMoves.append(newBoardNodeWithMove(space, dir: dir))
                }
            }
        }
        return nextMoves
    }
}

func createGraph(state: BoardNode) -> Bool
{
    let moves = state.generateMoves()
    
    for move in moves
    {
        if createGraph(move)
        {
            state.moves.append(move)
        }
    }
    
    return (state.board.pegCount == 1 || state.moves.count != 0)
}

var outputString = "<root>\n"
func generateOutputString(state: BoardNode, height: Int)
{
    if height != 0
    {
        for _ in 1...height
        {
            outputString += "   "
        }
        outputString += "<move>\(state.moveString)\n"
    }
    
    for move in state.moves
    {
        generateOutputString(move, height: height + 1)
    }
    
    if height != 0
    {
        for _ in 1...height
        {
            outputString += "   "
        }
        outputString += "</move>\n"
    }
    else
    {
        outputString += "</root>\n"
    }
}