//
//  DataModel.swift
//  ShaBug
//
//  Created by Pierpaolo Siciliano on 23/11/22.
//

import CoreML
import Foundation
import SwiftUI

final class DataModel: ObservableObject {
    var camera = CameraModel()
    
    @Published var viewfinderImage: Image?
    
    init() {
        Task {
            await handleCameraPreviews()
        }
    }
    
    func handleCameraPreviews() async {
        let imageStream = camera.previewStream
            .map { $0.image }

        for await image in imageStream {
            Task { @MainActor in
                viewfinderImage = image
            }
        }
    }
    
    func classifyInsect(image: CVPixelBuffer) -> String? {
        do {
            let config = MLModelConfiguration()
            let mlModel = try Insect_Classifier_1(configuration: config)
            
            let prediction = try mlModel.prediction(image: image)
            
            return prediction.classLabel
        } catch let error {
            print("Error using mlmodel: \(error.localizedDescription)")
            return nil
        }
    }
}

fileprivate extension CIImage {
    var image: Image? {
        let ciContext = CIContext()
        guard let cgImage = ciContext.createCGImage(self, from: self.extent) else { return nil }
        return Image(decorative: cgImage, scale: 1, orientation: .up)
    }
}
