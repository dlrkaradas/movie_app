//
//
//
//import UIKit
//import AVKit
//import AVFoundation
//
//class MoviePlayerViewController: UIViewController,AVPlayerViewControllerDelegate
//{
//    var playerController = AVPlayerViewController()
//    
//    
//    @IBAction func Play(_ sender: Any)
//    {
//        let path = Bundle.main.path(forResource: "video", ofType: "mp4")
//        
//        let url = NSURL(fileURLWithPath: path!)
////        MOVİE VİDEO URLSİ BURAYA GELECEK
////        let player = AVPlayer(url:"https://api.themoviedb.org/3/movie/\(id)/videos?api_key=f6623503dead1c4fbf323c1814eff5b0" as URL)
//        
//        playerController = AVPlayerViewController()
//        NotificationCenter.default.addObserver(self, selector: #selector(MoviePlayerViewController.didfinishplaying(note:)),name:NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: player.currentItem)
//        playerController.player = player
//        playerController.allowsPictureInPicturePlayback = true
//        playerController.delegate = self
//        playerController.player?.play()
//        self.present(playerController,animated:true,completion:nil)
//    }
//    
//    @objc func didfinishplaying(note : NSNotification)
//    {
//        playerController.dismiss(animated: true,completion: nil)
//        let alertview = UIAlertController(title:"finished",message:"video finished",preferredStyle: .alert)
//        alertview.addAction(UIAlertAction(title:"Ok",style: .default, handler: nil))
//        self.present(alertview,animated:true,completion: nil)
//    }
//    
//    
//    func playerViewController(_ playerViewController: AVPlayerViewController, restoreUserInterfaceForPictureInPictureStopWithCompletionHandler completionHandler: @escaping (Bool) -> Void) {
//        let currentviewController =  navigationController?.visibleViewController
//        
//        if currentviewController != playerViewController
//        {
//            currentviewController?.present(playerViewController,animated: true,completion:nil)
//        }
//        
//        
//    }
//}
