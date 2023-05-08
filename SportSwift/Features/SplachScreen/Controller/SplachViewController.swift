//
//  SplachViewController.swift
//  SportSwift
//
//  Created by Mohamed on 05/05/2023.
//

import UIKit
import Lottie

class SplachViewController: UIViewController {

    var animationView:LottieAnimationView?
    override func viewDidLoad() {
        super.viewDidLoad()

        print("TEst")
        animationView = .init (name: "sport")
        animationView?.frame = view.bounds
        animationView?.loopMode = .loop
        animationView?.animationSpeed = 0.5
        view.addSubview(animationView!)
        animationView?.play ()
    }


}
