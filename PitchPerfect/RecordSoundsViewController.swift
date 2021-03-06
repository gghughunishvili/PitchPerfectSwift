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
        stopRecordingButton.isEnabled = false
        print("View did loaded")
    }

    @IBAction func recordAudio(_ sender: AnyObject) {
        let dirPath = NSSearchPathForDirectoriesInDomains(.documentDirectory,.userDomainMask, true)[0] as String
        let recordingName = "recordedVoice.wav"
        let pathArray = [dirPath, recordingName]
        let filePath = NSURL.fileURL(withPathComponents: pathArray)
        
        print(filePath)
        
        let session = AVAudioSession.sharedInstance()
        try! session.setCategory(AVAudioSessionCategoryPlayAndRecord)
        
        try! self.audioRecorder = AVAudioRecorder(url: filePath!, settings: [:])
        session.requestRecordPermission({(granted: Bool)-> Void in
            if granted {
                print("recording started")
                self.audioState(recordHasStarted: true, message: "Recording in progress!")
                self.audioRecorder.delegate = self
                self.audioRecorder.isMeteringEnabled = true
                self.audioRecorder.prepareToRecord()
                self.audioRecorder.record()
            }else{
                self.showAlert(title: "No permission", message: "Microphone usage permission should be allowed!")
            }
        })
        
    }
    
    @IBAction func stopRecording(_ sender: AnyObject) {
        print("record ended")
        audioState(recordHasStarted: false, message: "Tap to record")
        audioRecorder.stop()
        let audioSession = AVAudioSession.sharedInstance()
        try! audioSession.setActive(false)
    }
    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        print("Did finish recording")
        if flag{
            print("Correctly finished")
            performSegue(withIdentifier: "stopRecording", sender: audioRecorder.url)
        }else{
            showAlert(title: "Error", message: "Something went wrong during saving")
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "stopRecording") {
            let playSoundsVC = segue.destination as! PlaySoundsViewController
            let recordedAudioURL = sender as! NSURL
            playSoundsVC.recordedAudioURL = recordedAudioURL
        }
    }
    
    func audioState(recordHasStarted: Bool, message: String) {
        stopRecordingButton.isEnabled = recordHasStarted
        recordButton.isEnabled = !recordHasStarted
        recordingLabel.text = message
    }
    
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Dissmis", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}

