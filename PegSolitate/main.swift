//
//  main.swift
//  PegSolitate
//
//  Created by Michael Bottone on 12/12/15.
//  Copyright © 2015 Michael Bottone. All rights reserved.
//

import Foundation

func timed <A> (@noescape f: () -> A) -> A
{
    let startTime = NSDate()
    let result = f()
    let timeElapsed = NSDate().timeIntervalSinceDate(startTime)
    
    print("Time Elapsed - \(timeElapsed) seconds")
    return result
}

let data: [[BoardValue]] = [
    [.Empty, .Peg, .Peg, .Peg, .Peg],
    [.Peg, .Peg, .Peg, .Peg],
    [.Peg, .Peg, .Peg],
    [.Peg, .Peg],
    [.Peg],
]
let board = Board(data: data)

var rootNode = BoardNode(board: board, parent: nil, moveString: "")
rootNode.generateMoves()

print("Generating graph...")

let graph = timed { BoardGraph(root: rootNode) }

print("Graph Complete - \(graph.nodeCount) nodes")

print("Writing to file...")

do {
    try graph.outputString.writeToFile("output.xml", atomically: true, encoding: NSUTF8StringEncoding)
}
catch let error as NSError {
    print("Could not write to file - \(error.description)")
}
