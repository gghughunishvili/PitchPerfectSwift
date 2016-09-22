//
//  ViewController.swift
//  PitchPerfect
//
//  Created by Giorgi Ghughunishvili on 9/21/16.
//  Copyright © 2016 Giorgi Ghughunishvili. All rights reserved.
//

import UIKit
import AVFoundation

class RecordSoundsViewController: UIViewController, AVAudioRecorderDelegate {

    @IBOutlet weak var recordButton: UIButton!
    
    @IBOutlet weak var recordingLabel: UILabel!
    
    @IBOutlet weak var stopRecordingButton: UIButton!
    
    var audioRecorder: AVAudioRecorder!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        stopRecordingButton.isEnabled = false;
        print("View did loaded")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func recordAudio(_ sender: AnyObject) {
        print("record started")
        stopRecordingButton.isEnabled = true;
        recordButton.isEnabled = false;
        recordingLabel.text = "Recording in progress!";
        
        let dirPath = NSSearchPathForDirectoriesInDomains(.documentDirectory,.userDomainMask, true)[0] as String
        let recordingName = "recordedVoice.wav"
        let pathArray = [dirPath, recordingName]
        let filePath = NSURL.fileURL(withPathComponents: pathArray)
        
        print(filePath)
        
        let session = AVAudioSession.sharedInstance()
        try! session.setCategory(AVAudioSessionCategoryPlayAndRecord)
        
        try! self.audioRecorder = AVAudioRecorder(url: filePath!, settings: [:])
        
        self.audioRecorder.delegate = self
        self.audioRecorder.isMeteringEnabled = true
        self.audioRecorder.prepareToRecord()
        self.audioRecorder.record()
        
    }
    @IBAction func stopRecording(_ sender: AnyObject) {
        print("record ended")
        recordingLabel.text = "Tap to record";
        stopRecordingButton.isEnabled = false;
        recordButton.isEnabled = true;
        audioRecorder.stop()
        let audioSession = AVAudioSession.sharedInstance()
        try! audioSession.setActive(false)
    }
    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        print("Did finish recording")
        if flag{
            print("Correctly finished")
            self.performSegue(withIdentifier: "stopRecording", sender: audioRecorder.url)
        }else{
            print("Something went wrong during saving")
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "stopRecording") {
            let playSoundsVC = segue.destination as! PlaySoundsViewController
            let recordedAudioURL = sender as! NSURL
            playSoundsVC.recordedAudioURL = recordedAudioURL
        }
    }
}

