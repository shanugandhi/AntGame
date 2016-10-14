//
//  ViewController.swift
//  AntGame
//
//  Created by Shanu Gandhi on 10/9/16.
//  Copyright © 2016 Shanu Gandhi. All rights reserved.
//







import UIKit

class ViewController: UIViewController, UIGestureRecognizerDelegate {
    
    
    var scoreLabel : UILabel = UILabel()
    var timeLabel : UILabel = UILabel()
    var backgroundimageView : UIImageView = UIImageView()
    var antimageView: UIImageView = UIImageView()
    var Maintimer: Timer = Timer()
    var timer1: Timer = Timer()
    var timer2: Timer = Timer()
    var animator : UIDynamicAnimator!
    var tapGesture : UITapGestureRecognizer = UITapGestureRecognizer()
    var topScoresButton : UIButton = UIButton()
    var newgameButton : UIButton = UIButton()
    var gravityBehavior : UIGravityBehavior!
    var xvalue : Int = 0
    var yvalue : Int = 0
    var randomNum1 : Int = 0
    var randomNum2 : Int = 0
    var count : Int = 0
    var antimagearray : [UIImageView] = [UIImageView()]
    var time = 45
    var score = 0
    var finalscore = 0
    var managingtimer = 2
    
 
        
    
override func viewDidLoad() {
        super.viewDidLoad()
        createBackground()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    func createBackground()
    {
        let bimage : UIImage = UIImage(named: "background")!
        backgroundimageView = UIImageView(image: bimage)
        backgroundimageView.frame.origin = CGPoint(x: 0, y: 0)
        self.view.addSubview(backgroundimageView)
        self.backgroundimageView.bringSubview(toFront: antimageView)
        //self.backgroundimageView.bringSubview(toFront: antimageView)
        //generaterandomants()
        scoreLabel = UILabel()
        scoreLabel.text = "Score: " + String(score)
        scoreLabel.frame = CGRect(origin: CGPoint(x: 20, y: 20), size: CGSize(width: 89, height: 28))
        self.view.addSubview(scoreLabel)
        
        timeLabel = UILabel()
        timeLabel.text = "Timer: " + String(time)
        timeLabel.frame = CGRect(origin: CGPoint(x: 20, y: 40), size: CGSize(width: 89, height: 28))
        self.view.addSubview(timeLabel)
        
        newgameButton = UIButton(type: .system)
        newgameButton.setTitle("start new game", for: UIControlState())
        newgameButton.setTitleColor(UIColor.white, for: UIControlState())
        newgameButton.frame = CGRect(origin: CGPoint(x: 230, y: 20), size: CGSize(width: 160, height: 30))
        newgameButton.addTarget(self, action: #selector(ViewController.startnewgame), for: .touchUpInside)
        self.view.addSubview(newgameButton)
        topScoresButton = UIButton(type: .system)
        topScoresButton.setTitle("Top 5 Scores", for: UIControlState())
        topScoresButton.setTitleColor(UIColor.white, for: UIControlState())
        topScoresButton.frame = CGRect(origin: CGPoint(x: 138, y: 20), size: CGSize(width: 101, height: 30))
        topScoresButton.addTarget(self, action: #selector(ViewController.HighscoreButton), for: .touchUpInside)
        self.view.addSubview(topScoresButton)
        
}
    func startnewgame(){
        time = 45
        timer1.invalidate()
        timer2.invalidate()
        Maintimer.invalidate()
        finalscore = score
        savedetails()
        score = 0
        scoreLabel.text = "Score: " + String(0)
        Maintimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(ViewController.update), userInfo: nil, repeats: true)
        RunLoop.current.add(Maintimer, forMode: RunLoopMode.commonModes)
        startMovement()
    
    
    }
    func update(){
    
        time -= 1
       timeLabel.text = "Timer: " + String(time)
        if time == 0 {
            timeLabel.text = "Timer: " + String(0)
            print ("timeover")
            Maintimer.invalidate()
            timer1.invalidate()
            timer2.invalidate()
            finalscore = score
            savedetails()
          }
    
    
    
    }
    
    
    
    
    func generaterandomants()
    {
        let randomMaxrangeX = self.view.bounds.maxX
        let randomMaxrangeY = self.view.bounds.maxY
        randomNum1 = Int(arc4random_uniform(UInt32(randomMaxrangeX)))
        randomNum2 = Int(arc4random_uniform(UInt32(randomMaxrangeY)))
        xvalue = randomNum1
        yvalue = randomNum2
        let antimage : UIImage = UIImage(named: "ant")!
        antimageView = UIImageView(image: antimage)
        antimageView.frame.origin = CGPoint(x: xvalue, y: yvalue)
        antimageView.frame.size = CGSize(width: 50, height: 50.0)
        antimagearray.append(antimageView)
        self.view.addSubview(antimageView)
        self.view.bringSubview(toFront: antimageView)
        modifiedaddTapGesture(UIImageview: antimageView)
        antimagearray.append(antimageView)
        animator = UIDynamicAnimator(referenceView: view)
        gravityBehavior = UIGravityBehavior(items: [antimageView])
        gravityBehavior.magnitude = 0.01
        animator.addBehavior(gravityBehavior)
     
        
    }
    
    
    
    func startMovement()
    {
        
        timer1 = Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(ViewController.generaterandomants), userInfo: nil, repeats: true)
        RunLoop.current.add(timer1, forMode: RunLoopMode.commonModes)
        timer2 = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(ViewController.disappearants), userInfo: nil, repeats: true)
        
      RunLoop.current.add(timer2, forMode: RunLoopMode.commonModes)
       
    }
    
    
   
