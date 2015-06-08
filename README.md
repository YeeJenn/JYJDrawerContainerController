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
	
	window?.rootViewController = drawerContainerController
	
```

# Toggle Menu

You can use ```toggleLeftViewController``` Method to make leftViewController open (if it is closed) or close (if it is open)

# How to access drawerContainerController?
You can access ```drawerContainerController``` using ```self.drawerContainerController``` in any drawerContainerController's child view controllers
