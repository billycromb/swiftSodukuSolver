//
//  sodukuSolverTests.swift
//  sodukuSolverTests
//
//  Created by William Cromb on 2014-12-02.
//  Copyright (c) 2014 William Cromb. All rights reserved.
//

//import sodukuSolver NOPE
import Cocoa
import XCTest

func logBoard(board: [Int?]){
    NSLog(prettyPrintBoard(board))
}

class sodukuSolverTests: XCTestCase {
    /// empty board
    let BD1 = [Int?](count:81, repeatedValue: nil)
    
    let BD2: [Int?] = [1,2,3,4,5,6,7,8,9] + [Int?](count: 81-9, repeatedValue: nil)
    let BD3: [Int?] = [ 1, nil, nil, nil, nil, nil, nil, nil, nil,
                        2, nil, nil, nil, nil, nil, nil, nil, nil,
                        3, nil, nil, nil, nil, nil, nil, nil, nil,
                        4, nil, nil, nil, nil, nil, nil, nil, nil,
                        5, nil, nil, nil, nil, nil, nil, nil, nil,
                        6, nil, nil, nil, nil, nil, nil, nil, nil,
                        7, nil, nil, nil, nil, nil, nil, nil, nil,
                        8, nil, nil, nil, nil, nil, nil, nil, nil,
                        9, nil, nil, nil, nil, nil, nil, nil, nil]
    let BD4: [Int?] = [2,   7,   4,   nil, 9,   1,   nil, nil, 5,
                       1,   nil, nil, 5,   nil, nil, nil, 9,   nil,
                       6,   nil, nil, nil, nil, 3,   2,   8,   nil,
                       nil, nil, 1,   9,   nil, nil, nil, nil, 8,
                       nil, nil, 5,   1,   nil, nil, 6,   nil, nil,
                       7,   nil, nil, nil, 8,   nil, nil, nil, 3,
                       4,   nil, 2,   nil, nil, nil, nil, nil, 9,
                       nil, nil, nil, nil, nil, nil, nil, 7,   nil,
                       8,   nil, nil, 3,   4,   9,   nil, nil, nil]
    let BD4s: [Int?] = [2, 7, 4, 8, 9, 1, 3, 6, 5,
                        1, 3, 8, 5, 2, 6, 4, 9, 7,
                        6, 5, 9, 4, 7, 3, 2, 8, 1,
                        3, 2, 1, 9, 6, 4, 7, 5, 8,
                        9, 8, 5, 1, 3, 7, 6, 4, 2,
                        7, 4, 6, 2, 8, 5, 9, 1, 3,
                        4, 6, 2, 7, 5, 8, 1, 3, 9,
                        5, 9, 3, 6, 1, 2, 8, 7, 4,
                        8, 1, 7, 3, 4, 9, 5, 2, 6]
    let BD5: [Int?] = [5,   nil, nil, nil, nil, 4,   nil, 7,   nil,
                       nil, 1,   nil, nil, 5,   nil, 6,   nil, nil,
                       nil, nil, 4,   9,   nil, nil, nil, nil, nil,
                       nil, 9,   nil, nil, nil, 7,   5,   nil, nil,
                       1,   8,   nil, 2,   nil, nil, nil, nil, nil,
                       nil, nil, nil, nil, nil, 6,   nil, nil, nil,
                       nil, nil, 3,   nil, nil, nil, nil, nil, 8,
                       nil, 6,   nil, nil, 8,   nil, nil, nil, 9,
                       nil, nil, 8,   nil, 7,   nil, nil, 3,   1]
    let BD5s: [Int?] = [5, 3, 9, 1, 6, 4, 8, 7, 2,
                        8, 1, 2, 7, 5, 3, 6, 9, 4,
                        6, 7, 4, 9, 2, 8, 3, 1, 5,
                        2, 9, 6, 4, 1, 7, 5, 8, 3,
                        1, 8, 7, 2, 3, 5, 9, 4, 6,
                        3, 4, 5, 8, 9, 6, 1, 2, 7,
                        9, 2, 3, 5, 4, 1, 7, 6, 8,
                        7, 6, 1, 3, 8, 2, 4, 5, 9,
                        4, 5, 8, 6, 7, 9, 2, 3, 1]
    let BD6: [Int?] = [nil, nil, 5,   3,   nil, nil, nil, nil, nil,
                       8,   nil, nil, nil, nil, nil, nil, 2,   nil,
                       nil, 7,   nil, nil, 1,   nil, 5,   nil, nil,
                       4,   nil, nil, nil, nil, 5,   3,   nil, nil,
                       nil, 1,   nil, nil, 7,   nil, nil, nil, 6,
                       nil, nil, 3,   2,   nil, nil, nil, 8,   nil,
                       nil, 6,   nil, 5,   nil, nil, nil, nil, 9,
                       nil, nil, 4,   nil, nil, nil, nil, 3,   nil,
                       nil, nil, nil, nil, nil, 9,   7,   nil, nil]
    
