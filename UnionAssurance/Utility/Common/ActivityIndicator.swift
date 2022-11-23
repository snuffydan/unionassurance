//
//  ActivityIndicator.swift
//  UnionAssurance
//
//  Created by Danushika Priyadarshani on 2022-11-23.
//

import UIKit

open class ActivityIndicator {
    
    internal static var spinner: UIActivityIndicatorView?
    public static var style: UIActivityIndicatorView.Style = .whiteLarge
    public static var baseBackColor = UIColor.darkGray.withAlphaComponent(0.5)
    public static var baseColor = UIColor.orange
    public static func start(style: UIActivityIndicatorView.Style = style, backColor: UIColor = baseBackColor, baseColor: UIColor = baseColor) {
        NotificationCenter.default.addObserver(self, selector: #selector(update), name: UIDevice.orientationDidChangeNotification, object: nil)
        if spinner == nil, let window = UIApplication.shared.keyWindow {
            UIApplication.shared.beginIgnoringInteractionEvents()
            let frame = UIScreen.main.bounds
            spinner = UIActivityIndicatorView(frame: frame)
            spinner!.backgroundColor = backColor
            spinner!.style = style
            spinner?.color = baseColor
            window.addSubview(spinner!)
            spinner!.startAnimating()
        }
    }
    public static func stop() {
        if spinner != nil {
            UIApplication.shared.endIgnoringInteractionEvents()
            spinner!.stopAnimating()
            spinner!.removeFromSuperview()
            spinner = nil
        }
    }
    @objc public static func update() {
        if spinner != nil {
            stop()
            start()
        }
    }
}
