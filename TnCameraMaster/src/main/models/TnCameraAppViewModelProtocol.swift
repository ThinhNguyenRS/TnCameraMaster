//
//  AppViewModelProtocol.swift
//  TnCameraMaster
//
//  Created by Thinh Nguyen on 9/6/24.
//

import Foundation
import TnCameraBase

public protocol TnCameraAppViewModelProtocol: ObservableObject {
    associatedtype TCameraManager: TnCameraProxyProtocol
    var cameraManager: TCameraManager { get }
    var cameraModel: TnCameraViewModel { get }
    
    func setup()
}
