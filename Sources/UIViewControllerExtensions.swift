//
//  UIViewControllerExtensions.swift
//  EZSwiftExtensions
//
//  Created by Goktug Yilmaz on 15/07/15.
//  Copyright (c) 2015 Goktug Yilmaz. All rights reserved.

#if os(iOS) || os(tvOS)

import UIKit

extension UIViewController {
    // MARK: - Notifications
    
    ///EZSE: Adds an NotificationCenter with name and Selector
    public func addNotificationObserver(_ name: String, selector: Selector) {
        NotificationCenter.default.addObserver(self, selector: selector, name: NSNotification.Name (name), object: nil)
    }
    
    ///EZSE: Removes an NSNotificationCenter for name
    public func removeNotificationObserver(_ name: String) {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name (name), object: nil)
    }
    
    ///EZSE: Removes NotificationCenter'd observer
    public func removeNotificationObserver() {
        NotificationCenter.default.removeObserver(self)
    }
    
    #if os(iOS)
    
    ///EZSE: Adds a NotificationCenter Observer for keyboardWillShowNotification()
    ///
    /// ⚠️ You also need to implement ```keyboardWillShowNotification(_ notification: Notification)```
    public func addKeyboardWillShowNotification() {
        self.addNotificationObserver(UIResponder.keyboardWillShowNotification.rawValue, selector: #selector(UIViewController.keyboardWillShowNotification(_:)))
    }
    
    ///EZSE:  Adds a NotificationCenter Observer for keyboardDidShowNotification()
    ///
    /// ⚠️ You also need to implement ```keyboardDidShowNotification(_ notification: Notification)```
    public func addKeyboardDidShowNotification() {
        self.addNotificationObserver(UIResponder.keyboardDidShowNotification.rawValue, selector: #selector(UIViewController.keyboardDidShowNotification(_:)))
    }
    
    ///EZSE:  Adds a NotificationCenter Observer for keyboardWillHideNotification()
    ///
    /// ⚠️ You also need to implement ```keyboardWillHideNotification(_ notification: Notification)```
    public func addKeyboardWillHideNotification() {
        self.addNotificationObserver(UIResponder.keyboardWillHideNotification.rawValue, selector: #selector(UIViewController.keyboardWillHideNotification(_:)))
    }
    
    ///EZSE:  Adds a NotificationCenter Observer for keyboardDidHideNotification()
    ///
    /// ⚠️ You also need to implement ```keyboardDidHideNotification(_ notification: Notification)```
    public func addKeyboardDidHideNotification() {
        self.addNotificationObserver(UIResponder.keyboardDidHideNotification.rawValue, selector: #selector(UIViewController.keyboardDidHideNotification(_:)))
    }
    
    ///EZSE: Removes keyboardWillShowNotification()'s NotificationCenter Observer
    public func removeKeyboardWillShowNotification() {
        self.removeNotificationObserver(UIResponder.keyboardWillShowNotification.rawValue)
    }
    
    ///EZSE: Removes keyboardDidShowNotification()'s NotificationCenter Observer
    public func removeKeyboardDidShowNotification() {
        self.removeNotificationObserver(UIResponder.keyboardDidShowNotification.rawValue)
    }
    
    ///EZSE: Removes keyboardWillHideNotification()'s NotificationCenter Observer
    public func removeKeyboardWillHideNotification() {
        self.removeNotificationObserver(UIResponder.keyboardWillHideNotification.rawValue)
    }
    
    ///EZSE: Removes keyboardDidHideNotification()'s NotificationCenter Observer
    public func removeKeyboardDidHideNotification() {
        self.removeNotificationObserver(UIResponder.keyboardDidHideNotification.rawValue)
    }
    
    @objc open func keyboardDidShowNotification(_ notification: Notification) {
        if let nInfo = (notification as NSNotification).userInfo, let value = nInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            
            let frame = value.cgRectValue
            keyboardDidShowWithFrame(frame)
        }
    }
    
    @objc open func keyboardWillShowNotification(_ notification: Notification) {
        if let nInfo = (notification as NSNotification).userInfo, let value = nInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            
            let frame = value.cgRectValue
            keyboardWillShowWithFrame(frame)
        }
    }
    
    @objc open func keyboardWillHideNotification(_ notification: Notification) {
        if let nInfo = (notification as NSNotification).userInfo, let value = nInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            
            let frame = value.cgRectValue
            keyboardWillHideWithFrame(frame)
        }
    }
    
    @objc open func keyboardDidHideNotification(_ notification: Notification) {
        if let nInfo = (notification as NSNotification).userInfo, let value = nInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            
            let frame = value.cgRectValue
            keyboardDidHideWithFrame(frame)
        }
    }
    
    public func keyboardWillShowWithFrame(_ frame: CGRect) {
        
    }
    
    public func keyboardDidShowWithFrame(_ frame: CGRect) {
        
    }
    
    public func keyboardWillHideWithFrame(_ frame: CGRect) {
        
    }
    
    public func keyboardDidHideWithFrame(_ frame: CGRect) {
        
    }
    
    //EZSE: Makes the UIViewController register tap events and hides keyboard when clicked somewhere in the ViewController.
    public func hideKeyboardWhenTappedAround(cancelTouches: Bool = false) {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = cancelTouches
        view.addGestureRecognizer(tap)
    }
    
    #endif
    
    //EZSE: Dismisses keyboard
    @objc open func dismissKeyboard() {
        view.endEditing(true)
    }
    
    // MARK: - VC Container
    
    ///EZSE: Returns maximum y of the ViewController
    public var top: CGFloat {
        if let me = self as? UINavigationController, let visibleViewController = me.visibleViewController {
            return visibleViewController.top
        }
        if let nav = self.navigationController {
            if nav.isNavigationBarHidden {
                return view.top
            } else {
                return nav.navigationBar.bottom
            }
        } else {
            return view.top
        }
    }
    
    ///EZSE: Returns minimum y of the ViewController
    public var bottom: CGFloat {
        if let me = self as? UINavigationController, let visibleViewController = me.visibleViewController {
            return visibleViewController.bottom
        }
        if let tab = tabBarController {
            if tab.tabBar.isHidden {
                return view.bottom
            } else {
                return tab.tabBar.top
            }
        } else {
            return view.bottom
        }
    }
    
    ///EZSE: Returns Tab Bar's height
    public var tabBarHeight: CGFloat {
        if let me = self as? UINavigationController, let visibleViewController = me.visibleViewController {
            return visibleViewController.tabBarHeight
        }
        if let tab = self.tabBarController {
            return tab.tabBar.frame.size.height
        }
        return 0
    }
    
    ///EZSE: Returns Navigation Bar's height
    public var navigationBarHeight: CGFloat {
        if let me = self as? UINavigationController, let visibleViewController = me.visibleViewController {
            return visibleViewController.navigationBarHeight
        }
        if let nav = self.navigationController {
            return nav.navigationBar.h
        }
        return 0
    }
    
    ///EZSE: Returns Navigation Bar's color
    public var navigationBarColor: UIColor? {
        get {
            if let me = self as? UINavigationController, let visibleViewController = me.visibleViewController {
                return visibleViewController.navigationBarColor
            }
            return navigationController?.navigationBar.tintColor
        } set(value) {
            navigationController?.navigationBar.barTintColor = value
        }
    }
    
    ///EZSE: Returns current Navigation Bar
    public var navBar: UINavigationBar? {
        return navigationController?.navigationBar
    }
    
    /// EZSwiftExtensions
    public var applicationFrame: CGRect {
        return CGRect(x: view.x, y: top, width: view.w, height: bottom - top)
    }
    
    // MARK: - VC Flow
    
    ///EZSE: Pushes a view controller onto the receiver’s stack and updates the display.
    public func pushVC(_ vc: UIViewController) {
        navigationController?.pushViewController(vc, animated: true)
    }
    
    ///EZSE: Pops the top view controller from the navigation stack and updates the display.
    public func popVC() {
        _ = navigationController?.popViewController(animated: true)
    }

    /// EZSE: Hide or show navigation bar
    public var isNavBarHidden: Bool {
        get {
            return (navigationController?.isNavigationBarHidden)!
        }
        set {
            navigationController?.isNavigationBarHidden = newValue
        }
    }
    
    /// EZSE: Added extension for popToRootViewController
    public func popToRootVC() {
        _ = navigationController?.popToRootViewController(animated: true)
    }
    
    ///EZSE: Presents a view controller modally.
    public func presentVC(_ vc: UIViewController) {
        present(vc, animated: true, completion: nil)
    }
    
    ///EZSE: Dismisses the view controller that was presented modally by the view controller.
    public func dismissVC(completion: (() -> Void)? ) {
        dismiss(animated: true, completion: completion)
    }
    
    ///EZSE: Adds the specified view controller as a child of the current view controller.
    public func addAsChildViewController(_ vc: UIViewController, toView: UIView) {
        self.addChild(vc)
        toView.addSubview(vc.view)
        vc.didMove(toParent: self)
    }
    
    ///EZSE: Adds image named: as a UIImageView in the Background
    public func setBackgroundImage(_ named: String) {
        let image = UIImage(named: named)
        let imageView = UIImageView(frame: view.frame)
        imageView.image = image
        view.addSubview(imageView)
        view.sendSubviewToBack(imageView)
    }
    
    ///EZSE: Adds UIImage as a UIImageView in the Background
    @nonobjc func setBackgroundImage(_ image: UIImage) {
        let imageView = UIImageView(frame: view.frame)
        imageView.image = image
        view.addSubview(imageView)
        view.sendSubviewToBack(imageView)
    }
    
    #if os(iOS)

    @available(*, deprecated)
    public func hideKeyboardWhenTappedAroundAndCancelsTouchesInView() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    #endif
}

#endif
