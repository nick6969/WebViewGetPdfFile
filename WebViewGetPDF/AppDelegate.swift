//
//  AppDelegate.swift
//  WebViewGetPDF
//
//  Created by Nick on 2018/11/16.
//  Copyright © 2018 kcin.nil.app. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        window = UIWindow(frame:UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.backgroundColor = .white
        window?.rootViewController = UINavigationController(rootViewController: MainVC())


        return true
    }

}

public struct OptionalEdge {
    public var top: CGFloat?
    public var left: CGFloat?
    public var bottom: CGFloat?
    public var right: CGFloat?
    public init(top: CGFloat? = nil, left: CGFloat? = nil, bottom: CGFloat? = nil, right: CGFloat? = nil) {
        self.top = top
        self.left = left
        self.bottom = bottom
        self.right = right
    }
}

extension UIView {
    
    @discardableResult
    func mLay( _ attribute: NSLayoutConstraint.Attribute,
               _ relatedBy: NSLayoutConstraint.Relation,
               _ toItem: UIView?,
               _ attribute1: NSLayoutConstraint.Attribute,
               multiplier: CGFloat,
               constant: CGFloat,
               active: Bool = true,
               priority: UILayoutPriority = .init(1000)) -> NSLayoutConstraint {
        self.translatesAutoresizingMaskIntoConstraints = false
        let layout =  NSLayoutConstraint(item: self,
                                         attribute: attribute,
                                         relatedBy: relatedBy,
                                         toItem: toItem,
                                         attribute: attribute1,
                                         multiplier: multiplier,
                                         constant: constant)
        layout.priority = priority
        layout.isActive = active
        return layout
    }
    
    @discardableResult
    func mLay(_ attribute: NSLayoutConstraint.Attribute,
              _ relatedBy: NSLayoutConstraint.Relation,
              _ toItem: UIView?,
              active: Bool = true,
              priority: UILayoutPriority = .init(1000)) -> NSLayoutConstraint {
        return mLay(attribute,
                    relatedBy,
                    toItem,
                    attribute,
                    multiplier: 1,
                    constant: 0,
                    active: active,
                    priority: priority)
    }
    
    @discardableResult
    func mLay(_ attribute: NSLayoutConstraint.Attribute,
              _ constant: CGFloat,
              active: Bool = true,
              priority: UILayoutPriority = .init(1000)) -> NSLayoutConstraint {
        return mLay(attribute,
                    .equal,
                    nil,
                    attribute,
                    multiplier: 1,
                    constant: constant,
                    active: active,
                    priority: priority)
    }
    
    @discardableResult
    func mLay(_ attribute: NSLayoutConstraint.Attribute,
              _ relatedBy: NSLayoutConstraint.Relation,
              _ toItem: UIView?,
              multiplier: CGFloat,
              constant: CGFloat,
              active: Bool = true,
              priority: UILayoutPriority = .init(1000)) -> NSLayoutConstraint {
        return mLay(attribute,
                    relatedBy,
                    toItem,
                    attribute,
                    multiplier: multiplier,
                    constant: constant,
                    active: active,
                    priority: priority)
    }
    
    @discardableResult
    func mLay(_ attribute: NSLayoutConstraint.Attribute,
              _ relatedBy: NSLayoutConstraint.Relation,
              _ toItem: UIView?,
              constant: CGFloat,
              active: Bool = true,
              priority: UILayoutPriority = .init(1000)) -> NSLayoutConstraint {
        return mLay(attribute,
                    relatedBy,
                    toItem,
                    attribute,
                    multiplier: 1,
                    constant: constant,
                    active: active,
                    priority: priority)
    }
    
    @discardableResult
    func mLay(_ attribute: NSLayoutConstraint.Attribute,
              _ relatedBy: NSLayoutConstraint.Relation,
              _ toItem: UIView?,
              _ attribute1: NSLayoutConstraint.Attribute,
              constant: CGFloat,
              active: Bool = true,
              priority: UILayoutPriority = .init(1000)) -> NSLayoutConstraint {
        return mLay(attribute,
                    relatedBy,
                    toItem,
                    attribute1,
                    multiplier: 1,
                    constant: constant,
                    active: active,
                    priority: priority)
    }
    
