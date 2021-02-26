//
//  ViewController.swift
//  memoryApp
//
//  Created by diana on 2/22/21.
//

import UIKit
import Foundation

class ViewController: UIViewController , UICollectionViewDelegate , UICollectionViewDataSource  {

    var gameTime :Timer?
    var count:Int = 60

    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var scoreLabel: UILabel!
    
    
    var cardsArray = [Card]()
    var model = CardModel(num: 2)
    
    
    
    var firstFlippedCardIndex:IndexPath?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
        
        collectionView.delegate = self
        collectionView.dataSource = self
  

        
        cardsArray = model.getCard()
        
    
        
        gameTime = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerFired), userInfo: nil, repeats: true)

        
    }
    
    @objc func timerFired(){
           count -= 1

           scoreLabel.text = String(count)
           if count == 0 {
               
               scoreLabel.textColor = UIColor.red
               gameTime?.invalidate()
               checkEndGame()
           }
           
       }
    
    
    @IBAction func changeLevel(_ sender: UIButton) {
        
        count = 60
        
        let alert = UIAlertController(title: "اختيار مستوى اللعبة", message: "اختر مستواك الحالي", preferredStyle: .alert)
        
        
        let first = UIAlertAction(title: "المستوى الأول", style: .default) { action in
            
            self.model = CardModel(num: 2)
            self.cardsArray = self.model.getCard()
            self.collectionView.reloadData()
            
        }
        let second = UIAlertAction(title: "المستوى الثاني", style: .default) { action in
            
            self.model = CardModel(num: 4)
            self.cardsArray = self.model.getCard()
            self.collectionView.reloadData()
            
        }
        
        let third = UIAlertAction(title: "المستوى الثالث", style: .default) { action in
            
            self.model = CardModel(num: 6)
            self.cardsArray = self.model.getCard()
            self.collectionView.reloadData()
            
        }
        
        
        
        
        alert.addAction(first)
        alert.addAction(second)

        alert.addAction(third)

        self.present(alert, animated: true, completion: nil)

    }
    
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //  number of all cell
        
        return cardsArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cardCell", for: indexPath) as! CardCollectionViewCell
        
        return cell
        
        
    }
    
    
   
    
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        let cardCell = cell as? CardCollectionViewCell
        
        
        let card = cardsArray[indexPath.row]
        
        cardCell?.configureCell(card: card)
        
        
      //  cardCell?.alpha = 1
    }
    

    
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let cell = collectionView.cellForItem(at: indexPath) as? CardCollectionViewCell
        
        
        if cell?.card?.isFlipped == false && cell?.card?.isMatched == false {
            
            cell?.flipUp()
            
            if firstFlippedCardIndex == nil {
                
                firstFlippedCardIndex = indexPath
                print(firstFlippedCardIndex)
                
            }else{
                checkForMatch(indexPath)
            }
    
        }
        
        
        
        
    }
    
    func checkForMatch(_ secondFlippedIndex : IndexPath){
        
        let cardOne = cardsArray[firstFlippedCardIndex!.row]
        let cardTwo = cardsArray[secondFlippedIndex.row]
        
        
        
        let cardOneCell = collectionView.cellForItem(at: firstFlippedCardIndex!) as? CardCollectionViewCell
        let cardTwoCell = collectionView.cellForItem(at: secondFlippedIndex) as? CardCollectionViewCell
        
        
        if cardOne.imageName == cardTwo.imageName {
            cardOne.isMatched = true
            cardTwo.isMatched = true
            
            cardOneCell?.remove()
            cardTwoCell?.remove()
            
            
            checkEndGame()
        }else{
            
            cardOne.isFlipped = false
            cardTwo.isFlipped = false

            cardOneCell?.flipDown()
            cardTwoCell?.flipDown()
            
            
        }
        
        firstFlippedCardIndex = nil
    }
    
    func checkEndGame(){
        
        var hasWon = true
        
        
        for card in cardsArray {
            
            if card.isMatched == false{
                hasWon = false
                break
            }
        }
        
        
        if hasWon == true{
            print("you win")
        }else{
            
            if count <= 0 {
                print("Time is up")
            }
            
        }
        
        
        
        
        
        
    }
    

}

