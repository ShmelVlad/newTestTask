//
//  ViewController.swift
//  TestRadioStation
//
//  Created by Vladislav Shmelev on 02.07.2018.
//  Copyright © 2018 123. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    var player = AVAudioPlayer()
    var nPlayer = AVPlayer()
    var btn = UIButton.init(frame: CGRect.init(x: 0, y: 0, width: 100, height: 100))
    var slider = UISlider.init(frame: CGRect.init(x: 20, y: 120, width: 100, height: 30))
    override func viewDidLoad() {
        btn.addTarget(self, action: #selector(getAll), for: .touchUpInside)
        view.addSubview(btn)
        view.addSubview(slider)
        
        
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        try! AVAudioSession.sharedInstance().setActive(true)
        
        for i in 0...2 {
        DispatchQueue.global().asyncAfter(deadline: .now() + 5) {
//            print(self.player.currentTime)
        }
        }
    }

    
    @objc
    func getAll() {
                URLSession.shared.downloadTask(with: URL.init(string: "https://c1.prod.playlists.ihrhls.com/6834/playlist.m3u8")!) { (url, resp, err) in
//                    self.nPlayer = AVPlayer.init(playerItem: item)
//                    self.nPlayer.play()
//                    self.player = try! AVAudioPlayer.init(contentsOf: url!)
//                    self.player.prepareToPlay()
//                    print(self.player.duration)
//                    self.player.play()
                    
                    
//                    let ite = AVPlayerItem(asset: AVAsset.init(url: url!))
                    self.nPlayer = AVPlayer(url: URL(string: "https://c1.prod.playlists.ihrhls.com/6834/playlist.m3u8")!)
                    self.nPlayer.rate = 1
                    self.nPlayer.play()
                    
                }.resume()
        let str = "https://c1.prod.playlists.ihrhls.com/6834/playlist.m3u8"

        
//         Мб сработает
//                nPlayer = AVPlayer.init(url: URL(string: "http://ol5.mp3party.net/online/8443/8443695.mp3")!)
//                nPlayer.play()
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