    @discardableResult
    func mLay(pin: UIEdgeInsets, to view: UIView? = nil) -> [NSLayoutConstraint] {
        assert(view != nil || superview != nil, "can't add Constraint to nil , superview and parmater view is nil")
        let useView = view ?? superview!
        return [
            mLay(.top, .equal, useView, constant: pin.top),
            mLay(.left, .equal, useView, constant: pin.left ),
            mLay(.bottom, .equal, useView, constant: -pin.bottom),
            mLay(.right, .equal, useView, constant: -pin.right)
        ]
    }
    
    @discardableResult
    func mLayEqualSuper() -> [NSLayoutConstraint] {
        return mLay(pin: .zero)
    }
    
    @discardableResult
    func mLay(pin: OptionalEdge, to view: UIView? = nil) -> [NSLayoutConstraint] {
        assert(view != nil || superview != nil, "can't add Constraint to nil , superview and parmater view is nil")
        var arr: [NSLayoutConstraint] = []
        let useView = view ?? superview!
        if let top    = pin.top {  arr.append( mLay(.top, .equal, useView, constant: top    ) ) }
        if let left   = pin.left {  arr.append( mLay(.left, .equal, useView, constant: left   ) ) }
        if let bottom = pin.bottom {  arr.append( mLay(.bottom, .equal, useView, constant: -bottom ) ) }
        if let right  = pin.right {  arr.append( mLay(.right, .equal, useView, constant: -right  ) ) }
        return arr
    }
    
    @discardableResult
    func mLayCenterXY(to view: UIView? = nil) -> [NSLayoutConstraint] {
        assert(view != nil || superview != nil, "can't add Constraint to nil , superview and parmater view is nil")
        let useView = view ?? superview!
        return [
            mLay(.centerY, .equal, useView),
            mLay(.centerX, .equal, useView)
        ]
    }
    
    @discardableResult
    func mLay(size: CGSize) -> [NSLayoutConstraint] {
        return [ mLay( .height, size.height), mLay( .width, size.width)]
    }
    
}

extension UIView {
    @objc enum mLayDirection: Int {
        case top
        case left
        case bottom
        case right
        
        func getLayoutAttribute() -> NSLayoutConstraint.Attribute {
            switch self {
            case .top: return .top
            case .left: return .left
            case .bottom: return .bottom
            case .right: return .right
            }
        }
    }
    
    // Auto Active
    @discardableResult
    @objc func mLayEqualSafeArea(with item: UIView, direction: mLayDirection, constant: CGFloat = 0, active: Bool = true) -> NSLayoutConstraint {
        if #available(iOS 11.0, *) {
            self.translatesAutoresizingMaskIntoConstraints = false
            let guide: UILayoutGuide = item.safeAreaLayoutGuide
            switch direction {
            case .top: return topAnchor.constraint(equalTo: guide.topAnchor, constant: constant).active(bool: active)
            case .left: return leftAnchor.constraint(equalTo: guide.leftAnchor, constant: constant).active(bool: active)
            case .bottom: return bottomAnchor.constraint(equalTo: guide.bottomAnchor, constant: constant).active(bool: active)
            case .right: return rightAnchor.constraint(equalTo: guide.rightAnchor, constant: constant).active(bool: active)
            }
        } else {
            return mLay(direction.getLayoutAttribute(), .equal, item, constant: constant, active: active)
        }
    }
    
    @discardableResult
    func mLaySafe(pin: OptionalEdge, to view: UIView? = nil) -> [NSLayoutConstraint] {
        assert(view != nil || superview != nil, "can't add Constraint to nil , superview and parmater view is nil")
        var arr: [NSLayoutConstraint] = []
        let view = view ?? superview!
        if let value = pin.top { arr.append( mLayEqualSafeArea(with: view, direction: .top, constant: value )) }
        if let value = pin.left { arr.append( mLayEqualSafeArea(with: view, direction: .left, constant: value  )) }
        if let value = pin.bottom { arr.append( mLayEqualSafeArea(with: view, direction: .bottom, constant: -value)) }
        if let value = pin.right { arr.append( mLayEqualSafeArea(with: view, direction: .right, constant: -value )) }
        return arr
    }
}

extension NSLayoutConstraint {
    @discardableResult
    func active(bool: Bool) -> NSLayoutConstraint {
        self.isActive = bool
        return self
    }
}
