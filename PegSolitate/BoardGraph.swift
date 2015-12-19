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
    var outputString: String
    
    init(root: BoardNode)
    {
        self.root = root
        self.nodeCount = 1
        self.outputString = "<root>\n"
        
        createGraph(self.root, height: 0)
        
        outputString += "</root>\n"
    }
    
    private func createGraph(node: BoardNode, height: Int)
    {
        node.generateMoves()
        
        for moveNode in node.moves
        {
            nodeCount++
            
            outputString += getBuffer(height + 1)
            outputString += "<move>\(moveNode.moveString)\n"
            
            createGraph(moveNode, height: height + 1)
            
            outputString += getBuffer(height + 1)
            outputString += "</move>\n"
        }
    }
    
    private func getBuffer(height: Int) -> String
    {
        return String(count: height, repeatedValue: Character("\t"))
    }
}
