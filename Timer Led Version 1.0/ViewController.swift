//
//  ViewController.swift
//  Timer Led Version 1.0
//
//  Created by Viet Anh Doan on 5/18/17.
//  Copyright © 2017 Viet. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var numberTextField: UITextField!
    var lastOnLed = 0
    var direction = "right"
    var b = 1, n = 0
    var timer:Timer!
    @IBOutlet weak var ballView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func initBalls() {
        for view in ballView.subviews {
            view.removeFromSuperview()
        }
        if let input = Int(numberTextField.text!){
            if input>0 && input<100 {
                n = input
                for i in 1...n {
                    for j in 1...n {
                        let image = UIImage(named: "green")
                        let ball = UIImageView(image: image)
                        ball.center = CGPoint(x: CGFloat(i) * horizontalSpace(), y:CGFloat(j) * verticalSpace())
                        ball.tag = i + j * 100
                        ballView.addSubview(ball)
                    }
                }
            }
            else {
                print("number should be from 1 to 100")
            }
        }
        else {
            print("invalid number")
        }
    }
    
    func horizontalSpace() -> CGFloat {
        let space = self.view.bounds.size.width/CGFloat(n+1)
        return space
    }
    
    func verticalSpace() -> CGFloat {
        return (self.view.bounds.size.height-70)/CGFloat(n+1)
    }
    
    @IBAction func drawButtonAction(_ sender: UIButton) {
        lastOnLed = 0
        direction = "right"
        b = 1
        initBalls()
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(runningLed), userInfo: nil, repeats: true)
    }
    func runningLed() {
        if lastOnLed != 0 {
            turnOffLed()
        }
        if n<=b{
            direction = "rLeft"
            n += 1
            b -= 1
        }
        if lastOnLed == 1 && direction == "rLeft" {
            direction = "right"
            n -= 1
            b += 1
        }
        switch direction {
        case "right":
            if lastOnLed % 100 < n {
                lastOnLed += 1
            }
            else {
                direction = "down"
                turnOffLed()
                lastOnLed += 100
                print("right to down:\(lastOnLed)")
            }
        case "down":
            if lastOnLed < (n-1)*100 + n {
                lastOnLed += 100
            }
            else {
                direction = "left"
                turnOffLed()
                lastOnLed -= 1
                print("down to left:\(lastOnLed)")
            }
        case "left":
            if lastOnLed > (n-1)*100 + b {
                lastOnLed -= 1
            }
            else {
                direction = "up"
                turnOffLed()
                lastOnLed -= 100
                print("left to up:\(lastOnLed)")
            }
        case "up":
            if lastOnLed > b * 100 + b {
                lastOnLed -= 100
            }
            else {
                direction = "right"
                n -= 1
                b += 1
                turnOffLed()
                lastOnLed += 1
                print("up to right:\(lastOnLed)")
            }
        case "rLeft":
            if lastOnLed % 100 > b {
                lastOnLed -= 1
            }
            else {
                direction = "rDown"
                turnOffLed()
                lastOnLed += 100
                print("rLeft to rDown:\(lastOnLed)")
            }
        case "rDown":
            if lastOnLed < (n-1)*100 + b {
                lastOnLed += 100
            }
            else {
                direction = "rRight"
                turnOffLed()
                lastOnLed += 1
                print("rDown to rRight:\(lastOnLed)")
            }
        case "rRight":
            if lastOnLed < (n-1)*100 + n {
                lastOnLed += 1
            }
            else {
                direction = "rUp"
                turnOffLed()
                lastOnLed -= 100
                print("rRight to rUp:\(lastOnLed)")
            }
        case "rUp":
            if lastOnLed > (b-1) * 100 + n {
                lastOnLed -= 100
            }
            else {
                direction = "rLeft"
                n += 1
                b -= 1
                turnOffLed()
                lastOnLed -= 1
                print("rUp to rLeft:\(lastOnLed)")
            }
        default:
            print("what?")
        }
        turnOnLed()
    }
    
    func turnOnLed() {
        if let ball = self.view.viewWithTag(100 + lastOnLed) as? UIImageView
        {
            ball.image = UIImage(named: "green")
        }
    }
    
    func turnOffLed() {
        if let ball = self.view.viewWithTag(100 + lastOnLed) as? UIImageView
        {
            ball.image = UIImage(named: "grey")
        }
    }
    
    
}

