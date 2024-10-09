//
//  UIImageView+Extensions.swift
//  MovieNow
//
//  Created by Ahmet Yalcinkaya on 08/10/2024.
//

import UIKit

extension UIImageView {

    func setImage(with url: String) {
        guard let imageURL = URL(string: url) else { return }
        setImage(with: imageURL)
    }

    func setImage(with url: URL) {
        let dataTask = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil,
                  let image = UIImage(data: data) else { return }

            DispatchQueue.main.async() {
                self.image = image
            }
        }
        dataTask.resume()
    }
}
