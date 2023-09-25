//
//  ImageURL.swift
//  5-Movies
//
//  Created by M-M-M on 31/05/2023.
//

import Foundation
import SwiftUI
import Combine

struct ImageURL: View {
    var placeHolder: String
    @ObservedObject var loader: ImageLoader
    
    init(url: String, placeHolder: String = "") {
        self.placeHolder = placeHolder
        self.loader = ImageLoader()
        loader.loadImage(url: url)
    }
    
    var body: some View {
        if let unwrappedImage = loader.image {
            return Image(uiImage: unwrappedImage)
                .resizable()
        }
        return Image(placeHolder)
            .resizable()
    }
}

class ImageLoader: ObservableObject {
    @Published var image: UIImage?
    private var imageView: UIImageView? = UIImageView()
    
    func loadImage(url: String) {
        guard let imageURL = URL(string: url) else { return }
        imageView?.sd_setImage(with: imageURL) { image, _, _, _ in
            if let unwrappedImage = image {
                self.image = unwrappedImage
                self.imageView = nil
            }
        }
    }
}
