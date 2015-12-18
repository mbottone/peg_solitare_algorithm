//
//  Move.swift
//  PegSolitate
//
//  Created by Michael Bottone on 12/18/15.
//  Copyright © 2015 Michael Bottone. All rights reserved.
//

import Foundation

enum Direction
{
    case N
    case S
    case E
    case W
    
    case NE
    case NW
    case SE
    case SW
    
    static let all = [N, S, E, W, NE, NW, SE, SW]
    static let tri = [N, S, E, W, NE, SW]
    static let ortho = [N, S, E, W]
}

func !=(lhs: Point, rhs: Point) -> Bool
{
    return lhs.x != rhs.x || lhs.y != rhs.y
}

struct Point
{
    var x: Int
    var y: Int
    
    func pointForDirection(dir: Direction) -> Point
    {
        switch dir
        {
        case .N:
            return Point(x: x, y: y - 1)
        case .S:
            return Point(x: x, y: y + 1)
        case .E:
            return Point(x: x - 1, y: y)
        case .W:
            return Point(x: x + 1, y: y)
        case .NE:
            return Point(x: x + 1, y: y - 1)
        case .NW:
            return Point(x: x - 1, y: y - 1)
        case .SE:
            return Point(x: x + 1, y: y + 1)
        case .SW:
            return Point(x: x - 1, y: y + 1)
        }
    }
    
    func toString() -> String
    {
        return "(\(x), \(y))"
    }
}

struct Move
{
    var location: Point
    var direction: Direction
    
    var firstStep: Point {
        return location.pointForDirection(direction)
    }
    
    var secondStep: Point {
        return firstStep.pointForDirection(direction)
    }
    
    init(loc: Point, dir: Direction)
    {
        self.location = loc
        self.direction = dir
    }
}