    let BD7: [Int?] = [1,   2,   3,   4,   5,   6,   7,   8,   nil,
                       nil, nil, nil, nil, nil, nil, nil, nil, 2,
                       nil, nil, nil, nil, nil, nil, nil, nil, 3,
                       nil, nil, nil, nil, nil, nil, nil, nil, 4,
                       nil, nil, nil, nil, nil, nil, nil, nil, 5,
                       nil, nil, nil, nil, nil, nil, nil, nil, 6,
                       nil, nil, nil, nil, nil, nil, nil, nil, 7,
                       nil, nil, nil, nil, nil, nil, nil, nil, 8,
                       nil, nil, nil, nil, nil, nil, nil, nil, 9]
    
    
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        //logBoard(BD4)
    }
    
     override func tearDown()
    {
        //teardown code goes here
        super.tearDown()

    }
    
    func testPosIndex(){
        XCTAssert(sodukuPos(row: 1, col: 1).toIndex() == 0, "sodukuPos.toIndex failed to convert 1,1")
        XCTAssert(sodukuPos(row: 9, col: 9).toIndex() == 80, "sodukuPos.toIndex failed to convert 9,9")
        XCTAssert(sodukuPos(row: 2, col: 1).toIndex() == 1, "sodukuPos.toIndex failed to convert 2,1")
        XCTAssert(sodukuPos(row: 2, col: 3).toIndex() == 19, "sodukuPos.toIndex failed to convert 2,1")
    }
    
    func testSodukuBoardValid(){
        XCTAssert(sodukuBoard(array: BD1).valid, "Empty Board should be valid")
        XCTAssert(sodukuBoard(array: BD2).valid, "BD2 should be valid")
        XCTAssert(sodukuBoard(array: BD3).valid, "BD3 Should be valid")
        var invalidBD = [2] + BD2[1..<81]
        XCTAssert(!sodukuBoard(array: invalidBD).valid, "invalid board shouldn't pass")
        invalidBD = [2] + BD3[1..<81]
        XCTAssert(!sodukuBoard(array: invalidBD).valid, "invalid board shouldn't pass")
        var invalidBD2 = sodukuBoard(array: BD4)
        invalidBD2.setValueAtPos(sodukuPos(row: 2, col: 1), value: 6)
        XCTAssert(!invalidBD2.valid, "invalid board shouldn't pass")
    }
    
    func testSolve(){
        let bd4 = sodukuBoard(array: BD4)
        let bd4solved = bd4.solve()
        XCTAssert(bd4solved != nil, "BD4 should be solvabe")
        XCTAssert(bd4solved != nil && bd4solved!.isEqualToBoard(sodukuBoard(array: BD4s)), "BD4 should solve as BD4s")
        let bd5 = sodukuBoard(array: BD5)
        let bd5solved = bd5.solve()
        XCTAssert(bd5solved != nil, "BD5 should be solvable")
        XCTAssert(bd5solved != nil && bd5solved!.isEqualToBoard(sodukuBoard(array: BD5s)), "BD5 should solve as BD5s")
        let bd7 = sodukuBoard(array: BD7)
        XCTAssert(bd7.solve() == nil, "BD7 should be unsolvable")
    }
    
}
