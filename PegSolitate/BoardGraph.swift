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
        
        var finished = 0
        for moveNode in node.moves
        {
            nodeCount++
            
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0)) {
                self.parallelGraph(moveNode)
                finished++
            }
            
        }
        
        while finished != node.moves.count {}
    }
    
    private func parallelGraph(node: BoardNode)
    {
        node.generateMoves()
        
        for moveNode in node.moves
        {
            nodeCount++
            parallelGraph(moveNode)
        }
    }
}
