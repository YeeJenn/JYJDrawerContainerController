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

enum ToggleState {
    case Open
    case Close
}

class JYJDrawerContainerController: UIViewController {
    
    var centerViewController: UIViewController?
    var leftViewController: UIViewController?
    
    private var centerViewStopOriginX: CGFloat! // 中间视图的原点x坐标
    var maximunOffsetRatio: CGFloat = 0.78  // 中间视图最大偏移比例
    var minvelocityX: CGFloat = 100  //触发toggle的最小手指滑动速度
    // centerViewController 最大偏移量
    var maxinumOffsetX: CGFloat {
        return maximunOffsetRatio * self.view.bounds.width
    }
    
    var toggleState: ToggleState = .Close   //左侧视图的开闭状态，初始默认为关闭
    
    init(centerViewController: UIViewController, leftViewController: UIViewController){
        
        self.leftViewController = leftViewController
        self.centerViewController = centerViewController
        
        super.init(nibName: nil, bundle: nil)
    }
    
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        centerViewStopOriginX = centerViewController!.view.frame.origin.x
        
    
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
            centerViewController!.view.addGestureRecognizer(centerTapGestureRecogizer)
        }
        
    }
    
    
    // MARK: - Gesture Recoginzer Event
    
    /**
    中间视图控制器(centerViewController)的拖动手势事件
    
    :param: recognizer 拖动手势
    */
    func centerViewDidPan(recognizer: UIPanGestureRecognizer) {
        
        
        // 手势在container中的x轴移动距离
        var panOffsetX = recognizer.translationInView(self.view).x
        
        
        // 检测侧滑边界，最大不能超过maxium， 最小不能超过0
        if centerViewStopOriginX + panOffsetX <= maxinumOffsetX && centerViewStopOriginX + panOffsetX >= 0 {
            // 更新中间视图位置
            transformCenterViewByoffsetX(centerViewStopOriginX + panOffsetX)
        }
       
    
        // 拖动结束后
        if recognizer.state == .Ended {
            
            // 判断手势pan的速度
            let velocityX = recognizer.velocityInView(self.view).x
            if abs(velocityX) > minvelocityX {
                toggleLeftViewController()
            }else{
                // 如果滑动超过maximunOffsetX的一半，则停靠右边。反之停靠在左边
                if centerViewController!.view.frame.origin.x > 1/2 * maxinumOffsetX {
                    showLeftViewController()
                }else if centerViewController!.view.frame.origin.x < 1/2 * maxinumOffsetX {
                    hideLeftViewController()
                }
            }
            
            // 更新centerViewStopOriginX
            centerViewStopOriginX = centerViewController!.view.frame.origin.x
        }

        
    }
    
    /**
    中间视图控制器(centerViewController)的触摸手势事件
    
    :param: recogizer 中间视图控制器(centerViewController)的触摸手势
    */
    func centerViewDidTap(recogizer: UITapGestureRecognizer){
        
        // 如果目前左侧视图为打开状态，则关闭。
        if toggleState == .Open {
            hideLeftViewController()
        } else {
            showLeftViewController()
        }
    }
    
    
    
    /**
    显示左侧视图
    */
    func showLeftViewController(){
        UIView.animateWithDuration(0.3, delay: 0, options: .CurveEaseInOut, animations: { () -> Void in
            self.transformCenterViewByoffsetX(self.maxinumOffsetX)
        }, completion: nil)
        
        // 开关状态变为开启
        toggleState = .Open
    }
    
    
    /**
    隐藏左侧视图
    */
    func hideLeftViewController(){
        
        UIView.animateWithDuration(0.3, delay: 0, options: .CurveEaseInOut, animations: { () -> Void in
            self.transformCenterViewByoffsetX(0)
        }, completion: nil)
        
        // 开关状态变为关闭
        toggleState = .Close
    }
    
    func toggleLeftViewController(){
        if toggleState == .Open {
            hideLeftViewController()
        }else{
            showLeftViewController()
        }
    }
    

    /**
    通过offsetX, 来改变centerView的位置以及大小
    
    :param: offsetX centerView离最左边的横坐标滑动偏移量
    */
    private func transformCenterViewByoffsetX(offsetX: CGFloat){
        
        if offsetX == 0 {
            toggleState = .Close
        } else if offsetX == maxinumOffsetX {
            toggleState = .Open
        }
        
        let sizeRatio = (0.8 - 1)/(self.maxinumOffsetX - 0) * offsetX + 1  //centerView 大小缩放比例
        self.centerViewController!.view.transform = CGAffineTransformScale(CGAffineTransformIdentity, sizeRatio, sizeRatio)
        self.centerViewController!.view.frame.origin.x = offsetX    //这行代码一定要写在scale后面
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