    func addTapGesture(UIImageview : UIImageView)
        
        {
            tapGesture = UITapGestureRecognizer(target: self, action: #selector(ViewController.tapped))
            tapGesture.numberOfTapsRequired = 1
            tapGesture.delegate = self
            tapGesture.isEnabled = true
            self.backgroundimageView.addSubview(antimageView)
            self.backgroundimageView.bringSubview(toFront: antimageView)
            
        }
    
    
    
    func modifiedaddTapGesture(UIImageview : UIImageView)
    {
        tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapped))
        tapGesture.numberOfTapsRequired = 1
        tapGesture.delegate = self
        tapGesture.isEnabled = true
        UIImageview.addGestureRecognizer(tapGesture)
        UIImageview.isUserInteractionEnabled = true
        
        
    
    }
    
    func tapped()
        
    {   score+=1
        antimageView.removeFromSuperview()
        scoreLabel.text = "Score: " + String(score)
        }
       
    func disappearants()
    {
    antimageView.removeFromSuperview()
    
    }
    
    
    func savedetails()
    {
        let defaults = UserDefaults.standard
        if(defaults.value(forKey: "HighScores") != nil)
        {
            if finalscore == 0{
                return
            }
            var Scores  = defaults.value(forKey: "HighScores") as! [Int]
            if(Scores.contains(finalscore))
            {
                return
            }
            if(Scores.count == 5)
            {
            var sortedScores = Scores.sorted()
            for this in sortedScores
            {
            if(finalscore > this)
            {
                sortedScores.append(finalscore)
                break
                }
            }
            var sortedScores2 = sortedScores.sorted()
            sortedScores2 = sortedScores2.reversed()
            sortedScores2.removeLast()
            UserDefaults.standard.set( sortedScores2, forKey: "HighScores")
            }
            
            else
            {
            if finalscore == 0{
                return
            }
            Scores.append(finalscore)
            let sortedScores = Scores.sorted()
            UserDefaults.standard.set( sortedScores, forKey: "HighScores")
            }
        }else
        {
            if finalscore == 0{
                return
            }
            let Scores : [Int] = [finalscore]
            UserDefaults.standard.set( Scores, forKey: "HighScores")
        }
    }
    
    func HighscoreButton()
    {
        var message : String = ""
        let defaults = UserDefaults.standard
        if(defaults.value(forKey: "HighScores") != nil)
        {
            let Scores : [Int] = defaults.value(forKey: "HighScores") as! [Int]
            var scoresString : String = ""
            for this in Scores
            {
                scoresString += "\n\(this)"
            }
            message = "***Hall of Fame***\(scoresString)"
        }else
        {
            message = "No scores as of now."
        }
        
        _ = UIAlertController(title: "Top 5 Scores are", message: message, preferredStyle: .alert)
        
        let alert = UIAlertController(title: "Top 5 Scores are", message: message, preferredStyle: .alert)
    
        let Close = UIAlertAction(title: "Close", style: .default, handler: {
            (theAction) -> Void in
            
            self.dismiss(animated: true, completion: nil)
            })
        
    alert.addAction(Close)
    self.present(alert, animated: true, completion: nil)
  
        
        }
    
    
    

}

