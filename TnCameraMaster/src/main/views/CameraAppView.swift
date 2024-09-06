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

//enum AppViewManagerType: Int, TnEnum {
//    static var allMap: Dictionary<Self, String> {
//        [
//            .none: "",
//            .server: "Server",
//            .clientBle: "BLE",
//            .clientGrpc: "GRPC"
//        ]
//    }
//    
//    case none
//    case server
//    case clientBle
//    case clientGrpc
//}
//
//struct CameraAppView: View, TnCameraViewProtocol {
//    @EnvironmentObject var cameraModel: TnCameraViewModel
//    @State var managerType: AppViewManagerType = .none
//    
//    var body: some View {
//        ZStack {
//            switch managerType {
//            case .server:
//                TnCameraAppViewProxyServer(
//                    appModel: TnCameraAppViewProxyServerModel(cameraManager: TnCameraProxyServer.shared, cameraModel: cameraModel)
//                )
//            case .clientBle:
//                TnCameraAppViewProxyClient(
//                    appModel: TnCameraAppViewProxyClientModel(cameraManager: TnCameraProxyClient.shared, cameraModel: cameraModel)
//                )
//            default:
//                EmptyView()
//            }
//            
//            if managerType == .none {
//                VStack(alignment: .leading, content: {
//                    HStack {
//                        circleButtonRotation(text: "Master", radius: 120) {
//                            managerType = .server
//                        }
//                        Spacer()
//                        circleButtonRotation(text: "Slaver", radius: 120) {
//                            managerType = .clientBle
//                        }
//                    }
//                })
//                .frame(maxWidth: .infinity, maxHeight: .infinity)
//                .padding(.all, 16)
//            }
//        }
//    }
//}
//
