//
//  SodukuBoard.swift
//  sodukuSolver
//
//  Created by William Cromb on 2014-12-01.
//  Copyright (c) 2014 William Cromb. All rights reserved.
//

import Foundation

/**
Print an array of Int? as a soduku board with a visual format

:param: board an array of 81 Int? values
:returns: A string representing a Soduku Board, with B representing nils
*/
public func prettyPrintBoard(board: [Int?])->String{
    var result = "\r"
    var toWrite: String
    var index: Int
    for i in 1...9{
        for j in 1...9 {
            index = ((i - 1) * 9) + (j - 1)
            if let n = board[index]?{
                toWrite = String(n)
            }
            else{
                toWrite = "B"
            }
            toWrite += " "
            result += toWrite
            if (j == 3 || j == 6){
                result += "| "
            }
        }
        if i == 3 || i == 6{
            result += "\r---------------------"
        }
        result += "\r"
    }
    return result
}

/**
    A wrapper for units, used to store list of indexes to test board for validity
*/
class sodukuUnits{
    /**
    An array of arrays of indexes. Each array represents 1 set of indexes within a Soduku
    board array which must all have different values in order for a board to be valid
    */
    class var units: [[Int]]{ get{
        return [
        // rows
        [0,   1,   2,   3,   4,   5,   6,   7,   8],
        [9,  10,  11,  12,  13,  14,  15,  16,  17],
        [18,  19,  20,  21,  22,  23,  24,  25,  26],
        [27,  28,  29,  30,  31,  32,  33,  34,  35],
        [36,  37,  38,  39,  40,  41,  42,  43,  44],
        [45,  46,  47,  48,  49,  50,  51,  52,  53],
        [54,  55,  56,  57,  58,  59,  60,  61,  62],
        [63,  64,  65,  66,  67,  68,  69,  70,  71],
        [72,  73,  74,  75,  76,  77,  78,  79,  80],
        // columns
        [0,   9,  18,  27,  36,  45,  54,  63,  72],
        [1,  10,  19,  28,  37,  46,  55,  64,  73],
        [2,  11,  20,  29,  38,  47,  56,  65,  74],
        [3,  12,  21,  30,  39,  48,  57,  66,  75],
        [4,  13,  22,  31,  40,  49,  58,  67,  76],
        [5,  14,  23,  32,  41,  50,  59,  68,  77],
        [6,  15,  24,  33,  42,  51,  60,  69,  78],
        [7,  16,  25,  34,  43,  52,  61,  70,  79],
        [8,  17,  26,  35,  44,  53,  62,  71,  80],
        // squares
        [0,   1,   2,   9,  10,  11,  18,  19,  20],
        [3,   4,   5,  12,  13,  14,  21,  22,  23],
        [6,   7,   8,  15,  16,  17,  24,  25,  26],
        [27,  28,  29,  36,  37,  38,  45,  46,  47],
        [30,  31,  32,  39,  40,  41,  48,  49,  50],
        [33,  34,  35,  42,  43,  44,  51,  52,  53],
        [54,  55,  56,  63,  64,  65,  72,  73,  74],
        [57,  58,  59,  66,  67,  68,  75,  76,  77],
        [60,  61,  62,  69,  70,  71,  78,  79,  80]]}
    }
}


/**
A struct representing a position in 1-indexed rows and cols
*/
struct sodukuPos{
    //1 indexed positions in soduku board
    init(row: Int, col: Int){
        self.row = row
        self.col = col
        assert(row <= 9, "row too large")
        assert(row > 0, "row too small")
        assert(col <= 9, "col too large")
        assert(col > 0, "col too small")
    }
    
    let row: Int
    let col: Int
    
    /**
    Produce the zero-Valued Index within an array of 81 values representing a Soduku Board
    */
    func toIndex() -> Int {
        return ((col - 1) * 9) + row - 1
    }
}



