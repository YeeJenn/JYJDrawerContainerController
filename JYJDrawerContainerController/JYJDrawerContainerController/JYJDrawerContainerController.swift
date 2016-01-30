//
//  DrawerContainerViewController.swift
//  E-Share
//
//  该视图控制器主要作为一个容器(container)，来提供leftViewController和centerViewController之间的交互
//
//  Created by Mr.Jim on 6/8/15.
//  Copyright (c) 2015 Jim. All rights reserved.
//


import UIKit

/**
开关状态枚举类型，主要用于记录当前leftViewController是否处于打开状态

- Open:  leftViewController处于打开状态
- Close: leftViewController处于关闭状态
*/
enum ToggleState {
    case Open
    case Close
}

/**
*  侧拉控制器，通过手指滑动centerViewController侧拉打开leftViewController
*/
class JYJDrawerContainerController: UIViewController, UIGestureRecognizerDelegate {
    
    var centerViewController: UIViewController?
    var leftViewController: UIViewController?
    
    // centerViewController的待移动位置原点x坐标，起始初始化为0
    private var centerViewTempOriginX: CGFloat! = 0
    
    // centerViewController 最大偏移比例
    var maximunOffsetRatio: CGFloat = 0.78
    
    // centerViewController 最大偏移量
    private var maxinumOffsetX: CGFloat {return maximunOffsetRatio * self.view.bounds.width}
    
    // centerViewController 最小缩放比例
    var minimumScaleRatio: CGFloat = 0.8
    
    // 触发toggle的最小手指滑动速度
    var minVelocityX: CGFloat = 100
    
    // 侧拉动画开始到结束的时间
    var animationDuration: Double = 0.2
    
    //左侧视图的开闭状态，初始默认为关闭
    var toggleState: ToggleState = .Close
    
    
    init(centerViewController: UIViewController, leftViewController: UIViewController){
        
        self.leftViewController = leftViewController
        self.centerViewController = centerViewController
        
        super.init(nibName: nil, bundle: nil)
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        if leftViewController != nil && centerViewController != nil {
            self.view.addSubview(leftViewController!.view)
            self.view.addSubview(centerViewController!.view)
            
            self.addChildViewController(leftViewController!)
            self.addChildViewController(centerViewController!)
            
            // 给中间视图添加pan手势
            let centerPanGestureRecognizer = UIPanGestureRecognizer(target: self, action: "centerViewDidPan:")
            centerViewController!.view.addGestureRecognizer(centerPanGestureRecognizer)
            
            // 给中间视图添加tap手势
            let centerTapGestureRecogizer = UITapGestureRecognizer(target: self, action: "centerViewDidTap:")
            centerTapGestureRecogizer.delegate = self
            centerViewController!.view.addGestureRecognizer(centerTapGestureRecogizer)
        }
        
    }
    
    
    // MARK: - Gesture Recoginzer Event
    
    /**
    中间视图控制器(centerViewController)的拖动手势事件
    
    - parameter recognizer: 拖动手势
    */
    func centerViewDidPan(recognizer: UIPanGestureRecognizer) {
        
        
        // 手势在container中的x轴移动距离
        let panOffsetX = recognizer.translationInView(self.view).x
        
        // centerViewController 将要移动到的位置
        let centerViewWillToOrginX = centerViewTempOriginX + panOffsetX
        
        // 检测侧滑边界，最大不能超过maxium， 最小不能超过0
        if centerViewWillToOrginX <= maxinumOffsetX && centerViewWillToOrginX >= 0 {
            
            // 改变中间视图位置
            transformCenterViewToX(centerViewWillToOrginX)
        }
        
        
        // 如果手指滑动已经结束
        if recognizer.state == .Ended {
            
            // 判断手指滑动速度，如果大于触发开关toggle的阈值，则调用toggleLeftViewController
            let velocityX = recognizer.velocityInView(self.view).x
            if abs(velocityX) >= minVelocityX {
                toggleLeftViewController()
            }else{
                
                // 计算剩余滑动时间
                let currentX = centerViewController!.view.frame.origin.x
                var leftDuration: Double!
                if panOffsetX > 0 {
                    leftDuration = animationDuration * Double((maxinumOffsetX - currentX)/maxinumOffsetX)
                }else{
                    leftDuration = animationDuration * Double(currentX/maxinumOffsetX)
                }
                
                
                // 如果目前centerViewController的滑动距离超过maximunOffsetX的一半，则打开leftViewController，否则关闭leftViewController
                
                if centerViewController!.view.frame.origin.x > maxinumOffsetX/2 {
                    showLeftViewControllerWithDuration(leftDuration)
                }else if centerViewController!.view.frame.origin.x < maxinumOffsetX/2 {
                    hideLeftViewControllerWithDuration(leftDuration)
                }
            }
            // 更新centerViewStopOriginX
            centerViewTempOriginX = centerViewWillToOrginX
            
        }
        
        
    }
    
    
    
