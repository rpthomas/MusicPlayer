//
//  YouTubeMusic.swift
//  MusiPlayer
//
//  Created by Roland Thomas on 3/9/21.
//

import Foundation
import UIKit
import AVFoundation


func  extractMusicFromVideo()
{
    
   // https://stackoverflow.com/questions/27590510/xcode-how-to-convert-mp4-file-to-audio-file
    
    
    
    
    // Create a composition
            let composition = AVMutableComposition()
            do {
                let sourceUrl = Bundle.main.url(forResource: "Movie", withExtension: "mov")!
                let asset = AVURLAsset(url: sourceUrl)
                guard let audioAssetTrack = asset.tracks(withMediaType: AVMediaType.audio).first else { return }
                guard let audioCompositionTrack = composition.addMutableTrack(withMediaType: AVMediaType.audio, preferredTrackID: kCMPersistentTrackID_Invalid) else { return }
                try audioCompositionTrack.insertTimeRange(audioAssetTrack.timeRange, of: audioAssetTrack, at: CMTime.zero)
            } catch {
                print(error)
            }

            // Get url for output
            let outputUrl = URL(fileURLWithPath: NSTemporaryDirectory() + "out.m4a")
            if FileManager.default.fileExists(atPath: outputUrl.path) {
                try? FileManager.default.removeItem(atPath: outputUrl.path)
            }

            // Create an export session
            let exportSession = AVAssetExportSession(asset: composition, presetName: AVAssetExportPresetPassthrough)!
            exportSession.outputFileType = AVFileType.m4a
            exportSession.outputURL = outputUrl

            // Export file
            exportSession.exportAsynchronously {
                guard case exportSession.status = AVAssetExportSession.Status.completed else { return }

                DispatchQueue.main.async {
                    // Present a UIActivityViewController to share audio file
                    guard let outputURL = exportSession.outputURL else { return }
                    _ = UIActivityViewController(activityItems: [outputURL], applicationActivities: [])
                    //self.present(activityViewController, animated: true, completion: nil)
                }
            }
        }

  


