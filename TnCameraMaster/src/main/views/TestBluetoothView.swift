//
//  Bluetooth.swift
//  tCamera
//
//  Created by Thinh Nguyen on 8/15/24.
//

import Foundation
import CoreBluetooth
import SwiftUI
import TnIosBase
import TnCameraBase

class BluetoothServerViewModel: NSObject, ObservableObject {
    @Published var status: TnBluetoothServer.Status = .none
    @Published var receivedCount: Int = 0
    @Published var sentCount: Int = 0

    lazy var ble: TnBluetoothServer = .init(
        info: TnCameraProxyServiceInfo.shared,
        delegate: self)
    
    func setupBle() {
        ble.setupBle()
    }
    
    func start() {
        ble.start()
    }
    
    func stop() {
        ble.stop()
    }
    
    func toggeStart() {
        if status.isIn(.inited, .stopped) {
            ble.start()
        } else {
            ble.stop()
        }
    }
    
    func send(data: Data) {
        ble.send(data: data)
    }
}

extension BluetoothServerViewModel: TnBluetoothServerDelegate {
    func tnBluetoothServer(ble: TnBluetoothServer, statusChanged: TnBluetoothServer.Status) {
        self.status = statusChanged
        TnLogger.debug("BluetoothServerViewModel", "status changed", statusChanged)
        if statusChanged == .inited {
            ble.start()
        }
    }
    
    func tnBluetoothServer(ble: TnBluetoothServer, receivedID: String, receivedData: Data) {
        DispatchQueue.main.async {
            self.receivedCount = receivedData.count
        }
    }
    
    func tnBluetoothServer(ble: TnBluetoothServer, sentIDs: [String], sentData: Data) {
        DispatchQueue.main.async {
            self.sentCount = sentData.count
        }
    }
}

struct BluetoothServerView: View {
    @StateObject var model: BluetoothServerViewModel = .init()
    
    var body: some View {
        VStack(alignment: .leading){
            Text("Bluetooth server. Received: \(model.receivedCount). Sent: \(model.sentCount)")
            tnCircleButton(text: model.status.isIn(.inited, .stopped) ? "Start" : "Stop") {
                model.toggeStart()
            }
            tnCircleButton(text: "Send") {
                model.send(data: Data(count: Int.random(in: 50*1000...100*1000)))
            }.disabled(model.status != .started)
        }
        .background(.black)
        .onAppear {
            model.setupBle()
        }
        .onDisappear {
            model.stop()
        }
    }
}

class BluetoothClientViewModel: NSObject, ObservableObject {
    @Published var status: TnBluetoothClient.Status = .none
    @Published var discoveredList: [TnBluetoothPeripheralInfo] = []
    @Published var connectedList: [TnBluetoothPeripheralInfo] = []

    @Published var receivedCount: Int = 0
    @Published var sentCount: Int = 0

    lazy var client: TnBluetoothClient = .init(
        info: TnCameraProxyServiceInfo.shared,
        delegate: self)
    
    func initManager() {
        client.setupBle()
    }
    
    func send(data: Data) {
        client.send(data: data)
    }
    
    func isConnected(peripheralID: String) -> Bool {
        connectedList.contains(where: { v in v.id == peripheralID })
    }
    
    func connect(peripheralID: String) {
        client.connect(peripheralID: peripheralID)
    }
    
    func disconnect(peripheralID: String) {
        client.disconnect(peripheralID: peripheralID)
    }
}

extension BluetoothClientViewModel: TnBluetoothClientDelegate {
    func tnBluetoothClient(ble: TnBluetoothClient, discoveredID: String) {
        DispatchQueue.main.async {
            TnLogger.debug("BluetoothClientViewModel", "discovered", discoveredID)
            self.discoveredList = ble.discoveredPeripherals.toInfoList()
            self.connectedList = ble.connectedPeripherals.toInfoList()
        }
    }
    
    func tnBluetoothClient(ble: TnBluetoothClient, statusChanged: TnBluetoothClient.Status) {
        DispatchQueue.main.async {
            self.status = statusChanged
            TnLogger.debug("BluetoothClientViewModel", "status changed", statusChanged)
        }
    }
    
    func tnBluetoothClient(ble: TnBluetoothClient, connectedID: String) {
        DispatchQueue.main.async {
            self.connectedList = ble.connectedPeripherals.toInfoList()
        }
    }

    func tnBluetoothClient(ble: TnBluetoothClient, disconnectedID: String) {
        DispatchQueue.main.async {
            self.connectedList = ble.connectedPeripherals.toInfoList()
        }
    }

    func tnBluetoothClient(ble: TnBluetoothClient, receivedID: String, receivedData: Data) {
        DispatchQueue.main.async {
            self.receivedCount = receivedData.count
        }
    }
    
    func tnBluetoothClient(ble: TnBluetoothClient, sentID: String, sentData: Data) {
        DispatchQueue.main.async {
            self.sentCount = sentData.count
        }
    }
}

struct BluetoothClientView: View {
    @StateObject var model: BluetoothClientViewModel = .init()
    
    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)
            VStack(alignment: .leading) {
                Text("Bluetooth client. Received: \(model.receivedCount). Sent: \(model.sentCount)")

                ScrollView {
                    VStack {
                        tnForEach(model.discoveredList, itemView: { idx, v in
                            HStack {
                                Text(v.name)
                                Spacer()
                                
                                TnToggleButton(isOn: {model.isConnected(peripheralID: v.id)}, action: { isOn in
                                    if isOn {
                                        model.connect(peripheralID: v.id)
                                    } else {
                                        model.disconnect(peripheralID: v.id)
                                    }
                                })
                            }
                        })
                    }
                }
                
                Spacer()
                tnCircleButton(text: "Send") {
                    model.send(data: Data(count: Int.random(in: 50*1000...100*1000)))
                }.disabled(model.status != .ready)
            }
        }
        .onAppear {
            model.initManager()
        }
        .onDisappear {
        }
    }
}
