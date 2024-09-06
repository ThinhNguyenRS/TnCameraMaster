//
//  tCameraApp.swift
//  tCamera
//
//  Created by Thinh Nguyen on 7/12/24.
//

import SwiftUI
import SwiftData
import TnIosBase
import TnCameraBase

@main
struct TnCameraMasterApp: App {
    var body: some Scene {
        WindowGroup {
            CameraAppView()
                .background(.black)
        }
    }
}
