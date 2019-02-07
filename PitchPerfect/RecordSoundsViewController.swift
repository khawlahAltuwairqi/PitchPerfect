//
//  RecordSoundsViewController.swift
//  PitchPerfect
//
//  Created by khawlah on 11/2/18.
//  Copyright © 2018 khawlah. All rights reserved.
//

import UIKit
import AVFoundation

// MARK: - RecordSoundsViewController: UIViewController, AVAudioRecorderDelegate
class RecordSoundsViewController: UIViewController, AVAudioRecorderDelegate {

    @IBOutlet weak var recordingLabel: UILabel!
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var stopRecordingButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        stopRecordingButton.isEnabled = false
        recordButton.imageView?.contentMode = UIView.ContentMode.scaleAspectFit
        stopRecordingButton.imageView?.contentMode = UIView.ContentMode.scaleAspectFit
    }
    
    /**override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("viewWillAppear Call")
    }**/
    
     //Define a global variable for the recorder
     var audioRecorder: AVAudioRecorder!
    
    // MARK: recodAudio
    @IBAction func recodAudio(_ sender: Any) {
        //Disable the record button, enable the stop button, and update the label by call this function
        configureUI(status:true)
        
        //Set the path where the file should be stored
        let dirPath = NSSearchPathForDirectoriesInDomains(.documentDirectory,.userDomainMask, true)[0] as String
        
        //Set the file name
        let recordingName = "recordedVoice.wav"
        
        //Prepare the full path as two elements in a String array
        let pathArray = [dirPath, recordingName]
        
        //Create a URL for the path by sending the full String value of the path
        let filePath = URL(string: pathArray.joined(separator: "/"))
        
        //Get the AVAudioSession that is shared in the device
        let session = AVAudioSession.sharedInstance()
        try! session.setCategory(AVAudioSession.Category.playAndRecord, mode:AVAudioSession.Mode.default)
        
        //Try to initialize the recorder using the path URL without handling any resulting exception
        try! audioRecorder = AVAudioRecorder(url: filePath!, settings: [:])
       
        // deligate of the recorder to be this class
        audioRecorder.delegate = self
        
        audioRecorder.isMeteringEnabled = true
        
        //Prepare the recorder then start recording
        audioRecorder.prepareToRecord()
        audioRecorder.record()
    }
    
    // MARK: - stopRecording
    @IBAction func stopRecording(_ sender: Any) {
        //enable the record button, disable the stop button, and update the label by call this function
        configureUI(status: false)
        
        //Stop the recorder
        audioRecorder.stop()
        let audioSession = AVAudioSession.sharedInstance()
        try! audioSession.setActive(false)
    }
   
    // MARK: - audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool)
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if flag{
            performSegue(withIdentifier: "stopRecording", sender: audioRecorder.url)
        }else{
            print("recording was not successful")
        }
    }
    
    // MARK: - prepare
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "stopRecording"{
            let playSoundsVC = segue.destination as! PlaySoundsViewController
            let recordedAudioURL = sender as! URL
            playSoundsVC.recordedAudioURL = recordedAudioURL
        }
    }
    
    // MARK: Configuring The UI Function
    func configureUI(status: Bool){
        if(status){
            recordingLabel.text = "Recording in Progress"
            stopRecordingButton.isEnabled = true
            recordButton.isEnabled = false
        }else{
            recordButton.isEnabled = true
            stopRecordingButton.isEnabled = false
            recordingLabel.text = "Tap to Record"
            
        }
        
    }
    
}

