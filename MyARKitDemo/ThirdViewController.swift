//
//  ThirdViewController.swift
//  MyARKitDemo
//
//  Created by Cary on 2022/11/23.
//

import UIKit
import ARKit

class ThirdViewController: UIViewController, ARSCNViewDelegate {
    
    var mSceneView: ARSCNView!
    
    var mCatImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        
        mSceneView = ARSCNView(frame: self.view.bounds)
        mSceneView.delegate = self
        self.view.addSubview(mSceneView)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        guard let referenceObjects = ARReferenceObject.referenceObjects(inGroupNamed: "AR Resources Object", bundle: nil) else {
            fatalError("AR Resources Object 资源文件不存在!")
        }
        
        let configuration = ARWorldTrackingConfiguration()
        configuration.detectionObjects = referenceObjects
        
        mSceneView.debugOptions = .showFeaturePoints
        mSceneView.session.run(configuration)
    }
    
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        guard let objectAnchor = anchor as? ARObjectAnchor else { return }
        
        let name = objectAnchor.referenceObject.name
        
        print("识别出 Object, name = \(String(describing: name))")
        
        if name == "ymhd" {
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
}
