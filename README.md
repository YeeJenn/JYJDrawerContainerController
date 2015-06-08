# JYJDrawerContainerController
A lightweight framework for drawing controller
#Apearance
![](http://g.recordit.co/Gh51fyjlEE.gif)

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
    drawerContainerController.minvelocityX = 120
	
	window?.rootViewController = drawerContainerController
	
```

# Toggle Menu

You can use ```toggleLeftViewController``` Method to make leftViewController open (if it is closed) or close (if it is open)

# How to access drawer container controller?
You can access ```drawerContainerController``` using ```self.drawerContainerController``` in any drawerContainerController's child view controllers
