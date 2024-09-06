//
//  AppViewProxyServer.swift
//  TnCameraMaster
//
//  Created by Thinh Nguyen on 9/6/24.
//

import Foundation
import SwiftUI
import TnCameraBase

struct TnCameraAppViewProxyServer: TnCameraAppViewProtocol {
    typealias TAppViewModel = TnCameraAppViewProxyServerModel
    
    @StateObject var appModel: TAppViewModel
    var bottom: Optional<some View> {
        nil as EmptyView?
    }
    var showToolbar: State<Bool> = .init(initialValue: true)
}
