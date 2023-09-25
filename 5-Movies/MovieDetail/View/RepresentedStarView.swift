//
//  RepresentedStarView.swift
//  5-Movies
//
//  Created by M-M-M on 31/05/2023.
//

import Foundation
import SwiftUI

struct RepresntedStarView: UIViewRepresentable {
    typealias UIViewType = StarView
    @Binding var isSelected: Bool
    
    func makeUIView(context: Context) -> StarView {
        return StarView(frame: CGRect(x: 0, y: 0, width: 35, height: 35))
    }
    
    func updateUIView(_ uiView: StarView, context: Context) {
        uiView.isSelected = isSelected
    }
}
