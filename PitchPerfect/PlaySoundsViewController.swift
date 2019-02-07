//
//  PlaySoundsViewController.swift
//  PitchPerfect
//
//  Created by khawlah on 11/8/18.
//  Copyright © 2018 khawlah. All rights reserved.
//

import UIKit
import AVFoundation

// MARK: - PlaySoundsViewController: UIViewController
class PlaySoundsViewController: UIViewController {

    @IBOutlet weak var snailButton: UIButton!
    @IBOutlet weak var chipmunkButton: UIButton!
    @IBOutlet weak var rabbitButton: UIButton!
    @IBOutlet weak var vaderButton: UIButton!
    @IBOutlet weak var echoButton: UIButton!
    @IBOutlet weak var reverbButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    
    var recordedAudioURL:URL!
    var audioFile:AVAudioFile!
    var audioEngine:AVAudioEngine!
    var audioPlayerNode: AVAudioPlayerNode!
    var stopTimer: Timer!
    
    // MARK: ButtonType
    enum ButtonType: Int {
        case slow = 0, fast, chipmunk, vader, echo, reverb
    }
    
    // MARK: - playSoundForButton(_ sender: UIButton)
    @IBAction func playSoundForButton(_ sender: UIButton) {
        switch(ButtonType(rawValue: sender.tag)!) {
        case .slow:
            playSound(rate: 0.5)
        case .fast:
            playSound(rate: 1.5)
        case .chipmunk:
            playSound(pitch: 1000)
        case .vader:
            playSound(pitch: -1000)
        case .echo:
            playSound(echo: true)
        case .reverb:
            playSound(reverb: true)
        }
        
        configureUI(.playing)
    }
    
    // MARK: - stopButtonPressed
    @IBAction func stopButtonPressed(_ sender: AnyObject) {
        stopAudio()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAudio()
        snailButton.imageView?.contentMode = UIView.ContentMode.scaleAspectFit
        chipmunkButton.imageView?.contentMode = UIView.ContentMode.scaleAspectFit
        rabbitButton.imageView?.contentMode = UIView.ContentMode.scaleAspectFit
        vaderButton.imageView?.contentMode = UIView.ContentMode.scaleAspectFit
        echoButton.imageView?.contentMode = UIView.ContentMode.scaleAspectFit
        reverbButton.imageView?.contentMode = UIView.ContentMode.scaleAspectFit
        stopButton.imageView?.contentMode = UIView.ContentMode.scaleAspectFit
    }
  /**  override func viewWillAppear(_ animated: Bool) {
        configureUI(.notPlaying)
    }**/
    
}