    /**
    中间视图控制器(centerViewController)的触摸手势事件
    
    - parameter recogizer: 中间视图控制器(centerViewController)的触摸手势
    */
    func centerViewDidTap(recogizer: UITapGestureRecognizer){
        
        // 如果目前左侧视图为打开状态，则关闭。
        if toggleState == .Open {
            hideLeftViewControllerWithDuration(animationDuration)
        }
    }
    
    
    
    /**
    如果leftViewController处于关闭状态，那么tap事件应该交给下级响应者来处理
    
    - parameter gestureRecognizer: tap手势
    - parameter touch:             tap触摸事件
    
    - returns: 如果当前处于关闭状态那么返回false，如果处于开启状态返回true
    */
    func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldReceiveTouch touch: UITouch) -> Bool {
        if gestureRecognizer is UITapGestureRecognizer && toggleState == .Close {
            return false
        }
        return true
    }
    
    
    
    /**
    显示左侧视图，并且改变toggleState为Open, 并且更新centerTempOriginX 为 maxinumOffsetX
    */
    func showLeftViewControllerWithDuration(duration: Double){
        
        UIView.animateWithDuration(duration, delay: 0, options: .CurveLinear, animations: { () -> Void in
            self.transformCenterViewToX(self.maxinumOffsetX)
            }){[unowned self](finished) -> Void in
                self.toggleState = .Open
                self.centerViewTempOriginX = self.maxinumOffsetX
        }
        
    }
    
    
    
    /**
    隐藏左侧视图，并且改变toggleState为Close, 并且更新centerTempOriginX 为 0
    */
    func hideLeftViewControllerWithDuration(duration: Double){
        UIView.animateWithDuration(duration, delay: 0, options: .CurveLinear, animations: { () -> Void in
            self.transformCenterViewToX(0)
            }){[unowned self](finished) -> Void in
                self.toggleState = .Close
                self.centerViewTempOriginX = 0
        }
    }
    
    
    
    
    /**
    打开或者关闭leftViewController。根据目前leftViewController的状态自动判断是打开还是关闭
    */
    func toggleLeftViewController(){
        if toggleState == .Open {
            hideLeftViewControllerWithDuration(animationDuration)
        }else{
            showLeftViewControllerWithDuration(animationDuration)
        }
    }
    
    
    /**
    通过offsetX, 来改变centerView的位置以及大小
    
    - parameter offsetX: centerView离最左边的横坐标滑动偏移量
    */
    private func transformCenterViewToX(x: CGFloat){
        
        //centerView 大小缩放比例
        let sizeRatio = (minimumScaleRatio - 1)/maxinumOffsetX * x + 1
        
        // 平移变换
        let translation = CGAffineTransformMakeTranslation(x, 0)
        // 缩放变化
        let scale = CGAffineTransformScale(CGAffineTransformIdentity, sizeRatio, sizeRatio)
        
        // 组合变换
        centerViewController!.view.transform = CGAffineTransformConcat(translation, scale)
        
    }
    
}





/**
*  对UIViewController扩展，为了在任何DrawerController的子视图控制器中都能通过self.drawerContainerViewController访问到侧拉控制器
*/
extension UIViewController {
    var drawerContainerViewController: JYJDrawerContainerController? {
        var parentViewController = self.parentViewController
        
        while parentViewController != nil {
            if parentViewController!.isKindOfClass(JYJDrawerContainerController) {
                return parentViewController as? JYJDrawerContainerController
            }
            parentViewController = parentViewController!.parentViewController
        }
        return nil
    }
    
}
