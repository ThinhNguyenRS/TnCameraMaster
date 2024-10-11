//
//  SettingsToolbar.swift
//  tCamera
//
//  Created by Thinh Nguyen on 7/30/24.
//

import Foundation
import SwiftUI
import TnIosPackage
import TnCameraBase

struct TnCameraSettingsToolbarVariantView: View, TnCameraViewProtocol {
    @EnvironmentObject var cameraModel: TnCameraViewModel
    let cameraManager: any TnCameraProtocol

    var body: some View {
        Group {
            switch cameraModel.settingsType {
            case .main:
                TnCameraSettingsToolbarMainView(cameraManager: cameraManager)
            case .zoom:
                zoomView                
            case .misc:
                miscView
            default:
                EmptyView()
            }
        }
        .cornerRadius(24)
    }
}

extension TnCameraSettingsToolbarVariantView {
    var zoomView: some View {
        let step = 0.1/2
        return getSliderView(
            value: $cameraModel.settings.zoomFactor,
            label: "Zoom",
            bounds: cameraModel.settings.zoomRange,
            step: step,
            onChanged: { _ in},
            onChanging: { [self] v in
                cameraManager.setZoomFactor(v, withRate: 1, completion: nil)
            },
            specifier: "%0.2f",
            bottomView: {
                HStack {
                    tnCircleButton(imageName: "chevron.backward", radius: 40) {
                        cameraManager.setZoomFactor(cameraModel.settings.zoomFactor - step, withRate: 1, completion: nil)
                    }
                    Spacer()
                    tnForEach(cameraModel.settings.zoomRelativeFactors) { idx, v in
                        Group {
                            tnCircleButton(text: v.toString("%0.1f"), radius: 36, backColor: cameraModel.settings.zoomFactor == v ? .orange : .gray) {
                                cameraManager.setZoomFactor(v, withRate: 1, completion: nil)
                            }
                            Spacer()
                        }
                    }

                    tnCircleButton(imageName: "chevron.forward", radius: 40) {
                        cameraManager.setZoomFactor(cameraModel.settings.zoomFactor + step, withRate: 1, completion: nil)
                    }
                }
            }
        )
    }
            
    var miscView: some View {
        List {
            Section("Camera type") {
                TnPickerField.forEnum(
                    label: "Preset",
                    value: $cameraModel.settings.preset,
                    values: cameraModel.settings.presets,
                    onChanged: { v in
                        cameraManager.setPreset(v)
                    }
                )
                
                TnPickerField.forEnum(
                    label: "Type",
                    value: $cameraModel.settings.cameraType,
                    values: cameraModel.settings.cameraTypes,
                    onChanged: { v in
                        cameraManager.setCameraType(v)
                    }
                )
                
                TnPickerField.forEnum(label: "Priority", value: $cameraModel.settings.quality, onChanged: { v in
                    cameraManager.setQuality(v)
                })
                
                TnToggleField(label: "Live photo", value: $cameraModel.settings.livephoto) { v in
                    cameraManager.setLivephoto(v)
                }
                .toggleStyle(.switch)
                .disabled(!cameraModel.settings.livephotoSupported)
            }

            Section("Light") {
                TnPickerField.forEnum(
                    label: "Flash",
                    value: $cameraModel.settings.flashMode,
                    values: cameraModel.settings.flashModes,
                    onChanged: { v in
                        cameraManager.setFlash(v)
                    }
                )
                .disabled(!cameraModel.settings.flashSupported)
                
                TnPickerField.forEnum(
                    label: "HDR",
                    value: $cameraModel.settings.hdr,
                    onChanged: { v in
                        cameraManager.setHDR(v)
                    }
                )
                .disabled(!cameraModel.settings.hdrSupported)
            }
            
            
            Section("Exposure & Focus") {
                TnPickerField.forEnum(
                    label: "Focus mode",
                    value: $cameraModel.settings.focusMode,
                    values: cameraModel.settings.focusModes,
                    onChanged: { v in
                        cameraManager.setFocusMode(v)
                    }
                )
                
                TnPickerField.forEnum(
                    label: "Exposure mode",
                    value: $cameraModel.settings.exposureMode,
                    values: cameraModel.settings.exposureModes,
                    onChanged: { v in
                        cameraManager.setExposureMode(v)
                    }
                )
                
                VStack {
                    getSliderView(
                        value: $cameraModel.settings.iso,
                        label: "ISO",
                        bounds: cameraModel.settings.isoRange,
                        step: 50,
                        onChanged: { _ in},
                        onChanging: { [self] v in
                            cameraManager.setExposure(iso: v)
                        },
                        specifier: "%.0f",
                        closeable: false
                    )
                    
                    getSliderView(
                        value: $cameraModel.settings.exposureDuration,
                        label: "Shutter speed",
                        bounds: cameraModel.settings.exposureDurationRange,
                        step: 0.001,
                        onChanged: { _ in},
                        onChanging: { [self] v in
                            cameraManager.setExposure(duration: v)
                        },
                        specifier: "%.3f",
                        closeable: false
                    )
                }
                .padding(.horizontal, 16)
                .disabled(cameraModel.settings.exposureMode != .custom)
            }
            .disabled(!cameraModel.settings.exposureSupported)
            
            Section("Virtual apecture") {
                TnToggleField(label: "Embed depth data", value: $cameraModel.settings.depth) { v in
                    cameraManager.setDepth(v)
                }
                .toggleStyle(.switch)
                
                TnToggleField(label: "Embed portrait matte", value: $cameraModel.settings.portrait) { v in
                    cameraManager.setPortrait(v)
                }
                .toggleStyle(.switch)
                .disabled(!(cameraModel.settings.depth && cameraModel.settings.portraitSupported))
            }
            .disabled(!cameraModel.settings.depthSupported)
        }
//        .hideBackground()
    }
}

//extension View {
//    func hideBackground() -> AnyView {
//        var view: AnyView = .init(self)
//        if #available(iOS 16.0, *) {
//            view = .init(self.scrollContentBackground(.hidden))
//        }
//        return view
//    }
//}
