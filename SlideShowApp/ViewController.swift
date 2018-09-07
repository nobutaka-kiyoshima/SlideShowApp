//
//  ViewController.swift
//  SlideShowApp
//
//  Created by Nobutaka Kiyoshima on 28/08/18.
//  Copyright © 2018 Nobutaka Kiyoshima. All rights reserved.
//

import UIKit
// UIGestureRecognizerDelegateを追加
class ViewController: UIViewController {
    
    var timer: Timer!
    let imageNames  = ["1","2","3","4","5"]
    var index = 0
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    
    
    let tapGesture:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ViewController.tapped(_:)))
    
    SlidePhoto.image  = UIImage(named:imageNames [index])
        
        self.SlidePhoto.addGestureRecognizer (tapGesture)
        
        SlidePhoto.isUserInteractionEnabled = true
    }
    
    @objc func tapped(_ sender:UITapGestureRecognizer) {
        performSegue(withIdentifier: "toSecond", sender: nil)
        
    }
        
        
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //Segueから遷移先のnextViewControllerを取得する。
        let nextViewController :NextViewController = segue.destination as! NextViewController
        
        nextViewController.selectedImage = UIImage (named: imageNames[index])
        }
        
    @IBAction func unwind(_segue:UIStoryboardSegue) {
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //画像のプロパティをSlidePhotoとの名前でコードと接続
    @IBOutlet weak var SlidePhoto: UIImageView!
    
    @objc func updateTimer (_ timer: Timer) {
        index += 1
        if index > 4 {index = 0}
        SlidePhoto.image  = UIImage(named:imageNames [index])
        
    }
    //進むボタン
    @IBOutlet weak var forwardButton: UIButton!
    @IBAction func GoForward(_ sender: Any) {
        index += 1
         if index > 4 { index = 0}
        SlidePhoto.image  = UIImage(named:imageNames [index])
        
}
    //戻るボタン
    @IBOutlet weak var backwardButton: UIButton!
    @IBAction func GoBack(_ sender: Any) {
        index -= 1
        if index < 0 { index = 4}
        SlidePhoto.image = UIImage (named: imageNames [index])
    }
    //
    @IBOutlet weak var PlayStopPlay: UIButton!
    
    // 再生と停止ボタン
    @IBAction func PlayStop(_ sender: Any) {
       
        //再生ボタンをタップすると2秒おきにカウントするタイマー
        //タイマーが起動中でなければ、タイマーを起動し、停止を表示
        if timer == nil {
            timer = Timer.scheduledTimer (timeInterval: 2, target: self, selector: #selector(updateTimer(_:)),userInfo: nil, repeats: true)
            PlayStopPlay.setTitle ("停止", for: .normal)
            forwardButton.isEnabled = false
            backwardButton.isEnabled = false
            //タイマーが起動中なら、停止ボタンを押して停止し、ボタンのタイトルを再生に切り替える
        }else {self.timer.invalidate()
            timer = nil
            PlayStopPlay.setTitle ("再生", for: .normal)
            forwardButton.isEnabled = true
            backwardButton.isEnabled = true
            }
    }
    }



