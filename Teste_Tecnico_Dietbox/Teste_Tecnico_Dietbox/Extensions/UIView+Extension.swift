//
//  UIView+Extension.swift
//  Teste_Tecnico_Dietbox
//
//  Created by Leonardo Hollas on 20/09/21.
//

import UIKit

extension UIView {
    public func showLoading() {
        Loading.shared.showLoading(view: self)
    }
    
    public func hideLoading() {
        Loading.shared.hideLoading(view: self)
    }
}
