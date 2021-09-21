//
//  UIImageView+Extension.swift
//  Teste_Tecnico_Dietbox
//
//  Created by Leonardo Hollas on 20/09/21.
//

import UIKit

extension UIImageView {
    func downloadImage(_ urlString: String?) {

        guard let imageURLString = urlString else {
            return
        }

        guard let url = URL(string: imageURLString) else {
            return
        }

        DispatchQueue.global().async { [weak self] in
            let data = try? Data(contentsOf: url)
            DispatchQueue.main.async {
                self?.image = data != nil ? UIImage(data: data!) : UIImage()
            }
        }
    }
}
