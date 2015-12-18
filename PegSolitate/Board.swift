//
//  Board.swift
//  PegSolitate
//
//  Created by Michael Bottone on 12/18/15.
//  Copyright © 2015 Michael Bottone. All rights reserved.
//

import Foundation

enum BoardValue
{
    case Invalid
    case Empty
    case Peg
}

struct Board
{
    var data: [[BoardValue]]
    var pegCount: Int
    var emptySpaces: [Point]
    
    init(data: [[BoardValue]])
    {
        self.data = data
        self.emptySpaces = [Point]()
        self.pegCount = 0
        
        for var yIndex = 0; yIndex < self.data.count; yIndex++
        {
            for var xIndex = 0; xIndex < self.data[yIndex].count; xIndex++
            {
                let p = Point(x: xIndex, y: yIndex)
                
                if self[p] == .Empty
                {
                    emptySpaces.append(p)
                }
                else if self[p] == .Peg
                {
                    pegCount++
                }
            }
        }
    }
    
    subscript(loc: Point) -> BoardValue {
        get {
            if loc.x < 0 || loc.y < 0 ||
                loc.y >= data.count || loc.x >= data[loc.y].count
            {
                return .Invalid
            }
            return data[loc.y][loc.x]
        }
        set (newValue) {
            data[loc.y][loc.x] = newValue
        }
    }
    
    func hasMove(move: Move) -> Bool
    {
        return self[move.firstStep] == .Peg && self[move.secondStep] == .Peg
    }
}
