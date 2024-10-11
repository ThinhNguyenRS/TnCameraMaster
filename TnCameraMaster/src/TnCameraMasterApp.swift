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
//    init() {
//        print("test async ...")
//
//        let t = TestAsync()
//        t.callCompletion(x: 100)
//        t.callCompletion(x: 0)
//        
//        t.callAsync(x: 100)
//        t.callAsync(x: 0)
//        
//        print("test async !")
//    }
        
    var body: some Scene {
        WindowGroup {
            TnCameraAppView(
                master: true,
                bleInfo: TnCameraProxyServiceInfo.getBle(),
                transportingInfo: TnCameraProxyServiceInfo.getTransporting(EOM: nil, MTU: nil, encoder: TnBinaryEncoder(), decoder: TnBinaryDecoder())
            )
        }
    }
}

