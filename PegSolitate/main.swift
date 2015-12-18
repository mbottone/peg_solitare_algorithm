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

let rootNode = BoardNode(board: board, parent: nil, moveString: "")

print("Generating graph...")

let start = NSDate()
let graph = BoardGraph(root: rootNode)
let timeElapsed = NSDate().timeIntervalSinceDate(start)

print("Graph Complete - \(graph.nodeCount) nodes in \(timeElapsed) seconds.")
