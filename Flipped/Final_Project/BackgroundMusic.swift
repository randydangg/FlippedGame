//
//  BackgroundMusic.swift
//  Final_Project
//
//  Created by Randy Dang on 2018-04-03.
//  Copyright © 2018 Randy Dang. All rights reserved.
//

import UIKit
import AVFoundation

class BackgroundMusic: NSObject {
    static let sharedMusic = BackgroundMusic()
    var audioPlayer: AVAudioPlayer?
    
    func playBGMusic(int: Int) {
        if int == 1 {
            let url = Bundle.main.url(forResource: "Creepy Cave Music - Gemstone Caves.mp3", withExtension: nil)
            do {
                try audioPlayer = AVAudioPlayer(contentsOf: url!)
            } catch {
                print("Could not create audio player")
            }
            audioPlayer!.numberOfLoops = -1
            audioPlayer!.prepareToPlay()
            audioPlayer!.play()
        }
        if int == 2 {
            let url = Bundle.main.url(forResource: "MapleStory BGM Sleepywood.mp3", withExtension: nil)
            do {
                try audioPlayer = AVAudioPlayer(contentsOf: url!)
            } catch {
                print("Could not create audio player")
            }
            audioPlayer!.numberOfLoops = -1
            audioPlayer!.prepareToPlay()
            audioPlayer!.play()
        }

    }
    
    func stopBGMusic() {
        if audioPlayer == nil {
            print("no music playing")
        }
        else {
            audioPlayer!.stop()
        }
    }
}
