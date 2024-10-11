////
////  TestAppView.swift
////  TnCameraMaster
////
////  Created by Thinh Nguyen on 9/13/24.
////
//
//import SwiftUI
//import TnIosBase
//import TnCameraBase
//
//
//struct TestAppView: View, TnLoggable {
//    let LOG_NAME = "TestAppView"
//    let appModel: TnCameraAppViewModel = TnCameraAppViewModelFactory.createServerModel()
//
//    init() {
//        logDebug("inited")
//    }
//    
//    var body: some View {
//        TnCameraAppView(TnCameraProxyServer.self, bottom: {
//        })
//        .environmentObject(appModel)
//        .environmentObject(appModel.cameraModel)
//    }
//}
