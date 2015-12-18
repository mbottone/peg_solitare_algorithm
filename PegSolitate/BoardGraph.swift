//
//  BoardGraph.swift
//  PegSolitate
//
//  Created by Michael Bottone on 12/18/15.
//  Copyright © 2015 Michael Bottone. All rights reserved.
//

import Foundation

class BoardGraph
{
    var root: BoardNode
    var nodeCount: Int
    
    init(root: BoardNode)
    {
        self.root = root
        self.nodeCount = 1
        
        createGraph(self.root)
    }
    
    private func createGraph(node: BoardNode)
    {
        node.generateMoves()
        
        for moveNode in node.moves
        {
            nodeCount++
            createGraph(moveNode)
        }
    }
}
