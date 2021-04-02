//
//  Modal.swift
//  Manhattan
//
//  Created by Alex Permiakov on 3/19/21.
//  Copyright © 2021 Manhattan. All rights reserved.
//

import UIKit

protocol Modal {
    func show(animated: Bool)
    func dismiss(animated: Bool)
    var backgroundView: UIView { get }
    var dialogView: UIView { get set }
}

extension Modal where Self: UIView {
    func show(animated: Bool) {
        self.backgroundView.alpha = 0
        self.dialogView.alpha = 0
        
        let keyWindow = UIApplication.shared.windows.filter { $0.isKeyWindow }.first
        
        if var topController = keyWindow?.rootViewController {
            while let presentedViewController = topController.presentedViewController {
                topController = presentedViewController
            }
            topController.view.addSubview(self)
        }
        if animated {
            UIView.animate(withDuration: 0.5, animations: {
                self.backgroundView.alpha = 0.5
                self.dialogView.alpha = 1
            })
        } else {
            self.backgroundView.alpha = 0.5
            self.dialogView.alpha = 1
        }
    }
    
    func dismiss(animated: Bool) {
        if animated {
            UIView.animate(withDuration: 0.5, animations: {
                self.backgroundView.alpha = 0
                self.dialogView.alpha = 0
            }, completion: { _ in
                self.removeFromSuperview()
            })
        } else {
            self.removeFromSuperview()
        }
    }
}
