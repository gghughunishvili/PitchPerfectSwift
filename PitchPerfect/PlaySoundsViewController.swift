//
//  PlaySoundsViewController.swift
//  PitchPerfect
//
//  Created by Giorgi Ghughunishvili on 9/22/16.
//  Copyright © 2016 Giorgi Ghughunishvili. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundsViewController: UIViewController {
    
    @IBOutlet weak var snailButton: UIButton!
    @IBOutlet weak var chipmunkButton: UIButton!
    @IBOutlet weak var rabbitButton: UIButton!
    @IBOutlet weak var vaderButton: UIButton!
    @IBOutlet weak var echoButton: UIButton!
    @IBOutlet weak var reverbButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    
    var recordedAudioURL: NSURL!
    
    var audioFile: AVAudioFile!
    var audioEngine: AVAudioEngine!
    var audioPlayerNode: AVAudioPlayerNode!
    var stopTimer: Timer!
    
    enum ButtonType: Int { case slow=0, fast, chipmunk, vader, echo, reverb  }
    
    @IBAction func playSound(forButton sender: UIButton){
        print("play sound for button \(sender.tag)" )
        stopAudio()
        switch ButtonType(rawValue: sender.tag)! {
        case .slow:
            playSound(rate: 0.5)
        case .fast:
            playSound(rate: 1.5)
        case .chipmunk:
            playSound(pitch: 1500)
        case .vader:
            playSound(pitch: -1200)
        case .echo:
            playSound(echo: true)
        case .reverb:
            playSound(reverb: true)
        }
        
        configureUI(playState: .Playing)
    }
    
    @IBAction func stopPressed(forButton sender: AnyObject){
        print("stop sound")
        stopAudio()
        print("Sound has stopped")
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupAudio()
        scaleButtons(buttonsArray: [snailButton, chipmunkButton, rabbitButton, vaderButton, echoButton, reverbButton, stopButton])
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        configureUI(playState: .NotPlaying)
    }
    
    func scaleButtons( buttonsArray: Array<UIButton> ) {
        for btn in buttonsArray {
            btn.imageView?.contentMode = UIViewContentMode.scaleAspectFit
        }
    }

}
