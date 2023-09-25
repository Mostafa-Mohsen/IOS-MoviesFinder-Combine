//
//  MovieDetailsView.swift
//  5-Movies
//
//  Created by M-M-M on 31/05/2023.
//

import SwiftUI

struct MovieDetailsView: View {
    @State private var isSelected = false
    let movie: Movie
    
    var body: some View {
        ZStack {
            Color.black
            
            VStack {
                HStack {
                    Spacer()
                    RepresntedStarView(isSelected: $isSelected)
                        .frame(width: 35, height: 35)
                        .padding()
                }
                
                ImageURL(url: movie.poster, placeHolder: "")
                    .frame(width: 300, height: 400)
                    .cornerRadius(25)
                
                Text(movie.title)
                    .foregroundColor(.white)
                    .font(.title)
            }
            
        }.edgesIgnoringSafeArea(.all)
    }
}

struct MovieDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        MovieDetailsView(movie: Movie([:]))
    }
}
