//
//  PlaySound.swift
//  Honeymoon
//
//  Created by Ghenadie Isacenco on 01/11/2025.
//

import AVFoundation

var audioPlayer: AVAudioPlayer?

func playSound(sound: String, type: String) {
    if let path = Bundle.main.path(forResource: sound, ofType: type) {
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
            audioPlayer?.play()
        } catch {
            print("Couldn't load audio file")
        }
    }
}
