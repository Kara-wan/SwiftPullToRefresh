//
//  ScrollViewExtension.swift
//  PullToRefresh
//
//  Created by Leo Zhou on 2017/4/30.
//  Copyright © 2017年 Leo Zhou. All rights reserved.
//

import UIKit

private var refreshViewKey: UInt8 = 0

public extension UIScrollView {
    private var spr_refreshView: RefreshView? {
        get {
            return objc_getAssociatedObject(self, &refreshViewKey) as? RefreshView
        }
        set {
            objc_setAssociatedObject(self, &refreshViewKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            newValue.map { insertSubview($0, at: 0) }
        }
    }
    
    public func spr_addArrowRefresh(color: UIColor = Default.arrowColor,
                                    height: CGFloat = Default.arrowViewHeight,
                                    action: @escaping () -> Void) {
        spr_refreshView = RefreshArrowView(color: color, height: height, action: action)
    }
    
    public func spr_addTextRefresh(loadingText: String = Default.loadingText,
                                   pullingText: String = Default.pullingText,
                                   releaseText: String = Default.releaseText,
                                   font: UIFont = Default.textFont,
                                   color: UIColor = Default.textColor,
                                   height: CGFloat = Default.textViewHeight,
                                   action: @escaping () -> Void) {
        spr_refreshView = RefreshTextView(loadingText: loadingText, pullingText: pullingText, releaseText: releaseText, font: font, color: color, height: height, action: action)
    }
    
    public func spr_addGIFRefresh(data: Data,
                                  isBig: Bool = Default.isGIFBig,
                                  height: CGFloat = Default.gifViewHeight,
                                  action: @escaping () -> Void) {
        spr_refreshView = RefreshGIFView(data: data, isBig: isBig, height: height, action: action)
    }
    
    public func spr_addSuperCatRefresh(height: CGFloat = Default.superCatViewHeight,
                                        action: @escaping () -> Void) {
        spr_refreshView = RefreshSuperCatView(height: height, action: action)
    }
    
    public func spr_addCustomRefresh(refreshView: RefreshView) {
        spr_refreshView = refreshView
    }
    
    public func spr_beginRefreshing() {
        spr_refreshView?.beginRefreshing()
    }
    
    public func spr_endRefreshing() {
        spr_refreshView?.endRefreshing()
    }
}

// MARK: default values

struct Default {
    static let arrowColor: UIColor = UIColor.black.withAlphaComponent(0.8)
    static let arrowViewHeight: CGFloat = 60
    
    static let loadingText = "Loading..."
    static let pullingText = "Pull down to refresh"
    static let releaseText = "Release to refresh"
    static let textFont: UIFont = UIFont.systemFont(ofSize: 14)
    static let textColor: UIColor = UIColor.black.withAlphaComponent(0.8)
    static let textViewHeight: CGFloat = 60
    
    static let isGIFBig: Bool = true
    static let gifViewHeight: CGFloat = 120
    
    static let superCatViewHeight: CGFloat = 120
}
