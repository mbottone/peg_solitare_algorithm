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
    
    func writeToFile(filename: String)
    {
        do
        {
            try outputString.writeToFile(filename, atomically: true, encoding: NSUTF8StringEncoding)
        }
        catch let error as NSError
        {
            print("Could not write to file - \(error.description)")
        }
    }
    
    private func createGraph(node: BoardNode, height: Int)
    {
        node.generateMoves()
        
        for moveNode in node.moves
        {
            nodeCount++
            
            let buffer = getBuffer(height + 1)
            outputString += "\(buffer)<move>\(moveNode.moveString)\n"
            
            createGraph(moveNode, height: height + 1)
            
            outputString += "\(buffer)</move>\n"
        }
    }
    
    private func getBuffer(count: Int) -> String
    {
        return String(count: count, repeatedValue: Character("\t"))
    }
}
