//
//  MainView+new.swift
//  tCamera
//
//  Created by Thinh Nguyen on 7/22/24.
//

import Foundation
import SwiftUI
import Combine
import TnCameraBase

public struct TnCameraToolbarMainView<TBottom: View, TCameraManager: TnCameraProtocol>: View, TnCameraViewProtocol {
    @EnvironmentObject public var cameraModel: TnCameraViewModel
    let cameraManager: TCameraManager

    @State var capturedImage: UIImage?

    let bottom: TBottom?

    public var body: some View {
        HStack {
            if let capturedImage = self.capturedImage {
                Image(uiImage: capturedImage)
                    .tnMakeScalable()
                    .frame(width: 80, height: 80)
            }
            
            if cameraModel.status == .started {
                Spacer()
                circleButtonRotation(imageName: cameraModel.settings.cameraPosition.imageName) {
                    cameraManager.switchCamera()
                }

                Spacer()
                getSettingsButton(type: .zoom, text: cameraModel.settings.zoomFactor.toString("%0.1fx"))

                if let bottom {
                    Spacer()
                    bottom
                }

                // capture
                Spacer()
                circleButtonRotation(imageName: "camera", radius: 90, backColor: .white, imageColor: .black) {
                    cameraManager.captureImage { capturedImage in
                        withAnimation {
                            self.capturedImage = capturedImage
                        }
                    }
                }

                // settings
                Spacer()
                circleButtonRotation(imageName: "gear", radius: 50) {
                    cameraModel.settingsType = cameraModel.settingsType == .misc ? .none : .misc
                }

                Spacer()
            }
        }
        .onAppear {
//            cameraManager.toggleCapturing()
        }
    }
}
