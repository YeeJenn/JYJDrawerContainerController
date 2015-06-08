//
//  CenterViewController.swift
//  JYJDrawerContainerController
//
//  Created by Mr.Jim on 6/8/15.
//  Copyright (c) 2015 Jim. All rights reserved.
//

import UIKit

class CenterViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "主页"
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "baritem_menu"), style: .Plain, target: self, action: "leftBarButtonDidTap")
        
        
    }
    
    func leftBarButtonDidTap(){
        self.drawerContainerViewController?.toggleLeftViewController()
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
