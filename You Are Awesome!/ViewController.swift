//
//  ViewController.swift
//  You Are Awesome!
//
//  Created by John Linnehan on 8/30/21.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var playSoundSwitch: UISwitch!
    @IBOutlet weak var imageView: UIImageView!
    
    var imageNumber = -1
    var messageNumber = -1
    var soundNumber = -1
    let totNumImages = 9
    let totNumSounds = 6
    var audioPlayer: AVAudioPlayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        messageLabel.text = ""
    }
    
    func playSound(name: String) {
        if let sound = NSDataAsset(name: name) {
            do {
                try audioPlayer = AVAudioPlayer(data: sound.data)
                audioPlayer.play()
            } catch {
                print("😡 ERROR: \(error.localizedDescription)could not initialize AVAudioPlayer Object.")
            }
            
        } else {
            print("😡 ERROR: could not read data from file sound0.")
        }

    }
    
    func nonRepeatingRandom(originalNum: Int, upperLimit: Int) -> Int {
        var newNumber: Int
        repeat {
            newNumber = Int.random(in: 0...upperLimit)
        } while originalNum == newNumber
        return newNumber
    }
    
    
    @IBAction func messageButtonPressed(_ sender: UIButton) {
        
        let messages = ["You Are Awesome!",
                        "You Are Great!",
                        "You Are Fantastic!",
                        "Fabulous? That's You!",
                        "When the Genius Bar needs help, they call you!",
                        "You've got the design skills of Jony Ive"]
        
        messageNumber = nonRepeatingRandom(originalNum: messageNumber, upperLimit: messages.count-1)
        messageLabel.text = messages[messageNumber]
        
        imageNumber = nonRepeatingRandom(originalNum: imageNumber, upperLimit: totNumImages-1)
        imageView.image = UIImage(named: "image\(imageNumber)")
        
        soundNumber = nonRepeatingRandom(originalNum: soundNumber, upperLimit: totNumSounds-1)
        if playSoundSwitch.isOn { //if switch is on it will play
            playSound(name: "sound\(soundNumber)")
        } else {
            
        }
        
        
    }
    
    @IBAction func anotherMessageButtonPressed(_ sender: UIButton) {
        messageLabel.text = "You Are Great!"
    }
    
    @IBAction func playSoundToggled(_ sender: UISwitch) {
        if !sender.isOn && audioPlayer != nil { //if isOn is not true
            audioPlayer.stop() // stop playing
        }
    }
}

