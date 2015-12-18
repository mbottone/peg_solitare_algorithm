//
//  main.swift
//  PegSolitate
//
//  Created by Michael Bottone on 12/12/15.
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

class BoardState
{
    let board: [[BoardValue]]
    var moves: [BoardState]
    let emptySpaces: [Point]
    let parent: BoardState?
    let pegCount: Int
    var moveString: String
    
    init(board: [[BoardValue]], emptySpaces: [Point], pegCount: Int, parent: BoardState?, moveString: String)
    {
        self.board = board
        self.emptySpaces = emptySpaces
        self.parent = parent
        self.pegCount = pegCount
        self.moves = [BoardState]()
        self.moveString = moveString
    }
    
    func boardValueForPoint(loc: Point) -> BoardValue
    {
        if loc.x < 0 || loc.y < 0 ||
            loc.y >= board.count || loc.x >= board[loc.y].count
        {
            return .Invalid
        }
        return board[loc.y][loc.x]
    }
    
    func hasMove(loc: Point, dir: Direction) -> Bool
    {
        let firstStep = loc.pointForDirection(dir)
        let secondStep = firstStep.pointForDirection(dir)
        return boardValueForPoint(firstStep) == .Peg &&
            boardValueForPoint(secondStep) == .Peg
    }
    
    func newBoardStateWithMove(loc: Point, dir: Direction) -> BoardState
    {
        var newBoard = board
        let jumpPoint = loc.pointForDirection(dir)
        let oldPoint = jumpPoint.pointForDirection(dir)
        
        newBoard[loc.y][loc.x] = .Peg
        newBoard[jumpPoint.y][jumpPoint.x] = .Empty
        newBoard[oldPoint.y][oldPoint.x] = .Empty
        
        var spaces = emptySpaces.filter {$0 != loc}
        spaces.append(jumpPoint)
        spaces.append(oldPoint)
        
        return BoardState(board: newBoard, emptySpaces: spaces, pegCount: pegCount - 1, parent: self, moveString: "\(oldPoint.toString()) -> \(loc.toString())")
    }
    
    func generateMoves() -> [BoardState]
    {
        var nextMoves = [BoardState]()
        for space in emptySpaces
        {
            for dir in Direction.tri
            {
                if hasMove(space, dir: dir)
                {
                    nextMoves.append(newBoardStateWithMove(space, dir: dir))
                }
            }
        }
        return nextMoves
    }
}

func createGraph(state: BoardState) -> Bool
{
    let moves = state.generateMoves()
    
    for move in moves
    {
        if createGraph(move)
        {
            state.moves.append(move)
        }
    }
    
    return (state.pegCount == 1 || state.moves.count != 0)
}

func emptySpacesFromBoard(board: [[BoardValue]]) -> [Point]
{
    var emptySpaces: [Point] = [Point]()
    for var yIndex = 0; yIndex < board.count; yIndex++
    {
        for var xIndex = 0; xIndex < board[yIndex].count; xIndex++
        {
            if board[yIndex][xIndex] == .Empty
            {
                emptySpaces.append(Point(x: xIndex, y: yIndex))
            }
        }
    }
    return emptySpaces
}

func pegCountFromBoard(board: [[BoardValue]]) -> Int
{
    var pegCount: Int = 0
    for row in board
    {
        for value in row
        {
            if value == .Peg
            {
                pegCount++
            }
        }
    }
    return pegCount
}

var outputString = "<root>\n"
func generateOutputString(state: BoardState, height: Int)
{
    if height != 0
    {
        for _ in 1...height
        {
            outputString += "   "
        }
        outputString += "<move>\(state.moveString)\n"
    }
    
    for move in state.moves
    {
        generateOutputString(move, height: height + 1)
    }
    
    if height != 0
    {
        for _ in 1...height
        {
            outputString += "   "
        }
        outputString += "</move>\n"
    }
    else
    {
        outputString += "</root>\n"
    }
}

let board: [[BoardValue]] = [
    [.Empty, .Peg, .Peg, .Peg, .Peg],
    [.Peg, .Peg, .Peg, .Peg],
    [.Peg, .Peg, .Peg],
    [.Peg, .Peg],
    [.Peg],
]

let emptySpaces = emptySpacesFromBoard(board)
let pegCount = pegCountFromBoard(board)

let startState = BoardState(board: board, emptySpaces: emptySpaces, pegCount: pegCount, parent: nil, moveString: "")
createGraph(startState)
generateOutputString(startState, height: 0)

do
{
    try outputString.writeToFile("output.xml", atomically: true, encoding: NSUTF8StringEncoding)
}
catch let error as NSError
{
    print("Error - \(error.description)")
}
