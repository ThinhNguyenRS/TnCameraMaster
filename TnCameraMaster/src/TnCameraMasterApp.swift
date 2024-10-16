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
            TnCameraAppView(
                master: true,
                bleInfo: TnCameraProxyServiceInfo.getBle(),
                transportingInfo: TnCameraProxyServiceInfo.getTransporting(EOM: nil, MTU: nil, encoder: TnBinaryEncoder(), decoder: TnBinaryDecoder()),
                delegate: nil
            )
        }
    }
}

