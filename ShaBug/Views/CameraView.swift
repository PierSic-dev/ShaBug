//
//  CameraView.swift
//  ShaBug
//
//  Created by Pierpaolo Siciliano on 23/11/22.
//

import SwiftUI

struct CameraView: View {
    @StateObject var model = DataModel()
    
    private static let barHeightFactor = 0.15
    
    var body: some View {
        NavigationStack {
            GeometryReader { geometry in
                // camera preview
                CameraPreviewView(image: $model.viewfinderImage)
                // Black top bar
                    .overlay(alignment: .top) {
                        Color.black
                            .opacity(0.75)
                            .frame(height: geometry.size.height * Self.barHeightFactor)
                    }
                // black bottom bar
                    .overlay(alignment: .bottom) {
                        HStack {
                            Spacer()
                            Button {
                                model.camera.takePhoto()
                            } label: {
                                Label {
                                    Text("Shutter button")
                                } icon: {
                                    ZStack {
                                        Circle()
                                            .fill(.white)
                                            .frame(width: 50, height: 50)
                                        Circle()
                                            .stroke(.white, lineWidth: 3)
                                            .frame(width: 62, height: 62)
                                    }
                                }
                            }
                            .sheet(isPresented: $model.camera.isPhotoReady) {
                                ClassificationView(model: model)
                            }
                            Spacer()
                        }
                        .buttonStyle(.plain)
                        .labelStyle(.iconOnly)
                        .frame(height: geometry.size.height * Self.barHeightFactor)
                        .background(.black.opacity(0.75))
                    }
                    .background(.gray)
            }
            .navigationTitle("Camera")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarHidden(true)
            .ignoresSafeArea(.all, edges: [.top, .horizontal])
        }
        .task {
            await model.camera.start()
        }
        .alert("Camera access denied", isPresented: $model.camera.alert) {
            Button("OK") {}
        } message: {
            Text("The camera is required to scan insects.\nPlease, go to Settings > My Picture Insect > Camera and turn on the switch")
        }
    }
}

struct CameraView_Previews: PreviewProvider {
    static var previews: some View {
        CameraView()
            .preferredColorScheme(.dark)
    }
}
