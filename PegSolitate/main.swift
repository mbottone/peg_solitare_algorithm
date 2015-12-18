//
//  main.swift
//  PegSolitate
//
//  Created by Michael Bottone on 12/12/15.
//  Copyright © 2015 Michael Bottone. All rights reserved.
//

import Foundation

var nodeCount = 0
func createGraph(node: BoardNode)
{
    node.generateMoves()
    
    for moveNode in node.moves
    {
        nodeCount++
        createGraph(moveNode)
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

let rootNode = BoardNode(board: board, parent: nil, moveString: "")
createGraph(rootNode)

print("Graph Complete - \(nodeCount) nodes.")
