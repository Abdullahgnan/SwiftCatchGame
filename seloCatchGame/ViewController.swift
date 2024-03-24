//
//  ViewController.swift
//  seloCatchGame
//
//  Created by ABDULLAH GÜNAN on 23.03.2024.
//

import UIKit

class ViewController: UIViewController {
    var kennyArray = [UIImageView]()
    var score = 0
    var timer = Timer()
    var hideTimer = Timer()
    var count = 0
    var highscore = 0
    
    
        
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var highScoreLabel: UILabel!
    @IBOutlet weak var kenny1: UIImageView!
    @IBOutlet weak var kenny2: UIImageView!
    @IBOutlet weak var kenny3: UIImageView!
    @IBOutlet weak var kenny4: UIImageView!
    @IBOutlet weak var kenny5: UIImageView!
    @IBOutlet weak var kenny6: UIImageView!
    @IBOutlet weak var kenny7: UIImageView!
    @IBOutlet weak var kenny8: UIImageView!
    @IBOutlet weak var kenny9: UIImageView!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let storedHighScore = UserDefaults.standard.object(forKey: "highscore")
        if storedHighScore == nil {
            highscore = 0
            highScoreLabel.text = String(highscore)
        }
        if let newScore = storedHighScore as? Int {
            highscore = newScore
            highScoreLabel.text = String(highscore)
        }
        
      
        kenny1.isUserInteractionEnabled = true
        kenny2.isUserInteractionEnabled = true
        kenny3.isUserInteractionEnabled = true
        kenny4.isUserInteractionEnabled = true
        kenny5.isUserInteractionEnabled = true
        kenny6.isUserInteractionEnabled = true
        kenny7.isUserInteractionEnabled = true
        kenny8.isUserInteractionEnabled = true
        kenny9.isUserInteractionEnabled = true
        
        let recogizer1 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recogizer2 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recogizer3 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recogizer4 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recogizer5 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recogizer6 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recogizer7 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recogizer8 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recogizer9 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        
        kenny1.addGestureRecognizer(recogizer1)
        kenny2.addGestureRecognizer(recogizer2)
        kenny3.addGestureRecognizer(recogizer3)
        kenny4.addGestureRecognizer(recogizer4)
        kenny5.addGestureRecognizer(recogizer5)
        kenny6.addGestureRecognizer(recogizer6)
        kenny7.addGestureRecognizer(recogizer7)
        kenny8.addGestureRecognizer(recogizer8)
        kenny9.addGestureRecognizer(recogizer9)
        
        kennyArray = [kenny1,kenny2,kenny3,kenny4,kenny5,kenny6,kenny7,kenny8,kenny9]
        count = 10
        timeLabel.text! = String(count)
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(countDown), userInfo: nil, repeats: true )
        hideTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(hideKenny), userInfo: nil, repeats: true)
        
        
    }
    @objc func hideKenny(){
        for keny in kennyArray {
            keny.isHidden = true
        }
        let random = Int(arc4random_uniform(UInt32(kennyArray.count - 1)))
        kennyArray[random].isHidden = false
        
    }
    
    @objc func countDown(){
    count -= 1
    timeLabel.text! = String(count)
        if count == 0 {
            timer.invalidate()
            hideTimer.invalidate()
            
            let alert = UIAlertController(title: "Game Over", message: "Do you wanna play", preferredStyle: UIAlertController.Style.alert)
             let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: nil)
            let replayButton = UIAlertAction(title: "Replay", style: UIAlertAction.Style.default) { [self] UIAlertAction in
                score = 0
                scoreLabel.text = String(self.score)
                count = 10
                timeLabel.text = String(self.count)
                
                timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(countDown), userInfo: nil, repeats: true )
                hideTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(hideKenny), userInfo: nil, repeats: true)
             }
             alert.addAction(okButton)
             alert.addAction(replayButton)
             present(alert, animated: true, completion: nil)
            
        }
        for keny in kennyArray {
            keny.isHidden = true
        }
        if self.score > self.highscore {
            highscore = score
            highScoreLabel.text = String(highscore)
            UserDefaults.standard.set(highscore, forKey: "highscore")

        }
        
    }
    @objc func increaseScore() {
        score += 1
        scoreLabel.text = String(score)
        
    }

}

