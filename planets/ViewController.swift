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
        self.sceneView.autoenablesDefaultLighting = true
        self.sceneView.session.run(configuration)
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        createScene()
    }
    
    // Create a Scene with the Sun, Earth, and moon spinning around each other.
    func createScene() {

        // Create Sun that spins around itself
        let sun = constructPlanet(geometry: SCNSphere(radius: 0.3), position: SCNVector3(0,0,-2), diffuse: UIImage(named: "Sun"), specular: nil, emission: nil, normal: nil)
        let sunAction = spinForeverAction(durationSecs: 10)
        sun.runAction(sunAction)
        
        self.sceneView.scene.rootNode.addChildNode(sun)
        
        // Add the earth and make it spin around the sun
        let earth = constructPlanet(geometry: SCNSphere(radius: 0.1), position: SCNVector3(0,0,-1), diffuse: UIImage(named: "EarthDay"), specular: UIImage(named: "EarthSpecular"), emission: UIImage(named: "EarthClouds"), normal: UIImage(named: "EarthNormal"))

        self.sceneView.scene.rootNode.addChildNode(earth)
        let earthSpin = spinForeverAction(durationSecs: 4)
        earth.runAction(earthSpin) // run rotation on the earth
                      
        sun.addChildNode(earth)
        
        // Add the Moon
        let moon = constructPlanet(geometry: SCNSphere(radius: 0.05), position: SCNVector3(0.2, 0, 0), diffuse: UIImage(named: "Moon"), specular: nil, emission: nil, normal: nil)
        let moonSpin = spinForeverAction(durationSecs: 5)
        moon.runAction(moonSpin)
        earth.addChildNode(moon)
        
    }
    
    func constructPlanet(geometry : SCNGeometry, position: SCNVector3, diffuse: UIImage?, specular: UIImage?, emission: UIImage?, normal: UIImage?) -> SCNNode {
        let planet = SCNNode(geometry: geometry)
        planet.geometry?.firstMaterial?.diffuse.contents = diffuse
        planet.geometry?.firstMaterial?.specular.contents = specular
        planet.geometry?.firstMaterial?.emission.contents = emission
        planet.geometry?.firstMaterial?.normal.contents = normal
        planet.position = position
        
        return planet
    }

    func spinForeverAction(durationSecs: TimeInterval) -> SCNAction {
        let action = SCNAction.rotateBy(x: 0, y: CGFloat(360.degreesToRadians), z: 0, duration: durationSecs)
        let forever  = SCNAction.repeatForever(action)
        return forever
    }

}

extension Int {
    var degreesToRadians: Double { return Double(self) * .pi / 180 }
}
