//
//  AppView.swift
//  tCamera
//
//  Created by Thinh Nguyen on 8/7/24.
//

import SwiftUI
import TnIosBase
import TnCameraBase


struct CameraAppView: View, TnCameraViewProtocol, TnLoggable {
    let LOG_NAME = "CameraAppView"
    
    @StateObject var cameraModel: TnCameraViewModel = .init() /*cameraModelInstance*/
    private static let cameraManager: TnCameraProxyServer = .init(TnCameraLocal.shared, bluetooth: TnCameraProxyServiceInfo.shared)
    private let motionOrientation: DeviceMotionOrientationListener = DeviceMotionOrientationListener.shared
    
    init() {
        logDebug("inited")
    }
    
    var body: some View {
        TnCameraAppViewProxyServer(
            appModel: TnCameraAppViewProxyServerModel(cameraManager: CameraAppView.cameraManager, cameraModel: cameraModel)
        )
        .environmentObject(cameraModel)
        .onAppear {
            motionOrientation.start()
//            UITableViewCell.appearance().backgroundColor = UIColor(Color.red.opacity(0.5))
//            UITableView.appearance().separatorStyle = .none
//            UITableView.appearance().backgroundColor = UIColor(Color.red.opacity(0.5))
        }
        .onDisappear {
            motionOrientation.stop()
        }
    }
}
