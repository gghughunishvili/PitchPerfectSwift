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
    
    enum ButtonType: Int { case Slow=0, Fast, Chipmunk, Vader, Echo, Reverb  }
    
    @IBAction func playSound(forButton sender: UIButton){
        print("play sound for button \(sender.tag)" )
        stopAudio()
        switch ButtonType(rawValue: sender.tag)! {
        case .Slow:
            playSound(rate: 0.5)
        case .Fast:
            playSound(rate: 1.5)
        case .Chipmunk:
            playSound(pitch: 1500)
        case .Vader:
            playSound(pitch: -1200)
        case .Echo:
            playSound(echo: true)
        case .Reverb:
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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        configureUI(playState: .NotPlaying)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}