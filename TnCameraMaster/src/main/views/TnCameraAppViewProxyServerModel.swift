//
//  AppViewModelProxyServer.swift
//  TnCameraMaster
//
//  Created by Thinh Nguyen on 9/6/24.
//

import Foundation
import TnCameraBase

class TnCameraAppViewProxyServerModel: TnCameraAppViewModelDefault<TnCameraProxyServer>, TnCameraViewModelDelegate {
    func onVolumeButton() {
        cameraManager.captureImage(completion: { uiImage in })
    }
    
    func onChanged(settings: TnCameraSettings, status: TnCameraStatus) {
        cameraManager.send(
            TnCameraMessageSettingsResponse(settings: cameraManager.settings, status: status)
        )
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [self] in
            cameraManager.sendImage()
        }
    }
    
    override func setup() {
        cameraModel.delegate = self
        cameraManager.bleDelegate = cameraManager
        super.setup(withOrientation: true)
    }
}
