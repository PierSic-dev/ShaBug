//
//  ClassificationView.swift
//  ShaBug
//
//  Created by Pierpaolo Siciliano on 24/11/22.
//

import SwiftUI

struct ClassificationView: View {
    @Environment(\.dismiss) var dismiss
    
    @ObservedObject var model: DataModel
    
    lazy var test1 = CIImage(cvPixelBuffer: model.camera.photoResult!)
    lazy var test2 = UIImage(ciImage: test1)
    lazy var test3 = Image(uiImage: test2)
    
    var body: some View {
        NavigationStack {
            VStack {
                if model.camera.photoResult != nil {
                    Image(uiImage: UIImage(ciImage: CIImage(cvPixelBuffer: model.camera.photoResult!)))
                    Text(model.classifyInsect(image: model.camera.photoResult!)!)
                } else {
                    Image(systemName: "x.circle")
                    Text("Error with the photo")
                }
            }
            .toolbar {
                ToolbarItem(
                    placement: .navigationBarTrailing
                ){
                    Button {
                        model.camera.isPhotoReady = false
                        dismiss()
                    } label: {
                        Text("Done")
                            .bold()
                    }
                }
            }
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct ClassificationView_Previews: PreviewProvider {
    static var previews: some View {
        ClassificationView(model: DataModel())
            .preferredColorScheme(.dark)
    }
}
