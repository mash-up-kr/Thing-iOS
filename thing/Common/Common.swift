//
//  Common.swift
//  thing
//
//  Created by 이재성 on 2019/06/14.
//  Copyright © 2019 mashup. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

func presentAlert(msg: String) {
    let alertController = UIAlertController(title: "Error", message: msg, preferredStyle: .alert)
    alertController.addAction(UIAlertAction(title: "Close", style: .cancel, handler: { _ in
        (UIApplication.shared.delegate as! AppDelegate).alertWindow.isHidden = true
    }))
    alertController.modalPresentationStyle = .fullScreen
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let vc = UIViewController()
    vc.view.backgroundColor = .clear
    appDelegate.alertWindow.rootViewController = vc
    appDelegate.alertWindow.makeKeyAndVisible()
    vc.present(alertController, animated: true, completion: nil)
}

func presentErrorAlert(error: Error?) {
    hideActivityIndicator()
    
    let alertController = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
    alertController.addAction(UIAlertAction(title: "Close", style: .cancel, handler: { _ in
        (UIApplication.shared.delegate as! AppDelegate).alertWindow.isHidden = true
    }))
    alertController.modalPresentationStyle = .fullScreen
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let vc = UIViewController()
    vc.view.backgroundColor = .clear
    appDelegate.alertWindow.rootViewController = vc
    appDelegate.alertWindow.makeKeyAndVisible()
    vc.present(alertController, animated: true, completion: nil)
}

func Log<T>(_ object: @autoclosure () -> T, _ file: String = #file, _ function: String = #function, _ line: Int = #line) {
    #if DEBUG
    let value = object()
    let fileURL = NSURL(string: file)?.lastPathComponent ?? "Unknown file"
    let queue = Thread.isMainThread ? "UI" : "BG"
    
    print("❤️ <\(queue)> \(fileURL) \(function)[\(line)]: " + String(reflecting: value))
    #endif
}

var activityIndicator: NVActivityIndicatorView?

extension UIViewController {
    func showActivityIndicator() {
        let width: CGFloat = 50
        let height: CGFloat = 50
        let x: CGFloat = (UIScreen.main.bounds.maxX - width) / 2
        let y: CGFloat = (UIScreen.main.bounds.maxY - height) / 2
        let frame = CGRect(x: x, y: y, width: width, height: height)
        let activityIndicatorView = NVActivityIndicatorView(frame: frame, type: NVActivityIndicatorType.allCases.randomElement(), color: .white, padding: 8)
        activityIndicator?.stopAnimating()
        activityIndicator = activityIndicatorView
        activityIndicatorView.backgroundColor = UIColor(named: "brownGrey")
        activityIndicatorView.alpha = 0.8
        activityIndicatorView.cornerRadius = 5
        view.addSubview(activityIndicatorView)
        
        activityIndicatorView.startAnimating()
    }
}

func hideActivityIndicator() {
    activityIndicator?.stopAnimating()
}
