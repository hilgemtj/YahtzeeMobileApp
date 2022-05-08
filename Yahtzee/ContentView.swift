//
//  ContentView.swift
//  Yahtzee
//
//  Created by Tyler Hilgeman on 4/27/22.
//

import SwiftUI
import AVFoundation

struct ContentView: View {
    
    let systemSoundID: SystemSoundID = 1325
    let rollID: SystemSoundID = 1109
    let buttonSound: SystemSoundID = 1306
    
    // Die values
    @State var isSelected = Array(repeating: false, count: 5)
    @State var dieVals:[Int] = [Int.random(in: 1...6), Int.random(in: 1...6), Int.random(in: 1...6), Int.random(in: 1...6), Int.random(in: 1...6)]
    
    // Game management
    @State var rollsLeft:Int = 3
    @State var turnsLeft:Int = 13
    @State var savedVals:[Int] = []
    
    @State var lockedVals:String = ""
    
    struct Category:Identifiable, Hashable {
        let id = UUID()
        var name:String
        var section:String
        var score:Int
        var isCompleted:Bool
    }
    
    @State var upperCategories = [
        Category(name: "Aces", section: "Upper", score: 0, isCompleted: false),
        Category(name: "Twos", section: "Upper", score: 0, isCompleted: false),
        Category(name: "Threes", section: "Upper", score: 0, isCompleted: false),
        Category(name: "Fours", section: "Upper", score: 0, isCompleted: false),
        Category(name: "Fives", section: "Upper", score: 0, isCompleted: false),
        Category(name: "Sixes", section: "Upper", score: 0, isCompleted: false)
    ]
    @State var upperScore:Int = 0
    let bonus:Int = 35
    @State var bonusPoints:Int = 0
    
    @State var lowerCategories = [
        Category(name: "3 of a kind", section: "Lower", score: 0, isCompleted: false),
        Category(name: "4 of a kind", section: "Lower", score: 0, isCompleted: false),
        Category(name: "Full House", section: "Lower", score: 0, isCompleted: false),
        Category(name: "Sm. Straight", section: "Lower", score: 0, isCompleted: false),
        Category(name: "Lg. Straight", section: "Lower", score: 0, isCompleted: false),
        Category(name: "Yahtzee", section: "Lower", score: 0, isCompleted: false),
        Category(name: "Chance", section: "Lower", score: 0, isCompleted: false)
    ]
    @State var lowerScore:Int = 0
    @State var numYahtzees:Int = 0
    @State var totalScore:Int = 0
    
    fileprivate func updateScores() {
        var calculator = myCalculator()
        calculator.butArray = dieVals
        let tempScores = calculator.allChecks()
        
        upperScore = 0
        
        // Upper
        for index in 0...5 {
            if(!self.upperCategories[index].isCompleted) {
                self.upperCategories[index].score = tempScores[index]
            }
            
            if(self.upperCategories[index].isCompleted == true) {
                upperScore = upperScore + self.upperCategories[index].score
            }
            
        }
        if(upperScore >= 63) {
            bonusPoints = bonus
        }
        
        
        // Lower
        lowerScore = 0
        for index in 0...6 {
            if(!self.lowerCategories[index].isCompleted) {
                self.lowerCategories[index].score = tempScores[index + 6]
            }
            if(self.lowerCategories[index].isCompleted == true) {
                lowerScore = lowerScore + self.lowerCategories[index].score
            }
            if(index == 5 && self.lowerCategories[5].isCompleted && self.lowerCategories[5].score == 50) {
                self.lowerCategories[5].score = tempScores[index + 6]
                self.lowerCategories[5].isCompleted = false
                numYahtzees += 1
            }
            
            
        }
    }
    
