//
//  StarView.swift
//  5-Movies
//
//  Created by M-M-M on 31/05/2023.
//

import Foundation
import UIKit

class StarView: UIView {
    var isSelected = false {
        didSet {
            imageView.image = UIImage(systemName: isSelected ? "star.fill" : "star")
        }
    }
    private var imageView: UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addCustomView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        addCustomView()
    }
    
    func addCustomView() {
        imageView = UIImageView(frame: self.frame)
        imageView.image = UIImage(systemName: "star")
        imageView.isUserInteractionEnabled = true

        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        imageView.addGestureRecognizer(tap)
        
        self.addSubview(imageView)
    }
    
    @objc private func handleTap() {
        isSelected.toggle()
    }
}


