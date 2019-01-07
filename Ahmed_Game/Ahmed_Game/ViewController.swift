//
//  ViewController.swift
//  Ahmed_Game
//
//  Created by ah18acv on 05/11/2018.
//  Copyright © 2018 CSStestuser. All rights reserved.
//



import UIKit

protocol  subviewDelegate{
    func changeSomething()
}

class ViewController: UIViewController, subviewDelegate {
    
    
    func changeSomething(){
        collisionBehaviour.removeAllBoundaries()
        collisionBehaviour.addBoundary(withIdentifier: "barrier" as NSCopying,for: UIBezierPath(rect:pidgeot.frame))
        addScore()
    }

    //Score for the game
    var gameScore = 0
    
    //Screen fit
    let W = UIScreen.main.bounds.width
    let H = UIScreen.main.bounds.height
    
    //Behaviours and Animators
    var dynamicAnimator: UIDynamicAnimator!
    var dynamicBehaviour:UIDynamicItemBehavior!
    var gravityBehaviour: UIGravityBehavior!
    var collisionBehaviour: UICollisionBehavior!
    
    //Image links
    @IBOutlet weak var pidgeot: UIImageView!
    @IBOutlet weak var cloud1: UIImageView!
    @IBOutlet weak var cloud2: UIImageView!
    @IBOutlet weak var cloud3: UIImageView!
    @IBOutlet weak var cloud4: UIImageView!
    
    //End game links
    @IBOutlet weak var gameOver: UIImageView!
    
    @IBOutlet weak var scoreLabel: UILabel!
    
    //loops
    let coinArray1 = [0,2,4,6,8,10,12,14,16,18]
    let pokeArray1 = [0,2,4,6,8,10,12,14,16,18]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //Screen fit for ending
        
        dynamicAnimator = UIDynamicAnimator(referenceView: self.view)
        dynamicBehaviour = UIDynamicItemBehavior(items: [])
        dynamicAnimator.addBehavior(dynamicBehaviour)
        collisionBehaviour = UICollisionBehavior(items: [])
        dynamicAnimator.addBehavior(collisionBehaviour)
        gravityBehaviour = UIGravityBehavior(items: [])
        
        //Pidgeot - Player character
        var pidgeotArray: [UIImage]!
    
        pidgeotArray =
        [UIImage(named: "Piget.png")!,
        UIImage(named:"Piget2.png")!,
        UIImage(named:"Piget3.png")!,
        UIImage(named:"Piget4.png")!]
    
        pidgeot.image = UIImage.animatedImage(with: pidgeotArray, duration: 0.5)
        pidgeot.frame = CGRect(x:0, y: H*(0.33), width: W*(0.16), height: H*(0.12))
        
        //Coin - Collectible
        
        for index in 0...9{
            
            let delay = Double(self.coinArray1[index])
            let release  = DispatchTime.now() + delay
            DispatchQueue.main.asyncAfter(deadline: release){
                let coinImage = UIImageView(image: nil)
                var coinArray: [UIImage]!
        
        coinArray =
            [UIImage(named: "Coin_1.png")!,
             UIImage(named:"Coin_2.png")!,
             UIImage(named:"Coin_3.png")!,
             UIImage(named:"Coin_4.png")!,
             UIImage(named:"Coin_5.png")!,
             UIImage(named:"Coin_6.png")!,
             UIImage(named:"Coin_7.png")!,
             UIImage(named:"Coin_8.png")!,
             UIImage(named:"Coin_9.png")!,
             UIImage(named:"Coin_10.png")!]
             
                //Coin speed and positioning
             coinImage.image = UIImage.animatedImage(with: coinArray, duration: 0.5)
                coinImage.frame = CGRect(x:self.W, y:CGFloat(arc4random_uniform(UInt32(self.H)-100)), width: self.W*(0.05), height: self.H*(0.05))
                
                self.view.addSubview(coinImage)
                self.view.bringSubview(toFront: coinImage)
                self.dynamicBehaviour.addItem(coinImage)
                
                //Coin speed setting
                self.dynamicBehaviour.addLinearVelocity(CGPoint(x: -300, y: 0), for: coinImage)
                self.collisionBehaviour.addItem(coinImage)
                
                //Removing coins after collision
                self.collisionBehaviour.action =
                    {if coinImage.frame.intersects(self.pidgeot.frame){
                        coinImage.removeFromSuperview()
                        }
                        
                                       }
            }
 
        //Pokeball - Enemy
        
        for index2 in 0 ... 9 {
        let delay = Double(self.pokeArray1[index2])
        let release = DispatchTime.now() + delay
            DispatchQueue.main.asyncAfter(deadline: release){
                
        let pokeballImage = UIImageView(image: nil)
        var pokeArray: [UIImage]!
        
        pokeArray =
            [UIImage(named: "Pokeball_1.png")!,
             UIImage(named:"Pokeball_2.png")!,
             UIImage(named:"Pokeball_3.png")!,
             UIImage(named:"Pokeball_4.png")!,
             UIImage(named:"Pokeball_5.png")!,
             UIImage(named:"Pokeball_6.png")!,
             UIImage(named:"Pokeball_7.png")!,
             UIImage(named:"Pokeball_8.png")!]
                
        //Pokeball speed and positioning
        pokeballImage.image = UIImage.animatedImage(with: pokeArray, duration: 1.0)
        pokeballImage.frame = CGRect (x: 800, y: CGFloat(arc4random_uniform(UInt32(self.H)-100)), width: self.W*(0.05), height: self.H*(0.05))
                
                self.view.addSubview(pokeballImage)
                self.view.bringSubview(toFront: pokeballImage)
                self.dynamicBehaviour.addItem(pokeballImage)
                
                //Pokeball speed setting
                self.dynamicBehaviour.addLinearVelocity(CGPoint(x: -200, y: 0), for: pokeballImage)
                self.collisionBehaviour.addItem(pokeballImage)
        
            }
        //Animation of clouds
        //Cloud 1
        UIView.animate(withDuration: 1.0, delay: 0.0, options: [UIViewAnimationOptions.repeat, .curveLinear], animations:
            {
                self.cloud1.center.x -= self.view.bounds.width
        }, completion: nil
        )
        
        //Cloud 2
        UIView.animate(withDuration: 1.2, delay: 0.0, options: [UIViewAnimationOptions.repeat, .curveLinear], animations:
            {
                self.cloud2.center.x -= self.view.bounds.width
        }, completion: nil
        )
        	
        //Cloud 3
        UIView.animate(withDuration: 1.5, delay: 0.0, options: [UIViewAnimationOptions.repeat, .curveLinear], animations:
            {
                self.cloud3.center.x -= self.view.bounds.width
        }, completion: nil
        )
        
        //Cloud 4
        UIView.animate(withDuration: 2.0, delay: 0.0, options: [UIViewAnimationOptions.repeat, .curveLinear], animations:
            {
                self.cloud4.center.x -= self.view.bounds.width
        }, completion: nil
        )
        
    }
        }
  
    //Timer
    let timer = DispatchTime.now() + 20
    DispatchQueue.main.asyncAfter(deadline: timer){
        
        self.gameOver.alpha = 1
    
    }
    }
    func addScore(){
        gameScore += 1
        scoreLabel.text = "Score: \(gameScore)"
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


