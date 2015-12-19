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
    private var data: [[BoardValue]]
    var pegCount: Int
    var emptySpaces: [Point]
    
    init(data: [[BoardValue]])
    {
        self.data = data
        emptySpaces = [Point]()
        pegCount = 0
        
        for (yIndex, row) in data.enumerate()
        {
            for (xIndex, value) in row.enumerate()
            {
                let p = Point(x: xIndex, y: yIndex)
                
                switch value
                {
                case .Empty:
                    emptySpaces.append(p)
                case .Peg:
                    pegCount++
                case .Invalid:
                    break
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
        return self[move.start] == .Peg && self[move.jump] == .Peg
    }
}
