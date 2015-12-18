//
//  main.swift
//  PegSolitate
//
//  Created by Michael Bottone on 12/12/15.
//  Copyright © 2015 Michael Bottone. All rights reserved.
//

import Foundation

func time <A> (@noescape f: () -> A) -> A
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

let rootNode = BoardNode(board: board, parent: nil, moveString: "")

print("Generating graph...")

let graph = time { BoardGraph(root: rootNode) }

print("Graph Complete - \(graph.nodeCount) nodes")
