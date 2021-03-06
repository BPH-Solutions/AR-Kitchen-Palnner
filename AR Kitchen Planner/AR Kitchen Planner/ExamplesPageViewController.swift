//
//  ExamplesPageViewController.swift
//  AR Kitchen Planner
//
//  Created by citstudent2 on 01/05/2019.
//  Copyright © 2019 BPH-Solutions. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class ExamplesPageViewController: UIViewController, ARSCNViewDelegate {
    

    @IBOutlet var sceneView: ARSCNView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate
        sceneView.delegate = self
        
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = true
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARImageTrackingConfiguration()
        
        if let imageToTrack = ARReferenceImage.referenceImages(inGroupNamed: "Pokemon Cards", bundle: Bundle.main){
            configuration.trackingImages = imageToTrack
            configuration.maximumNumberOfTrackedImages = 4
            
            print("Images Successfully Added")
        }
        
        
        
        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }
    
    // MARK: - ARSCNViewDelegate
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        let node = SCNNode()
        
        if let imageAnchor = anchor as? ARImageAnchor {
            
            
            
            let plane = SCNPlane(width: imageAnchor.referenceImage.physicalSize.width, height: imageAnchor.referenceImage.physicalSize.height)
            
            plane.firstMaterial?.diffuse.contents = UIColor(white: 1.0, alpha: 0.5)
            
            let planeNode = SCNNode(geometry: plane)
            
            planeNode.eulerAngles.x = -.pi/2
            
            node.addChildNode(planeNode)
            
            if imageAnchor.referenceImage.name == "pikachu-card"{
                
                if let pokeScene = SCNScene(named: "art.scnassets/Pikachu.scn"){
                    
                    if let pokeNode = pokeScene.rootNode.childNodes.first{
                        
                        pokeNode.eulerAngles.x = .pi / 2
                        
                        planeNode.addChildNode(pokeNode)
                    }
                }
            }
            
        
        if imageAnchor.referenceImage.name == "charmander-card"{
            
            if let pokeScene = SCNScene(named: "art.scnassets/Char.scn"){
                
                if let pokeNode = pokeScene.rootNode.childNodes.first{
                    
                    pokeNode.eulerAngles.x = .pi / 2
                    
                    planeNode.addChildNode(pokeNode)
                }
            }
        }
        if imageAnchor.referenceImage.name == "gyarados-card"{
            
            if let pokeScene = SCNScene(named: "art.scnassets/Gary.scn"){
                
                if let pokeNode = pokeScene.rootNode.childNodes.first{
                    
                    pokeNode.eulerAngles.x = .pi / 2
                    
                    planeNode.addChildNode(pokeNode)
                }
            }
        }
        if imageAnchor.referenceImage.name == "squirtle-card"{
            
            if let pokeScene = SCNScene(named: "art.scnassets/Squirtle.scn"){
                
                if let pokeNode = pokeScene.rootNode.childNodes.first{
                    
                    pokeNode.eulerAngles.x = .pi / 2
                    
                    planeNode.addChildNode(pokeNode)
                }
            }
        }
    }
    
    
    
    
    return node
}

}