    fileprivate func resetDie() {
        rollsLeft = 2
        turnsLeft -= 1
        isSelected = Array(repeating: false, count: 5)
        dieVals = [Int.random(in: 1...6), Int.random(in: 1...6), Int.random(in: 1...6), Int.random(in: 1...6), Int.random(in: 1...6)]
        updateScores()
    }
    
    
    @State private var showingAlert = false
    
    
    fileprivate func resetGame() {
        isSelected = Array(repeating: false, count: 5)
        dieVals = [Int.random(in: 1...6), Int.random(in: 1...6), Int.random(in: 1...6), Int.random(in: 1...6), Int.random(in: 1...6)]
        lockedVals = ""
        rollsLeft = 3
        turnsLeft = 13
        upperCategories = [
            Category(name: "Aces", section: "Upper", score: 0, isCompleted: false),
            Category(name: "Twos", section: "Upper", score: 0, isCompleted: false),
            Category(name: "Threes", section: "Upper", score: 0, isCompleted: false),
            Category(name: "Fours", section: "Upper", score: 0, isCompleted: false),
            Category(name: "Fives", section: "Upper", score: 0, isCompleted: false),
            Category(name: "Sixes", section: "Upper", score: 0, isCompleted: false)
        ]
        upperScore = 0
        bonusPoints = 0
        lowerCategories = [
            Category(name: "3 of a kind", section: "Lower", score: 0, isCompleted: false),
            Category(name: "4 of a kind", section: "Lower", score: 0, isCompleted: false),
            Category(name: "Full House", section: "Lower", score: 0, isCompleted: false),
            Category(name: "Sm. Straight", section: "Lower", score: 0, isCompleted: false),
            Category(name: "Lg. Straight", section: "Lower", score: 0, isCompleted: false),
            Category(name: "Yahtzee", section: "Lower", score: 0, isCompleted: false),
            Category(name: "Chance", section: "Lower", score: 0, isCompleted: false)
        ]
        lowerScore = 0
        numYahtzees = 0
        totalScore = 0
    }
    
    fileprivate func getYahtzeeBonus() -> Int {
        if(numYahtzees == 0) {
            return 0
        } else if(numYahtzees == 1) {
            return 50
        } else {
            return ((numYahtzees - 1) * 100) + 50
        }
    }
    