/// A Soduku Board
class sodukuBoard {
    /**
    The backing array is an array of 81 values, by default all blank
    */
    private var backingArray = [Int?](count:81, repeatedValue: nil)
    
    init(array: [Int?]?){
        if let arr = array?{
        if (arr.count == 81)
        {
            var validArray = true
            
            for o in arr
            {
                if let i = o?
                {
                    if (i < 1 || i > 9)
                    {
                        validArray = false
                    }
                }
            }
            
            if (validArray){
                self.backingArray = arr
                return
            }
            }}
        self.backingArray = [Int?](count:81, repeatedValue: nil)
    }
    
    /**
    Solve the sodukuBoard
    
    :returns: nil if board is unsolvable, a completed Board if board is solvable
    */
    func solve() -> sodukuBoard? {
        if (!self.valid){
            return nil
        }
        else if (self.solved){
            return self
        }
        else {return sodukuBoard.solveLOBD([self])
        }
    }
    /**
    iterate over a list of Boards to solve
    */
    private class func solveLOBD(workList: [sodukuBoard]) -> sodukuBoard?{
        var wl = workList
        while !wl.isEmpty{
            let check = wl[0]
            if check.solved{
                return check
            }
            wl.removeAtIndex(0)
            wl += check.nextBoards()
        }
        return nil
    }
    /**
    produce a list of next boards for boards (valid or no)
    */
    private func nextBoards() -> [sodukuBoard]
    {
        var result: [sodukuBoard] = []
        if let index = self.firstBlank{
            let immutableBD = self.backingArray
            var try: sodukuBoard
            var newBD: [Int?]
            for i in 1...9{
                newBD = immutableBD
                newBD[index] = i
                try = sodukuBoard(array: newBD)
                if try.valid{
                    result.append(try)}
                
            }
        }
        return result
    }
    
    /**
    True if board is a valid sodukuBoard
    */
    var valid: Bool{
        get{
            if (self.backingArray.count != 81){
                return false
            }
            var compare: [Int]
            let emptyArray: [Int] = []
            for unit in sodukuUnits.units{
                compare = []
                for i in unit{
                    if let n = self.backingArray[i]{
                        compare.append(n)}
                }
                //Somehow check if all the numbers in compare are unique
                for (var index = 0; index < compare.count; index++) {
                    let n = compare[index]
                    if (find(compare[(index + 1)..<compare.count], n) != nil){
                        return false
                    }
                    }
            }
            return true
        }
        
    }
    
    
    /**
    Get the index of the first nil in the board
    
    :returns: nil if board is full, or the index of the first blank in the backing array
    */
    private var firstBlank: Int?{
        get{
            for (var i = 0; i < self.backingArray.count; i++)
            {
                if self.backingArray[i] == nil {return i}
            }
            return nil
        }
    }
    
    /**
    True if board is full
    */
    private var isFull: Bool{
        get{
            if (self.firstBlank == nil){
                return true
            }
            else{
                return false
            }
        }
    }
    
    /**
    True if a board is solved
    */
    var solved: Bool{
        get{
            return self.isFull && self.valid
        }
    }
    
    /**
    Get a value for a position
    
    :param: pos a sodukuPos
    :returns: An Int?, either nil or in range 1-9
    */
    func getValueAtPos(pos: sodukuPos)-> Int?{
        return self.backingArray[pos.toIndex()]
    }
    /**
    Set the value in the position on the board
    Doesn't set anything if value is not nil or in range 1-9
    
    :param: value An Int in range 1-9 or nil
    */
    func setValueAtPos(pos: sodukuPos, value: Int?)
    {
        if let i = value?{
            if (i <= 9 && i > 0){
                self.backingArray[pos.toIndex()] = i}
        }
        else {
            self.backingArray[pos.toIndex()] = value
        }
    }
    
    var asString: String{
        return prettyPrintBoard(self.backingArray)
    }
    
    func isEqualToBoard(board: sodukuBoard) -> Bool {
        return self.asString == board.asString
    }
}
