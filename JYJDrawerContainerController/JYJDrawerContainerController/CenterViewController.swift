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
    var minmunScaleRatioLabel: UILabel!
    var animationDurationLabel: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "Home"
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "baritem_menu"), style: .Plain, target: self, action: "leftBarButtonDidTap")
        
        
        maximunOffsetRatioLabel = UILabel()
        maximunOffsetRatioLabel.text = "MaximunOffsetRatio = 0.78"
        maximunOffsetRatioLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.view.addSubview(maximunOffsetRatioLabel)
        
        let maximunOffsetRatioSlider = UISlider()
        maximunOffsetRatioSlider.maximumValue = 1
        maximunOffsetRatioSlider.value = 0.78
        maximunOffsetRatioSlider.addTarget(self, action: "maximunOffsetRatioSliderDidChangeValue:", forControlEvents: .ValueChanged)
        maximunOffsetRatioSlider.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.view.addSubview(maximunOffsetRatioSlider)
        
        
        
        
        minmunScaleRatioLabel = UILabel()
        minmunScaleRatioLabel.text = "MaximunOffsetRatio = 0.80"
        minmunScaleRatioLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.view.addSubview(minmunScaleRatioLabel)
        
        let minmunScaleRatioSlider = UISlider()
        maximunOffsetRatioSlider.maximumValue = 1
        minmunScaleRatioSlider.value = 0.8
        minmunScaleRatioSlider.addTarget(self, action: "minmunScaleRatioSliderDidChangeValue:", forControlEvents: .ValueChanged)
        minmunScaleRatioSlider.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.view.addSubview(minmunScaleRatioSlider)
        
        
        
        
        
        animationDurationLabel = UILabel()
        animationDurationLabel.text = "AnimationDuration = 0.20"
        animationDurationLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.view.addSubview(animationDurationLabel)
        
        let animationDurationSlider = UISlider()
        animationDurationSlider.maximumValue = 1
        animationDurationSlider.value = 0.2
        animationDurationSlider.addTarget(self, action: "animationDurationSliderDidChangeValue:", forControlEvents: .ValueChanged)
        animationDurationSlider.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.view.addSubview(animationDurationSlider)
        
        
        
        
        
        
        // AutoLayout UI
        
        let dic = ["maximunOffsetRatioLabel":maximunOffsetRatioLabel, "maximunOffsetRatioSlider":maximunOffsetRatioSlider, "minmunScaleRatioLabel":minmunScaleRatioLabel,"animationDurationLabel":animationDurationLabel,  "animationDurationSlider":animationDurationSlider, "minmunScaleRatioSlider":minmunScaleRatioSlider]
 
        
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-[maximunOffsetRatioLabel]-|", options: nil, metrics: nil, views: dic))
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-[maximunOffsetRatioSlider]-|", options: nil, metrics: nil, views: dic))
        
        
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-[minmunScaleRatioLabel]-|", options: nil, metrics: nil, views: dic))
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-[minmunScaleRatioSlider]-|", options: nil, metrics: nil, views: dic))
        
        
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-[animationDurationLabel]-|", options: nil, metrics: nil, views: dic))
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-[animationDurationSlider]-|", options: nil, metrics: nil, views: dic))
        
        
        
        self.view.addConstraint(NSLayoutConstraint(item: minmunScaleRatioSlider, attribute: .CenterY, relatedBy: .Equal, toItem: self.view, attribute: .CenterY, multiplier: 1, constant: 0))
        
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[maximunOffsetRatioLabel]-[maximunOffsetRatioSlider]-[minmunScaleRatioLabel]-[minmunScaleRatioSlider]-[animationDurationLabel]-[animationDurationSlider]", options: nil, metrics: nil, views: dic))
        
    }
    
    func leftBarButtonDidTap(){
        self.drawerContainerViewController?.toggleLeftViewController()
    }
    
    
    func maximunOffsetRatioSliderDidChangeValue(maximunOffsetRatioSlider: UISlider){
        maximunOffsetRatioLabel.text = NSString(format: "MaximunOffsetRatio = %.2f", maximunOffsetRatioSlider.value) as String
        self.drawerContainerViewController?.maximunOffsetRatio = CGFloat(maximunOffsetRatioSlider.value)
    }
    
    func minmunScaleRatioSliderDidChangeValue(minmunScaleRatioSlider: UISlider){
        minmunScaleRatioLabel.text = NSString(format: "MinmunScaleRatio = %.2f", minmunScaleRatioSlider.value) as String
        self.drawerContainerViewController?.minmunScaleRatio = CGFloat(minmunScaleRatioSlider.value)
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
