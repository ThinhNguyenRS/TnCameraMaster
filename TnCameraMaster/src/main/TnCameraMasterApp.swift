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
//    private let motionOrientation: DeviceMotionOrientationListener = DeviceMotionOrientationListener.shared
//    @StateObject var cameraModel: TnCameraViewModel = .init() /*cameraModelInstance*/
    
    var bodyMain: some Scene {
        WindowGroup {
            CameraAppView()
                .background(.black)
//                .environmentObject(cameraModel)
//                .onAppear {
//                    motionOrientation.start()
//                    
//                    UITableViewCell.appearance().backgroundColor = UIColor(Color.red.opacity(0.5))
//                    UITableView.appearance().separatorStyle = .none
//                    UITableView.appearance().backgroundColor = UIColor(Color.red.opacity(0.5))
//                }
//                .onDisappear {
//                    motionOrientation.stop()
//                }
        }
    }
    
    var body: some Scene {
        bodyMain
    }
}
