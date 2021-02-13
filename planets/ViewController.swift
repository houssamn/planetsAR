//
//  ViewController.swift
//  planets
//
//  Created by Houssam on 2/12/21.
//

import UIKit
import ARKit

class ViewController: UIViewController {

    @IBOutlet weak var sceneView: ARSCNView!
    
    let configuration = ARWorldTrackingConfiguration()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.sceneView.debugOptions = [ARSCNDebugOptions.showWorldOrigin, ARSCNDebugOptions.showFeaturePoints]
        self.sceneView.session.run(configuration)
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let earth = SCNNode()
        earth.geometry = SCNSphere(radius: 0.2)
        // earth.geometry?.firstMaterial?.diffuse.contents
        
        earth.geometry?.firstMaterial?.diffuse.contents = UIImage(named: "EarthDay")
        earth.position = SCNVector3(0,0,-1)
        
        self.sceneView.scene.rootNode.addChildNode(earth)
        
    }


}

