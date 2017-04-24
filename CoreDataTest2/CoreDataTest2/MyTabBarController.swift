//
//  MyTabBarController.swift
//  CoreDataTest2
//
//  Created by ETHEM YENİAY on 18/01/2017.
//  Copyright © 2017 Adil Alpkocak. All rights reserved.
//

import UIKit

class MyTabBarController: UITabBarController {

   
    override func viewDidLoad() {
        super.viewDidLoad()

       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.tabBar.barTintColor = UIColor.darkGray
     
        self.tabBar.tintColor = UIColor(red: 0.133, green: 0.545, blue: 0.133, alpha: 1.0)
    }
    

  
}//////
