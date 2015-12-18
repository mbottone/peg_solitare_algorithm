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

struct Board
{
    var data: [[BoardValue]]
    
    var emptySpaces: [Point] {
        var spaces: [Point] = [Point]()
        for var yIndex = 0; yIndex < board.count; yIndex++
        {
            for var xIndex = 0; xIndex < board[yIndex].count; xIndex++
            {
                if board[yIndex][xIndex] == .Empty
                {
                    spaces.append(Point(x: xIndex, y: yIndex))
                }
            }
        }
        return spaces
    }
    
    var pegCount: Int {
        var pegs: Int = 0
        for row in board
        {
            for value in row
            {
                if value == .Peg
                {
                    pegs++
                }
            }
        }
        return pegs
    }
    
    func valueForPoint(loc: Point) -> BoardValue
    {
        if loc.x < 0 || loc.y < 0 ||
            loc.y >= data.count || loc.x >= data[loc.y].count
        {
            return .Invalid
        }
        return data[loc.y][loc.x]
    }
    
    func hasMove(loc: Point, dir: Direction) -> Bool
    {
        let firstStep = loc.pointForDirection(dir)
        let secondStep = firstStep.pointForDirection(dir)
        return valueForPoint(firstStep) == .Peg &&
            valueForPoint(secondStep) == .Peg
    }
}
