//
//  main.swift
//  PegSolitate
//
//  Created by Michael Bottone on 12/12/15.
//  Copyright © 2015 Michael Bottone. All rights reserved.
//

import Foundation

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
