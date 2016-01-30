//
//  CenterViewController.swift
//  JYJDrawerContainerController
//
//  Created by Mr.Jim on 6/8/15.
//  Copyright (c) 2015 Jim. All rights reserved.
//

import UIKit


class CenterViewController: UIViewController {
    
    
    var maximunOffsetRatioLabel: UILabel!
    var minimumScaleRatioLabel: UILabel!
    var animationDurationLabel: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "Home"
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "baritem_menu"), style: .Plain, target: self, action: "leftBarButtonDidTap")
        
        
        maximunOffsetRatioLabel = UILabel()
        maximunOffsetRatioLabel.text = "MaximunOffsetRatio = 0.78"
        maximunOffsetRatioLabel.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(maximunOffsetRatioLabel)
        
        let maximunOffsetRatioSlider = UISlider()
        maximunOffsetRatioSlider.maximumValue = 1
        maximunOffsetRatioSlider.value = 0.78
        maximunOffsetRatioSlider.addTarget(self, action: "maximunOffsetRatioSliderDidChangeValue:", forControlEvents: .ValueChanged)
        maximunOffsetRatioSlider.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(maximunOffsetRatioSlider)
        
        
        
        
        minimumScaleRatioLabel = UILabel()
        minimumScaleRatioLabel.text = "MinimumScaleRatio = 0.80"
        minimumScaleRatioLabel.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(minimumScaleRatioLabel)
        
        let minimumScaleRatioSlider = UISlider()
        minimumScaleRatioSlider.maximumValue = 1
        minimumScaleRatioSlider.value = 0.8
        minimumScaleRatioSlider.addTarget(self, action: "minimumScaleRatioSliderDidChangeValue:", forControlEvents: .ValueChanged)
        minimumScaleRatioSlider.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(minimumScaleRatioSlider)
        
        
        
        
        
        animationDurationLabel = UILabel()
        animationDurationLabel.text = "AnimationDuration = 0.20"
        animationDurationLabel.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(animationDurationLabel)
        
        let animationDurationSlider = UISlider()
        animationDurationSlider.maximumValue = 1
        animationDurationSlider.value = 0.2
        animationDurationSlider.addTarget(self, action: "animationDurationSliderDidChangeValue:", forControlEvents: .ValueChanged)
        animationDurationSlider.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(animationDurationSlider)
        
        
        
        
        
        
        // AutoLayout UI
        
        let dic = ["maximunOffsetRatioLabel":maximunOffsetRatioLabel, "maximunOffsetRatioSlider":maximunOffsetRatioSlider, "minimumScaleRatioLabel": minimumScaleRatioLabel,"animationDurationLabel":animationDurationLabel, "animationDurationSlider":animationDurationSlider, "minimumScaleRatioSlider":minimumScaleRatioSlider]
 
        
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-[maximunOffsetRatioLabel]-|", options: [], metrics: nil, views: dic))
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-[maximunOffsetRatioSlider]-|", options: [], metrics: nil, views: dic))
        
        
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-[minimumScaleRatioLabel]-|", options: [], metrics: nil, views: dic))
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-[minimumScaleRatioSlider]-|", options: [], metrics: nil, views: dic))
        
        
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-[animationDurationLabel]-|", options: [], metrics: nil, views: dic))
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-[animationDurationSlider]-|", options: [], metrics: nil, views: dic))
        
        
        
        self.view.addConstraint(NSLayoutConstraint(item: minimumScaleRatioSlider, attribute: .CenterY, relatedBy: .Equal, toItem: self.view, attribute: .CenterY, multiplier: 1, constant: 0))
        
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[maximunOffsetRatioLabel]-[maximunOffsetRatioSlider]-[minimumScaleRatioLabel]-[minimumScaleRatioSlider]-[animationDurationLabel]-[animationDurationSlider]", options: [], metrics: nil, views: dic))
        
    }
    
    func leftBarButtonDidTap(){
        self.drawerContainerViewController?.toggleLeftViewController()
    }
    
    
    func maximunOffsetRatioSliderDidChangeValue(maximunOffsetRatioSlider: UISlider){
        maximunOffsetRatioLabel.text = NSString(format: "MaximunOffsetRatio = %.2f", maximunOffsetRatioSlider.value) as String
        self.drawerContainerViewController?.maximunOffsetRatio = CGFloat(maximunOffsetRatioSlider.value)
    }
    
    func minimumScaleRatioSliderDidChangeValue(minimumScaleRatioSlider: UISlider){
        minimumScaleRatioLabel.text = NSString(format: "MinimumScaleRatio = %.2f", minimumScaleRatioSlider.value) as String
        self.drawerContainerViewController?.minimumScaleRatio = CGFloat(minimumScaleRatioSlider.value)
    }
    
    func animationDurationSliderDidChangeValue(animationDurationSlider: UISlider){
        animationDurationLabel.text = NSString(format: "AnimationDuration = %.2f", animationDurationSlider.value) as String 
        self.drawerContainerViewController?.animationDuration = Double(animationDurationSlider.value)
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
