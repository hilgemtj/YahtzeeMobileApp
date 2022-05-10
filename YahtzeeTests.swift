//
//  YahtzeeTests.swift
//  YahtzeeTests
//
//  Created by Tyler Hilgeman on 4/27/22.
//

import XCTest
@testable import Yahtzee

class YahtzeeTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        super.setUp()
        var calculator = myCalculator()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testChance() throws {
        var testVals:[Int] = [1,2,3,4,5]
        var calculator = myCalculator()
        calculator.butArray = testVals
        var num = calculator.chance()
        XCTAssertEqual(num, 15)
    }
    
    func testYahtzee() {
        var testVals:[Int] = [1,2,3,4,5]
        var calculator = myCalculator()
        calculator.butArray = testVals
        var num = calculator.yahtzee()
        XCTAssertEqual(num, 0)
        
        var testVals2:[Int] = [1,1,1,1,1]
        calculator.butArray = testVals2
        num = calculator.yahtzee()
        XCTAssertEqual(num, 50)
    }

    func testSStraight() {
        var testVals:[Int] = [1,2,3,4,1]
        var calculator = myCalculator()
        calculator.butArray = testVals
        var num = calculator.sstraight()
        XCTAssertEqual(num, 30)
        
        var testVals2:[Int] = [1,1,1,1,1]
        calculator.butArray = testVals2
        num = calculator.sstraight()
        XCTAssertEqual(num, 0)
        
        var testVals3:[Int] = [1,2,3,4,5]
        calculator.butArray = testVals3
        num = calculator.sstraight()
        XCTAssertEqual(num, 30)
        
    }
    
    func testLStraight() {
        var testVals:[Int] = [1,2,3,4,5]
        var calculator = myCalculator()
        calculator.butArray = testVals
        var num = calculator.lstraight()
        XCTAssertEqual(num, 40)
        
        var testVals2:[Int] = [1,1,1,1,1]
        calculator.butArray = testVals2
        num = calculator.lstraight()
        XCTAssertEqual(num, 0)
        
        var testVals3:[Int] = [1,2,3,4,1]
        calculator.butArray = testVals3
        num = calculator.lstraight()
        XCTAssertEqual(num, 0)
        
    }
    
    func testFullHouse() {
        var testVals:[Int] = [1,2,3,4,5]
        var calculator = myCalculator()
        calculator.butArray = testVals
        var num = calculator.fullHouse()
        XCTAssertEqual(num, 0)
        
        var testVals2:[Int] = [1,1,1,2,2]
        calculator.butArray = testVals2
        num = calculator.fullHouse()
        XCTAssertEqual(num, 25)
        
        var testVals3:[Int] = [1,1,2,2,3]
        calculator.butArray = testVals3
        num = calculator.fullHouse()
        XCTAssertEqual(num, 0)
    }
    
    func testThreeOf() {
        var testVals:[Int] = [3,3,3,4,5]
        var calculator = myCalculator()
        calculator.butArray = testVals
        var num = calculator.threeOf()
        XCTAssertEqual(num, 18)
        
        var testVals2:[Int] = [1,2,3,4,5]
        calculator.butArray = testVals2
        num = calculator.threeOf()
        XCTAssertEqual(num, 0)
        
        var testVals3:[Int] = [2,2,2,2,2]
        calculator.butArray = testVals3
        num = calculator.threeOf()
        XCTAssertEqual(num, 10)
        
    }
    
    func testFourOf() {
        var testVals:[Int] = [3,3,3,3,5]
        var calculator = myCalculator()
        calculator.butArray = testVals
        var num = calculator.fourOf()
        XCTAssertEqual(num, 17)
        
        var testVals2:[Int] = [1,2,3,4,5]
        calculator.butArray = testVals2
        num = calculator.fourOf()
        XCTAssertEqual(num, 0)
        
        var testVals3:[Int] = [2,2,2,2,2]
        calculator.butArray = testVals3
        num = calculator.fourOf()
        XCTAssertEqual(num, 10)
        
    }
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
