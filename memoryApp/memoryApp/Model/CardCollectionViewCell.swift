//
//  CardCollectionViewCell.swift
//  memoryApp
//
//  Created by diana on 2/22/21.
//

import UIKit

class CardCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var backImageview: UIImageView!
    
    
    @IBOutlet weak var frontImageview: UIImageView!
    
    var card : Card?
    
    func configureCell (card : Card){
        
        self.card = card
        
        
        
        frontImageview.image = UIImage(named: card.imageName)
        
        
        
        
        if card.isMatched == true {
            backImageview.alpha = 0
            frontImageview.alpha = 0

            return
        }else{
            backImageview.alpha = 1
            frontImageview.alpha = 1
     
        }
        
        
        if card.isFlipped == true {
            flipUp(speed : 0)
            
            
            
        }else{
            
            flipDown(speed: 0.3, delay: 0.5)
      
        }
  
        
    }
    
    
    func flipUp (speed: TimeInterval = 0.3) {
        
        
        UIView.transition(from: backImageview, to: frontImageview, duration: speed, options: [.showHideTransitionViews , .transitionFlipFromLeft], completion: nil)
        
    }
    
    
    
    func flipDown(speed : TimeInterval = 0.3 , delay: TimeInterval = 0.5 ){
        
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + delay) {
            
            UIView.transition(from: self.frontImageview, to: self.backImageview, duration: speed, options: [.showHideTransitionViews , .transitionFlipFromLeft], completion: nil)
            
        }

    }
    
    
    
    func remove() {
        
        backImageview.alpha = 0
        
        UIView.animate(withDuration: 0.3, delay: 0.5, options: .curveEaseOut, animations: {
            self.frontImageview.alpha = 0
        }, completion: nil)
        
    }
    
    
    
}
