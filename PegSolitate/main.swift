//
//  main.swift
//  PegSolitate
//
//  Created by Michael Bottone on 12/12/15.
//  Copyright © 2015 Michael Bottone. All rights reserved.
//

import Foundation

let board: [[BoardValue]] = [
    [.Empty, .Peg, .Peg, .Peg, .Peg],
    [.Peg, .Peg, .Peg, .Peg],
    [.Peg, .Peg, .Peg],
    [.Peg, .Peg],
    [.Peg],
]

let emptySpaces = emptySpacesFromBoard(board)
let pegCount = pegCountFromBoard(board)

let startState = BoardNode(board: board, emptySpaces: emptySpaces, pegCount: pegCount, parent: nil, moveString: "")
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
