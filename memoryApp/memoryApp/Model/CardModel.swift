//
//  CardModel.swift
//  memoryApp
//
//  Created by diana on 2/22/21.
//

import Foundation


class CardModel {
    
    
    
    var num = 2
    
    init(num : Int) {
        self.num = num
    }
    func getCard() -> [Card] {
        
        
        var generatedNumber = [Int]()
        
        var generatedCard = [Card]()
        
        
        while generatedNumber.count < num {
            
            
            let randomNumber = Int.random(in: 1...19)  // 19 = number image in Assetes
            
            
            let cardOne = Card()
            let cardTwo = Card()
            
            
            cardOne.imageName = "card\(randomNumber)"
            cardTwo.imageName = "card\(randomNumber)"
            
            
            generatedCard+=[cardOne,cardTwo]
            print(generatedCard)
            
            
            generatedNumber.append(randomNumber)
            
            
            
        }
        generatedCard.shuffle()
        return generatedCard
  
    }

    
    
}
