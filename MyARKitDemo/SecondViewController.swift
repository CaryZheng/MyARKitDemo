//
//  SecondViewController.swift
//  MyARKitDemo
//
//  Created by Cary on 2022/11/22.
//

import UIKit
import ARKit

class SecondViewController: UIViewController, ARSCNViewDelegate {
    
    var mSceneView: ARSCNView!
    
    var mCatImageView: UIImageView!
    
    var mCount = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        
        mSceneView = ARSCNView(frame: self.view.bounds)
        mSceneView.delegate = self
        self.view.addSubview(mSceneView)
        
//        let frontView = UIView(frame: CGRect(x: 0, y: 100, width: 200, height: 100))
//        frontView.backgroundColor = .blue
//        self.view.addSubview(frontView)
//
//        animationE(animationView: frontView)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        guard let referenceImages = ARReferenceImage.referenceImages(inGroupNamed: "AR Resources", bundle: nil) else {
            fatalError("AR Resources 资源文件不存在!")
        }
        
        let configuration = ARWorldTrackingConfiguration()
        configuration.detectionImages = referenceImages
        mSceneView.session.run(configuration)
    }
    
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        guard let imageAnchor = anchor as? ARImageAnchor else { return }
        
        let referenceImage = imageAnchor.referenceImage
//        let plane = SCNPlane(width: referenceImage.physicalSize.width, height: referenceImage.physicalSize.height)
        
//        let planeNode = SCNNode(geometry: plane)
//        planeNode.eulerAngles.x = -.pi / 2
//
//        node.addChildNode(planeNode)
        
        mCount += 1
        let picName = referenceImage.name
        print("renderer didAdd, name = \(String(describing: picName)), mCount = \(mCount)")
        
        if picName == "pic_chicken_ps" {
            DispatchQueue.main.async { [weak self] in
                self?.playCatAnimation()
            }
        }
    }
    
    func playCatAnimation() {
        var imgArray = [UIImage]()
        for i in 0..<40 {
            let imageName = i<10 ? "eat_0\(i)" : "eat_\(i)"
            let image = UIImage(named: imageName)!
            imgArray.append(image)
        }
        
        if nil == mCatImageView {
            mCatImageView = UIImageView(image: imgArray[0])
            mCatImageView.center = self.view.center
            
            self.view.addSubview(mCatImageView)
        }
        
        mCatImageView.animationImages = imgArray
        mCatImageView.animationDuration = Double(imgArray.count) * 0.1
        mCatImageView.animationRepeatCount = 1
        mCatImageView.startAnimating()
                
        Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) { [weak self] timer in
            self?.mCatImageView.removeFromSuperview()
            self?.mCatImageView = nil
        }
    }
    
//    func animationE(animationView: UIView) -> Void {
//        UIView.animateKeyframes(withDuration: 8, delay: 0, options: .calculationModeLinear, animations: {
//                UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 1.0/4, animations: {
//                     animationView.backgroundColor = UIColor.red
//                })
//                UIView.addKeyframe(withRelativeStartTime: 1.0/4, relativeDuration: 1.0/4, animations: {
//                    animationView.backgroundColor = UIColor.green
//                })
//                UIView.addKeyframe(withRelativeStartTime: 2.0/4, relativeDuration: 1.0/4, animations: {
//                    animationView.backgroundColor = UIColor.blue
//                })
//                UIView.addKeyframe(withRelativeStartTime: 3.0/4, relativeDuration: 1.0/4, animations: {
//                    animationView.backgroundColor = UIColor.magenta
//                })
//                UIView.addKeyframe(withRelativeStartTime: 4.0/4, relativeDuration: 1.0/4, animations: {
//                    animationView.backgroundColor = UIColor.purple
//                })
//            }) { (isFinish) in
//                // code.... 动画结束后的处理内容
//                animationView.backgroundColor = UIColor.cyan
//            }
//    }
}
