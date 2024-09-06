//
//  SettingsMainView.swift
//  tCamera
//
//  Created by Thinh Nguyen on 7/30/24.
//

import Foundation
import SwiftUI
import TnCameraBase

struct TnCameraSettingsToolbarMainView: View, TnCameraViewProtocol {
    @EnvironmentObject var cameraModel: TnCameraViewModel
    let cameraManager: any TnCameraProtocol
}

extension TnCameraSettingsToolbarMainView {
    var body: some View {
        HStack {
            Spacer()
            // SWICTH
            circleButtonRotation(imageName: cameraModel.settings.cameraPosition.imageName) {
                cameraManager.switchCamera()
            }

            // ZOOM
            Spacer()
            getSettingsButton(type: .zoom, text: cameraModel.settings.zoomFactor.toString("%0.1fx"))

            
            // MISC
            Spacer()
            getSettingsButton(type: .misc, imageName: "ellipsis")

            Spacer()
        }
    }
}
