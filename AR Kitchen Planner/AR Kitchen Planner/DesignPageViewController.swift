//
//  DesignPageViewController.swift
//  AR Kitchen Planner
//
//  Created by citstudent2 on 01/05/2019.
//  Copyright © 2019 BPH-Solutions. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class DesignPageViewController: UIViewController, ARSCNViewDelegate {
    
    @IBOutlet var sceneView: ARSCNView!
    @IBOutlet weak var VIEWNEW: UIView!
    
    
    var dotNodes = [SCNNode]()
    var textNode = SCNNode()
    var distnce = (0.0)
    var Count = (0)
    var Width = (0.00)
    var Height = (0.00)
    var step3 = false
    var posX : CGFloat = (0)
    var posY : CGFloat = (0)
    var posZ : CGFloat = (0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate
        sceneView.delegate = self
        
        sceneView.debugOptions = [ARSCNDebugOptions.showFeaturePoints]
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()
        
        configuration.planeDetection = .vertical
        
        // Run the view's session
        sceneView.session.run(configuration)

        let alert = UIAlertController(title: "Step 1", message: "Measure the width of the wall you want to design on", preferredStyle: .alert)
        
        let Confirm = UIAlertAction(title: "OK", style: .default, handler: {(UIAlertAction) in
            
        })
        
        alert.addAction(Confirm)
        
        present(alert, animated: true, completion: nil)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if dotNodes.count >= 2 {
            
            for dot in dotNodes{
                dot.removeFromParentNode()
                
                
            }
            dotNodes = [SCNNode]()
            
        }
        
        if let touchLocation = touches.first?.location(in: sceneView){
            let hitTestResult = sceneView.hitTest(touchLocation, types: .featurePoint)
            
            if let hitResult = hitTestResult.first{
                addDot(at: hitResult)
            }
        }
        
    }
    func addDot(at hitResult: ARHitTestResult) {
        let dotGeometry = SCNSphere(radius: 0.005)
        let material = SCNMaterial()
        material.diffuse.contents = UIColor.red
        dotGeometry.materials = [material]
        
        let dotNode = SCNNode(geometry: dotGeometry)
        
        dotNode.position = SCNVector3(hitResult.worldTransform.columns.3.x,hitResult.worldTransform.columns.3.y , hitResult.worldTransform.columns.3.z)
        
        sceneView.scene.rootNode.addChildNode(dotNode)
        
        dotNodes.append(dotNode)
        
        if dotNodes.count >= 2 {
            calculate()
        }
    }
    
    func calculate(){
        let start = dotNodes[0]
        let end = dotNodes[1]
        
        print(start.position)
        print(end.position)
        
        let a = end.position.x - start.position.x
        let b = end.position.y - start.position.y
        let c = end.position.z - start.position.z
        
        distnce = (Double)(sqrt(pow(a,2) + pow(b, 2) + pow(c, 2)))
        
        Alert()
        
        //        distance = √ ((x2-x1)⌃2) + (y2-y1)⌃2) + (z2-z1)⌃2))
    }
    
    func Alert(){
        
        if Count == 0{
        let alert = UIAlertController(title: "Step 1", message: "You measured \(distnce)Metres, is that correct? If not, then return to main menu and open the Design page again", preferredStyle: .alert)
        
        let Confirm = UIAlertAction(title: "Confirm", style: .default, handler: {(UIAlertAction) in
            self.Measurecount()
        })
        
        alert.addAction(Confirm)
        
        present(alert, animated: true, completion: nil)
            Width = distnce
        }
        if Count == 1{
            let alert = UIAlertController(title: "Step 2", message: "You measured \(distnce)Metres, is that correct? If not, then return to main menu and open the Design page again", preferredStyle: .alert)
            
            let Confirm = UIAlertAction(title: "Confirm", style: .default, handler: {(UIAlertAction) in
                self.Measurecount()
            })
            
            alert.addAction(Confirm)
            
            present(alert, animated: true, completion: nil)
            Height = distnce
        }
    }
    
    func Measurecount(){
        Count = Count + 1
        
        if Count == 1{
            let alert = UIAlertController(title: "Step 2", message: "Measure the height of the wall you want to design on", preferredStyle: .alert)
            
            let Confirm = UIAlertAction(title: "OK", style: .default, handler: {(UIAlertAction) in
                
            })
            
            alert.addAction(Confirm)
            
            present(alert, animated: true, completion: nil)
        }
        if Count == 2{
            let alert = UIAlertController(title: "Step 3", message: "Choose the kitchen units you want from the menu below", preferredStyle: .alert)
            
            let Confirm = UIAlertAction(title: "OK", style: .default, handler: {(UIAlertAction) in
                
            })
            
            alert.addAction(Confirm)
            
            present(alert, animated: true, completion: nil)
            
            VIEWNEW.isHidden = false;
            
            print("view should have changed")
            
            
        }
        
    }



    
        func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor){
        
        print("step 3 reached")
            if Count == 2{
        if anchor is ARPlaneAnchor {
            let planeAnchor = anchor as! ARPlaneAnchor
            
            let plane = SCNPlane(width: CGFloat(Width), height: CGFloat(Height))
            
            let planeNode = SCNNode()
            
            
            planeNode.position = SCNVector3(planeAnchor.center.x,planeAnchor.center.y,planeAnchor.center.z)
            
            planeNode.transform = SCNMatrix4MakeRotation(.pi/2, 1, 0, 0)
            
            let gridMaterial = SCNMaterial()
            
            gridMaterial.isDoubleSided = true
            
            gridMaterial.diffuse.contents = UIColor.yellow
            
            plane.materials = [gridMaterial]
            
            planeNode.geometry = plane
            
            node.addChildNode(planeNode)
            
            print("plane rendered")
            
            print(planeAnchor.center.x)
            print(planeAnchor.center.y)
            print(planeAnchor.center.z)
            
            posX = CGFloat((planeAnchor.center.x))
            posY = CGFloat((planeAnchor.center.y))
            posZ = CGFloat((planeAnchor.center.z))
            
            
            }
            
        else{

                }
        }
    }
    
    func renderer(_ renderer: SCNSceneRenderer, didUpdate node: SCNNode, for anchor: ARAnchor) {
        guard let planeAnchor = anchor as?  ARPlaneAnchor,
            let planeNode = node.childNodes.first
            else { return }
        
        
        let x = CGFloat(planeAnchor.center.x)
        let y = CGFloat(planeAnchor.center.y)
        let z = CGFloat(planeAnchor.center.z)
        planeNode.position = SCNVector3(x, y, z)
    }
    
    
    @IBAction func threeButton(_ sender: UIButton) {
        
        let cube = SCNBox(width: 0.03, height: 0.09, length: 0.06, chamferRadius: 0)
        
        let material = SCNMaterial()
        
        material.diffuse.contents = UIColor.green
        
        cube.materials = [material]
        
        let node = SCNNode()
        
        node.position = SCNVector3(posX, posY, posZ)
            
        node.geometry = cube
        
        sceneView.scene.rootNode.addChildNode(node)
        
        posX = posX + 0.03
    }
    
        

        

    @IBAction func fourButton(_ sender: UIButton) {
        
        let cube = SCNBox(width: 0.04, height: 0.09, length: 0.06, chamferRadius: 0)
        
        let material = SCNMaterial()
        
        material.diffuse.contents = UIColor.blue
        
        cube.materials = [material]
        
        let node = SCNNode()
        
        node.position = SCNVector3(posX, posY, posZ)
        
        node.geometry = cube
        
        sceneView.scene.rootNode.addChildNode(node)
        
        posX = posX + 0.04
        
    }
    



    
    @IBAction func fiveButton(_ sender: UIButton) {
        
        let cube = SCNBox(width: 0.05, height: 0.09, length: 0.06, chamferRadius: 0)
        
        let material = SCNMaterial()
        
        material.diffuse.contents = UIColor.red

        cube.materials = [material]
        
        let node = SCNNode()
        
        node.position = SCNVector3(posX, posY, posZ)
            
        node.geometry = cube
        
        sceneView.scene.rootNode.addChildNode(node)

        posX = posX + 0.05
    }
    

    
    
}

