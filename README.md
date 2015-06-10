# JYJDrawerContainerController
A lightweight framework for drawing controller
#Appearance
![Demo](http://g.recordit.co/zPFMJf2DN8.gif)

#Built-in
Copy the file ```JYJDrawerContainerController.swift``` into your project

#Usage

```Swift

	// letViewController
	let leftViewController = UIViewController()
	
	// centerViewController
	let centerViewController = UIViewController()
	
	// drawerContainerController
	let drawerContainerController = JYJDrawerContainerController(centerViewController: centerNavigationController, leftViewController: leftViewController)
	
	// the maxinum leftViewController ratio to containerView , default is 0.78
    drawerContainerController.maximunOffsetRatio = 0.75
        
    // the minimum velocity for triggering toggleLeftViewController , default is 100
    drawerContainerController.minVelocityX = 120
    
    // the minimum scale for centerViewController, default is 0.8
    drawerContainerController.maximunOffsetRatio = 0.6
    
    // the duration for centerViewController moving from left to right, default is 0.20
    drawerContainerController.animationDuration = 0.15
	
	window?.rootViewController = drawerContainerController
	
```

# Toggle Menu

You can use ```toggleLeftViewController``` method to make leftViewController open (if it is closed) or close (if it is open)

# How to access drawer container controller?
You can access ```drawerContainerController``` using ```self.drawerContainerController``` in any drawerContainerController's child view controllers
