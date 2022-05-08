//
//  ScoreCalculations.swift
//  Yahtzee
//
//  Created by Nick Jones on 5/3/22.
//



struct myCalculator {
    var butArray:[Int] = []
    
    
    mutating func allChecks() -> [Int] { //dieVals:[Int]
        
        return [check1(), check2(), check3(), check4(), check5(), check6(), threeOf(), fourOf(), fullHouse(), sstraight(), lstraight(), yahtzee(), chance()]
    }
    
    func check1() -> Int {
        var score = 0
        
        for val in butArray {
            if (val == 1){
                score += 1
            }
        }
        return score
    }
    
    func check2() -> Int {
        var score = 0
        
        for val in butArray {
            if (val == 2){
                score += 2
            }
        }
        return score
    }
    
    func check3() -> Int {
        var score = 0
        
        for val in butArray {
            if (val == 3){
                score += 3
            }
        }
        return score
    }
    
    func check4() -> Int {
        var score = 0
        
        for val in butArray {
            if (val == 4){
                score += 4
            }
        }
        return score
    }
    
    func check5() -> Int {
        var score = 0
        
        for val in butArray {
            if (val == 5){
                score += 5
            }
        }
        return score
    }
    
    func check6() -> Int {
        var score = 0
        
        for val in butArray {
            if (val == 6){
                score += 6
            }
        }
        return score
    }
    
    func chance() -> Int {
        var score = 0
        
        for val in butArray {
            
            score += val
            
        }
        return score
    }
    
    func yahtzee() -> Int {
        var temp = 0;
        while temp < 4 {
            if( butArray[temp] != butArray[temp+1] ){
                return 0
            }
            
            temp += 1
        }
        return 50
    }
    
    func sstraight() -> Int {
        var one = false
        var two = false
        var three = false
        var four = false
        var five = false
        var six = false
        var temp = 0
        while temp < 5 {
            if( butArray[temp] == 1){
                one = true;
            }else if( butArray[temp] == 2){
                two = true;
            }else if( butArray[temp] == 3){
                three = true;
            }else if( butArray[temp] == 4){
                four = true;
            }else if( butArray[temp] == 5){
                five = true;
            }else if( butArray[temp] == 6){
                six = true;
            }
            temp += 1
        }
        
        if( (one && two && three && four) || (two && three && four && five) || (three && four && five && six)){
            return 30
        }else{
            return 0
        }
    }
    
    
    
    func lstraight() -> Int {
        var one = false;
        var two = false;
        var three = false;
        var four = false;
        var five = false;
        var six = false;
        var temp = 0;
        while temp < 5 {
            if( butArray[temp] == 1){
                one = true;
            }else if( butArray[temp] == 2){
                two = true;
            }else if( butArray[temp] == 3){
                three = true;
            }else if( butArray[temp] == 4){
                four = true;
            }else if( butArray[temp] == 5){
                five = true;
            }else if( butArray[temp] == 6){
                six = true;
            }
            temp += 1
        }
        
        if( (one && two && three && four && five) || (two && three && four && five && six)){
            return 40
        }else{
            return 0
        }
    }
    
    func fullHouse() -> Int {
        var count1 = 0
        var count2 = 0
        var count3 = 0
        var count4 = 0
        var count5 = 0
        var count6 = 0
        var temp = 0
        
        while temp < 5 {
            if( butArray[temp] == 1){
                count1 += 1
            }else if( butArray[temp] == 2){
                count2 += 1
            }else if( butArray[temp] == 3){
                count3 += 1
            }else if( butArray[temp] == 4){
                count4 += 1
            }else if( butArray[temp] == 5){
                count5 += 1
            }else if( butArray[temp] == 6){
                count6 += 1
            }
            temp += 1
        }
        
        if(count1 == 3 || count2 == 3 || count3 == 3 || count4 == 3 || count5 == 3 || count6 == 3){
            if(count1 == 2 || count2 == 2 || count3 == 2 || count4 == 2 || count5 == 2 || count6 == 2){
                return 25
            }
        }
        
        return 0
    }
    
    func threeOf() -> Int {
        var count1 = 0
        var count2 = 0
        var count3 = 0
        var count4 = 0
        var count5 = 0
        var count6 = 0
        var total = 0
        var temp = 0
        
        while temp < 5 {
            if( butArray[temp] == 1){
                count1 += 1
                total += 1
            }else if( butArray[temp] == 2){
                count2 += 1
                total += 2
            }else if( butArray[temp] == 3){
                count3 += 1
                total += 3
            }else if( butArray[temp] == 4){
                count4 += 1
                total += 4
            }else if( butArray[temp] == 5){
                count5 += 1
                total += 5
            }else if( butArray[temp] == 6){
                count6 += 1
                total += 6
            }
            temp += 1
        }
        
        if(count1 >= 3 || count2 >= 3 || count3 >= 3 || count4 >= 3 || count5 >= 3 || count6 >= 3){
            return total
        }
        return 0
        
    }
    
    func fourOf() -> Int {
        var count1 = 0
        var count2 = 0
        var count3 = 0
        var count4 = 0
        var count5 = 0
        var count6 = 0
        var total = 0
        var temp = 0
        
        while temp < 5 {
            if( butArray[temp] == 1){
                count1 += 1
                total += 1
            }else if( butArray[temp] == 2){
                count2 += 1
                total += 2
            }else if( butArray[temp] == 3){
                count3 += 1
                total += 3
            }else if( butArray[temp] == 4){
                count4 += 1
                total += 4
            }else if( butArray[temp] == 5){
                count5 += 1
                total += 5
            }else if( butArray[temp] == 6){
                count6 += 1
                total += 6
            }
            temp += 1
        }
        
        if(count1 >= 4 || count2 >= 4 || count3 >= 4 || count4 >= 4 || count5 >= 4 || count6 >= 4){
            return total
        }
        return 0
    }
    
}


