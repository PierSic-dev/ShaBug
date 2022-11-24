//
//  CameraPreviewView.swift
//  ShaBug
//
//  Created by Pierpaolo Siciliano on 23/11/22.
//

import SwiftUI

struct CameraPreviewView: View {
    @Binding var image: Image?
    
    var body: some View {
        GeometryReader { geometry in
            if let image = image {
                image
                    .resizable()
                    .scaledToFill()
                    .frame(
                        width: geometry.size.width,
                        height: geometry.size.height
                    )
            }
        }
    }
}

struct CameraPreviewView_Previews: PreviewProvider {
    static var previews: some View {
        CameraPreviewView(image: .constant(Image(systemName: "camera")))
            .preferredColorScheme(.dark)
    }
}
