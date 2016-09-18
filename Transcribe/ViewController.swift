//
//  ViewController.swift
//  Transcribe
//
//  Created by Chiranth Bangalore Sathyaprakash on 9/17/16.
//  Copyright © 2016 Chiranth Bangalore Sathyaprakash. All rights reserved.
//

import UIKit
import Speech
import AVFoundation

class ViewController: UIViewController , AVAudioPlayerDelegate{
    
    @IBOutlet weak var activitySpinner: UIActivityIndicatorView!

    @IBOutlet weak var textField: UITextView!
    var audioPlayer: AVAudioPlayer!
    
    ///////////
    override func viewDidLoad() {
        super.viewDidLoad()
       activitySpinner.isHidden = true
       
    }
    //
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        
        player.stop()
        activitySpinner.stopAnimating()
        activitySpinner.isHidden = true
    }
    //
    @IBAction func buttonPressed(_ sender: AnyObject) {
        activitySpinner.isHidden = false
        activitySpinner.startAnimating()
        requestSpeechAuth()
    }
    
    //
    func requestSpeechAuth() {
        
        SFSpeechRecognizer.requestAuthorization { authStatus in
            if authStatus == SFSpeechRecognizerAuthorizationStatus.authorized {
                if let path = Bundle.main.url(forResource: "pulp", withExtension: "mp3") {
                    do {
                        let sound = try AVAudioPlayer(contentsOf: path)
                        self.audioPlayer = sound
                        self.audioPlayer.delegate = self
                        sound.play()
                    } catch {
                        print ("Audio Error!")
                    }
                    
                    let recognizer  = SFSpeechRecognizer()
                    let request = SFSpeechURLRecognitionRequest(url: path)
                    recognizer?.recognitionTask(with: request) { (result,error) in
                        if let error = error {
                            print("There was an audio error : \(error)")
                        } else {
                            print(result?.bestTranscription.formattedString)
                            self.textField.text = result?.bestTranscription.formattedString
                        }
                    }
                    
                    
                    
                }
            }
        }// speech recognizer
    
    }
    //
}