    var body: some View {
        VStack {
            VStack {
                
                Image("logo-black")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 100)
                Text(String(turnsLeft) + " turns left")
                    .font(.title2)
                    .padding(.top, -20.0)
                
                HStack {
                    Button(action: {
                        AudioServicesPlaySystemSound(buttonSound)
                        isSelected[0].toggle();
                    }, label: {
                        Image(systemName: "die.face.\(dieVals[0])")
                            .resizable()
                            .frame(width: 60, height: 60)
                            .foregroundColor(isSelected[0] ? Color.red : Color.black)
                    })
                    Button(action: {
                        AudioServicesPlaySystemSound(buttonSound)
                        isSelected[1].toggle();
                    }, label: {
                        Image(systemName: "die.face.\(dieVals[1])")
                            .resizable()
                            .frame(width: 60, height: 60)
                            .foregroundColor(isSelected[1] ? Color.red : Color.black)
                    })
                    Button(action: {
                        AudioServicesPlaySystemSound(buttonSound)
                        isSelected[2].toggle();
                    }, label: {
                        Image(systemName: "die.face.\(dieVals[2])")
                            .resizable()
                            .frame(width: 60, height: 60)
                            .foregroundColor(isSelected[2] ? Color.red : Color.black)
                    })
                    Button(action: {
                        AudioServicesPlaySystemSound(buttonSound)
                        isSelected[3].toggle();
                    }, label: {
                        Image(systemName: "die.face.\(dieVals[3])")
                            .resizable()
                            .frame(width: 60, height: 60)
                            .foregroundColor(isSelected[3] ? Color.red : Color.black)
                    })
                    Button(action: {
                        AudioServicesPlaySystemSound(buttonSound)
                        isSelected[4].toggle();
                    }, label: {
                        Image(systemName: "die.face.\(dieVals[4])")
                            .resizable()
                            .frame(width: 60, height: 60)
                            .foregroundColor(isSelected[4] ? Color.red : Color.black)
                    })
                }
                
                // Roll Button
                if(rollsLeft == 3) {
                    Button(action: {
                        savedVals.removeAll()
                        lockedVals.removeAll()
                        for n in 0...4 {
                            isSelected[n] = false
                            dieVals[n] = Int.random(in: 1...6)
                        }
                        rollsLeft -= 1
                        updateScores()
                    },
                           label: {
                        VStack {
                            HStack {
                                Image(systemName: "dice.fill")
                                Text("Start Game")
                                    .font(.title)
                                    .fontWeight(.bold)
                                Image(systemName: "dice.fill")
                            }
                        }
                        .foregroundColor(Color.white)
                        .padding()
                        .background(.red)
                        .cornerRadius(10)
                        
                    })
                } else if (rollsLeft == -1){
                    Button(action: {
                        resetGame()
                    },
                           label: {
                        VStack {
                            HStack {
                                Image(systemName: "dice.fill")
                                Text("Start New Game")
                                    .font(.title)
                                    .fontWeight(.bold)
                                Image(systemName: "dice.fill")
                            }
                        }
                        .foregroundColor(Color.white)
                        .padding()
                        .background(.red)
                        .cornerRadius(10)
                        
                    })
                } else {
                    Button(action: {
                        AudioServicesPlaySystemSound(rollID)
                        if(rollsLeft > 0) {
                            savedVals.removeAll()
                            lockedVals.removeAll()
                            for n in 0...4 {
                                if(isSelected[n]) {
                                    savedVals.append(dieVals[n])
                                    lockedVals.append(String(dieVals[n]))
                                } else {
                                    dieVals[n] = Int.random(in: 1...6)
                                }
                            }
                            rollsLeft -= 1
                            var calculator = myCalculator()
                            calculator.butArray = dieVals
                            let tempScores = calculator.allChecks()
                            
                            // Upper
                            for index in 0...5 {
                                if(!self.upperCategories[index].isCompleted) {
                                    self.upperCategories[index].score = tempScores[index]
                                }
                            }
                            
                            // Lower
                            for index in 0...6 {
                                if(!self.lowerCategories[index].isCompleted) {
                                    self.lowerCategories[index].score = tempScores[index + 6]
                                }
                            }
                            
                            
                        }
                        
                    },
                           label: {
                        VStack {
                            HStack {
                                Image(systemName: "dice.fill")
                                Text("Roll")
                                    .font(.title3)
                                    .fontWeight(.bold)
                                Image(systemName: "dice.fill")
                                
                            }
                            
                            Text(String(rollsLeft) + " rolls left")
                                .font(.headline)
                        }
                        .foregroundColor(Color.white)
                        .padding()
                        .background(.red)
                        .cornerRadius(10)
                        
                    })
                }
                
                
                VStack {
                    
                    List {
                        Section(header: Text("Upper Section").font(.headline).fontWeight(.bold)) {
                            
                            //for var element in upperCategories {
                            
                            ForEach(upperCategories.indices) { index in
                                HStack {
                                    Text(self.upperCategories[index].name)
                                    Spacer()
                                    if(!self.upperCategories[index].isCompleted) {
                                        
                                        Button(action: {
                                            AudioServicesPlaySystemSound(buttonSound)
                                            self.upperCategories[index].isCompleted.toggle()
                                            resetDie()
                                            
                                            if(turnsLeft == 0) {
                                                showingAlert = true
                                                AudioServicesPlaySystemSound(systemSoundID)
                                            }
                                        },
                                               label: {
                                            Text(String(self.upperCategories[index].score)).foregroundColor(.red)
                                        })
                                    } else {
                                        Text(String(self.upperCategories[index].score)).foregroundColor(.black)
                                    }
                                    
                                }
                            }
                        }
                        Section(header: Text("Lower Section").font(.headline).fontWeight(.bold)) {
                            ForEach(lowerCategories.indices) { index in
                                HStack {
                                    Text(self.lowerCategories[index].name)
                                    Spacer()
                                    if(!self.lowerCategories[index].isCompleted) {
                                        Button(action: {
                                            AudioServicesPlaySystemSound(buttonSound)
                                            self.lowerCategories[index].isCompleted.toggle()
                                            resetDie()
                                            
                                            if(turnsLeft == 0) {
                                                showingAlert = true
                                                AudioServicesPlaySystemSound(systemSoundID)
                                            }
                                        },
                                               label: {
                                            Text(String(self.lowerCategories[index].score)).foregroundColor(.red)
                                        })
                                    } else {
                                        Text(String(self.lowerCategories[index].score)).foregroundColor(.black)
                                    }
                                    
                                }
                            }
                        }
                        
                        Section(header: Text("Upper Section Totals").font(.headline).fontWeight(.bold)) {
                            HStack {
                                Text("Upper Score: ")
                                    .font(.subheadline)
                                    .fontWeight(.bold)
                                Spacer()
                                Text(String(upperScore))
                                    .font(.subheadline)
                                    .fontWeight(.bold)
                            }
                            
                            HStack {
                                Text("Bonus if score is 63 or over: ")
                                    .font(.subheadline)
                                    .fontWeight(.bold)
                                Spacer()
                                Text(String(bonusPoints))
                                    .font(.subheadline)
                                    .fontWeight(.bold)
                            }
                            
                            HStack {
                                Text("Upper Total: ")
                                    .font(.subheadline)
                                    .fontWeight(.bold)
                                Spacer()
                                Text(String(upperScore + bonusPoints))
                                    .font(.subheadline)
                                    .fontWeight(.bold)
                            }
                        }
                        
                        Section(header: Text("Lower Section Totals").font(.headline).fontWeight(.bold)) {
                            HStack {
                                Text("Number of Yahtzees : ")
                                    .font(.subheadline)
                                    .fontWeight(.bold)
                                Spacer()
                                Text(String(numYahtzees))
                                    .font(.subheadline)
                                    .fontWeight(.bold)
                            }
                            
                            HStack {
                                Text("Yahtzee bonus : ")
                                    .font(.subheadline)
                                    .fontWeight(.bold)
                                Spacer()
                                Text(String(getYahtzeeBonus()))
                                    .font(.subheadline)
                                    .fontWeight(.bold)
                            }
                            
                            HStack {
                                Text("Lower Total: ")
                                    .font(.subheadline)
                                    .fontWeight(.bold)
                                Spacer()
                                Text(String(lowerScore + getYahtzeeBonus()))
                                    .font(.subheadline)
                                    .fontWeight(.bold)
                            }
                        }
                        
                        
                        HStack {
                            Text("Total Score: ")
                                .font(.headline)
                                .fontWeight(.bold)
                            Spacer()
                            Text(String(upperScore + bonusPoints + lowerScore + getYahtzeeBonus()))
                                .font(.headline)
                                .fontWeight(.bold)
                        }
                        
                    }.frame(height: 330).listStyle(.grouped)
                        .alert(isPresented: $showingAlert) {
                            Alert(
                                title: Text("You finished!"),
                                message: Text("Your score is " + String(upperScore + bonusPoints + lowerScore + getYahtzeeBonus())),
                                primaryButton: Alert.Button.default(
                                    Text("Review score"), action: {
                                        AudioServicesPlaySystemSound(buttonSound)
                                        rollsLeft = -1
                                    }
                                ),
                                secondaryButton: Alert.Button.default(
                                    Text("Start a new game"), action: {
                                        AudioServicesPlaySystemSound(buttonSound)
                                        resetGame()
                                    }
                                )
                            )
                        }
                }
            }
        }
    }
}




struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
        }
    }
}
