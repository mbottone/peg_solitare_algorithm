//
//  main.swift
//  PegSolitate
//
//  Created by Michael Bottone on 12/12/15.
//  Copyright © 2015 Michael Bottone. All rights reserved.
//

import Foundation

func createGraph(node: BoardNode) -> Bool
{
    let moves = node.generateMoves()
    
    for moveNode in moves
    {
        if createGraph(moveNode)
        {
            node.moves.append(moveNode)
        }
    }
    
    return (node.board.pegCount == 1 || node.moves.count != 0)
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

let data: [[BoardValue]] = [
    [.Empty, .Peg, .Peg, .Peg, .Peg],
    [.Peg, .Peg, .Peg, .Peg],
    [.Peg, .Peg, .Peg],
    [.Peg, .Peg],
    [.Peg],
]
let board = Board(data: data)

let startState = BoardNode(board: board, parent: nil, moveString: "")
createGraph(startState)
generateOutputString(startState, height: 0)

do
{
    try outputString.writeToFile("output.xml", atomically: true, encoding: NSUTF8StringEncoding)
}
catch let error as NSError
{
    print("Error - \(error.description)")
}
