//
//  AppointmentsPageViewController.swift
//  AR Kitchen Planner
//
//  Created by citstudent2 on 01/05/2019.
//  Copyright © 2019 BPH-Solutions. All rights reserved.
//

import UIKit

class AppointmentsPageViewController: UIViewController {

    @IBOutlet weak var txtFname: UITextField!
    
    @IBOutlet weak var txtLname: UITextField!
    
    @IBOutlet weak var txtEmail: UITextField!
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    

    @IBAction func btnCheck(_ sender: UIButton) {
        
        if(txtFname.text?.count == 0){
            let alert = UIAlertController(title: "Oops!", message: "Please enter your first name.", preferredStyle: .alert)
            
            let Confirm = UIAlertAction(title: "OK", style: .default, handler: {(UIAlertAction) in
                
            })
            
            alert.addAction(Confirm)
            
            present(alert, animated: true, completion: nil)
            
        }else if(txtLname.text?.count == 0){
            let alert = UIAlertController(title: "Oops!", message: "Please enter your last name.", preferredStyle: .alert)
            
            let Confirm = UIAlertAction(title: "OK", style: .default, handler: {(UIAlertAction) in
                
            })
            
            alert.addAction(Confirm)
            
            present(alert, animated: true, completion: nil)
            
        }else         if(txtEmail.text?.count == 0){
            let alert = UIAlertController(title: "Oops!", message: "Please enter your first name.", preferredStyle: .alert)
            
            let Confirm = UIAlertAction(title: "OK", style: .default, handler: {(UIAlertAction) in
                
            })
            
            alert.addAction(Confirm)
            
            present(alert, animated: true, completion: nil)
            
        }
    

}

}
