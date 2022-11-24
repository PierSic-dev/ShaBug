//
//  ContentView.swift
//  ShaBug
//
//  Created by Pierpaolo Siciliano on 23/11/22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            CameraView()
                .preferredColorScheme(.dark)
                .tabItem {
                    Label("Camera", systemImage: "camera")
                }
            ProfileView()
                .preferredColorScheme(.dark)
                .tabItem {
                    Label("Profile", systemImage: "person")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.dark)
    }
}
