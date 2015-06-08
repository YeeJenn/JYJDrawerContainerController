//
//  AppDelegate.swift
//  JYJDrawerContainerController
//
//  Created by Mr.Jim on 6/8/15.
//  Copyright (c) 2015 Jim. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {

        window = UIWindow(frame: UIScreen.mainScreen().bounds)
        window?.backgroundColor = UIColor.whiteColor()
        
        // 左侧视图
        let leftViewController = UIViewController()
        leftViewController.view.backgroundColor = UIColor(patternImage: UIImage(named: "leftview_background")!)
        
        // 中间视图（嵌套导航控制器）
        let centerViewController = CenterViewController()
        centerViewController.view.backgroundColor = UIColor.whiteColor()

        let centerNavigationController = UINavigationController(rootViewController: centerViewController)
        centerNavigationController.navigationBar.barTintColor = UIColor(red: 11/255, green: 135/255, blue: 248/255, alpha: 1)
        centerNavigationController.navigationBar.tintColor = UIColor.whiteColor()
        centerNavigationController.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        
        
        // 侧拉视图控制器
        let drawerContainerController = JYJDrawerContainerController(centerViewController: centerNavigationController, leftViewController: leftViewController)
        
        
        window?.rootViewController = drawerContainerController
        window?.makeKeyAndVisible()
        
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

