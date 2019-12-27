//
//  ViewController.swift
//  SQL1
//
//  Created by COE-05 on 27/12/19.
//  Copyright © 2019 COE-05. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var data = [[String:Any]]()
    var EditData = [String:Any]()
    
    var dbObj:DBManager?
    
    
    @IBOutlet weak var Name: UITextField!
    
    @IBOutlet weak var Class: UITextField!
    
    @IBAction func btn(_ sender: UIButton) {
       
        var cmd = ""
        if(EditData.keys.count == 0)
        {
            // to insert
            
            cmd = "insert into tbl(Name,Class) values(\"\(Name.text!)\",\"\(Class.text!)\")"
            
        }
        else{
            //to update
            cmd = "update tbl set name = '\(Class.text!)' where Id = \(Name.text!)"
            
            Name.text = ""
            Class.text = ""
         
            EditData = [String:Any]()
        }
        
        if ((dbObj?.Execute(SQLCommnad: cmd))!)
        {
            print("Inserted")
        }
        else{
            print("Not Inserted")
        }
        
        
        
        
    }
    
    override func viewDidLoad() {
        dbObj = DBManager()
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnn(_ sender: UIButton) {
        let LoginPage = self.storyboard?.instantiateViewController(withIdentifier: "Page2")
        self.navigationController?.pushViewController(LoginPage!, animated: true)
    }
    

}

