//
//  TestViewUpdates.swift
//  TnCameraMaster
//
//  Created by Thinh Nguyen on 9/25/24.
//

import SwiftUI
import Combine
import TnIosBase
import TnCameraBase

class TestModel: NSObject, ObservableObject, TnLoggable {
    @Published var toolbarType: TnCameraToolbarViewType = .none
    @Published var showToolbar = false

    override init() {
        super.init()
        
        logDebug("inited")
    }
}

struct TestMainView: View, TnLoggable {
    @StateObject var model: TestModel = .init()
    
    init() {
        logDebug("inited")
    }
    
    var body: some View {
        ZStack {
            TestPreview()

            TestToolbar()
            
            TestGenericView()
            
            TestGenericView {
                Text("Generic view")
            }
        }
        .environmentObject(model)
    }
}

struct TestPreview: View, TnLoggable {
    @EnvironmentObject var model: TestModel

    init() {
        logDebug("inited")
    }

    var body: some View {
        Rectangle()
            .fill(Color.orange)
            .overlay {
                Text("Camera preview")
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .onTapGesture {
                model.showToolbar.toggle()
            }
    }
}

struct TestToolbar: View, TnLoggable {
    @EnvironmentObject var model: TestModel
    
    init() {
        logDebug("inited")
    }
    
    var body: some View {
        if model.showToolbar {
            VStack {
                Spacer()
                switch model.toolbarType {
                case .zoom:
                    TesToolbarZoom()
                case .misc:
                    TestToolbarMisc()
                default:
                    EmptyView()
                }
                TestToolbarMain()
            }
        }
    }
}

struct TestToolbarMain: View, TnLoggable {
    @EnvironmentObject var model: TestModel
    
    init() {
        logDebug("inited")
    }

    var body: some View {
        HStack {
            Button("Zoom") {
                model.toolbarType = .zoom
            }
            
            Button("Capture") {
            }

            Button("Misc") {
                model.toolbarType = .misc
            }
        }
    }
}

struct TestToolbarMisc: View, TnLoggable {
    init() {
        logDebug("inited")
    }

    var body: some View {
        HStack {
            Button("M 1") {
            }
            
            Button("M 2") {
            }

            Button("M 3") {
            }
        }
    }
}

struct TesToolbarZoom: View, TnLoggable {
    init() {
        logDebug("inited")
    }

    var body: some View {
        Text("\(Self.Type.self)")
    }
}

#Preview {
    TestMainView()
}


struct TestGenericView<TExtView: View>: View, TnLoggable {
    @ViewBuilder var extView: () -> TExtView?

    init(extView: @escaping () -> TExtView?) {
        self.extView = extView
        logDebug("inited")
    }
    
    var body: some View {
        VStack {
            Text("")
            extView()
        }
    }
}

extension TestGenericView where TExtView == EmptyView {
    init() {
        self.init(extView: { nil })
    }
}
