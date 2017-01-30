//
//  ViewController.swift
//  RetroCalculator
//
//  Created by Shashank Kannam on 9/30/16.
//  Copyright © 2016 Shashank Kannam. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
     buttonSoundURL()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

 var buttonSound:AVAudioPlayer!
    
    func buttonSoundURL()
    {
    
    let path = Bundle.main.path(forResource: "btn", ofType: "wav")
        
    let soundUrl = URL(fileURLWithPath: path!)
        
        
        do{
            try buttonSound = AVAudioPlayer(contentsOf: soundUrl)
            buttonSound.prepareToPlay()
        }
        catch let err as NSError!{
            print(err.debugDescription)
        }
    }
 
   
    
    func playSound()
    {
       
      if buttonSound.isPlaying
      {
        buttonSound.stop()
        }
        buttonSound.play()
    
        
    }
    
    var runningNumbr = ""
    @IBOutlet weak var valueLBL: UILabel!
    
    @IBAction func buttonsPressed(_ sender: UIButton!) {
        playSound()
       
         runningNumbr += "\(sender.tag)"
        
        valueLBL.text = runningNumbr
        
    }
   var leftStr = ""
    var rightStr = ""
    var result = ""
    
    enum Operations:String {
        case Divide="/"
        case Add="+"
        case Multiply="*"
        case Subtract="-"
        case Empty="empty"
        
    }
    var currentOperation = Operations.Empty
    @IBAction func multiply(_ sender: AnyObject) {
        processOPeration(operation: .Multiply)
            }
    
    @IBAction func divide(_ sender:AnyObject)
    {
        processOPeration(operation: .Divide)
    }
    @IBAction func subtract(_ sender:AnyObject)
    {
        processOPeration(operation: .Subtract)
    }
    @IBAction func add(_ sender:AnyObject)
    {
        processOPeration(operation: .Add)
    }
    @IBAction func equals(_ sender:AnyObject)
    {
       processOPeration(operation: currentOperation)
    }
    @IBAction func clear(_ sender: AnyObject) {
        playSound()
         leftStr = ""
         rightStr = ""
         result = ""
        runningNumbr = ""
        currentOperation=Operations.Empty
        valueLBL.text="0"
        
        
    }
    
    
    func processOPeration(operation: Operations)
    {
        playSound()
        
        if currentOperation != Operations.Empty
        {
            if runningNumbr != ""
            {
                rightStr=runningNumbr
                runningNumbr=""
                if currentOperation == Operations.Add
                {
                    result = "\(Double(leftStr)!+Double(rightStr)!)"
                }
                else if currentOperation == Operations.Subtract
                {
                    result = String(Double(leftStr)!-Double(rightStr)!)
                }
                else if currentOperation == Operations.Multiply
                {
                    result = String(Double(leftStr)!*Double(rightStr)!)
                }
                else if currentOperation == Operations.Divide
                {
                    result = String(Double(leftStr)!/Double(rightStr)!)
                }
                leftStr=result
                valueLBL.text=result
            }
            
            currentOperation = operation
        }
        else{
            leftStr=runningNumbr
            runningNumbr=""
            currentOperation=operation
        }
        
    }
   
    
    
   }

