//
//  Test.swift
//  tCamera
//
//  Created by Thinh Nguyen on 7/26/24.
//

import SwiftUI

//struct TestSettingsViewPart<TValue: TnEnumValue, TStyle: PickerStyle>: View, CameraViewProtocol {
//    let LOG_NAME = "TestSettingsViewPart"
//
//    let typeOut: Binding<CameraSettingsViewType>
//    let typeIn: CameraSettingsViewType
//
//    let label: String
//    let values: [TValue]
//    let labels: [String]
//    let style: () -> TStyle
//        
//    let value: Binding<TValue>
//    @State private var valueInternal: TValue
//    
//    init(value: Binding<TValue>, typeIn: CameraSettingsViewType, typeOut: Binding<CameraSettingsViewType>, label: String, values: [TValue]? = nil, labels: [String]? = nil, style: @escaping () -> TStyle) {
//        self.label = label
//        self.values = values ?? TValue.allCases
//        self.labels = labels ?? TValue.allNames
//        self.style = style
//        
//        self.typeOut = typeOut
//        self.typeIn = typeIn
//        
//        self.value = value
//        self.valueInternal = self.value.wrappedValue
//
//        TnLogger.debug(LOG_NAME, "init", typeIn, valueInternal.description, value.wrappedValue.description)
//    }
//
//    var body: some View {
//        HStack {
//            VStack(alignment: .leading) {
//                tnText(label)
//                    .onTapGesture {
//                        withAnimation {
//                            TnLogger.debug(LOG_NAME, "close", typeIn, valueInternal.description, value.wrappedValue.description)
//                            typeOut.wrappedValue = .main
//                        }
//                    }
//                TnPickerField(
//                    label: "",
//                    value: $valueInternal,
//                    values: values,
//                    labels: labels,
//                    style: style
//                )
////                .onChange(of: valueInternal) {
////                    TnLogger.debug(LOG_NAME, "change", typeIn, valueInternal.description, value.wrappedValue.description)
////                }
//                
////                Picker(label, selection: $valueInternal) {
////                    ForEach(values) {v in
////                        Text(v.description)
////                    }
////                }
//            }
//            .padding(.all, 8)
//
//            Spacer()
//            
//            circleButton(imageName: "checkmark") {
//                withAnimation {
//                    TnLogger.debug(LOG_NAME, "apply", typeOut.wrappedValue.rawValue.description, valueInternal.description, value.wrappedValue.description)
//                    value.wrappedValue = valueInternal
//                    typeOut.wrappedValue = .main
//                }
//            }
//        }
//    }
//}
//
//struct TestConditionalSettingsView: View {
//    @State var settingsType: CameraSettingsViewType = .cameraType
////    @StateObject var settings: CameraSettings = .init()
//    @State var settings: CameraSettings = .init()
//
//    let types: [CameraSettingsViewType] = [
//        .preset,
//        .cameraType,
//        .flash,
//        .zoom,
//        .position,
//        .exposure
//    ]
//    
//    var body: some View {
//        VStack {
//            TnPickerField(
//                value: $settingsType,
//                values: types,
//                labels: types.map { v in "\(v)"},
//                style: {SegmentedPickerStyle()}
//            )
//            
//            Spacer()
//            if settingsType == .preset {
//                TestSettingsViewPart(
//                    value: $settings.preset,
//                    typeIn: .preset,
//                    typeOut: $settingsType,
//                    label: "Preset",
//                    style: {SegmentedPickerStyle()}
//                )
//            }
//
//            if settingsType == .cameraType {
//                TestSettingsViewPart(
//                    value: $settings.cameraType,
//                    typeIn: .cameraType,
//                    typeOut: $settingsType,
//                    label: "Camera Type",
//                    style: {SegmentedPickerStyle()}
//                )
//            }
//
////            TestSettingsViewPart(
////                value: $settings.preset,
////                typeIn: .preset,
////                typeOut: $settingsType,
////                label: "Preset",
////                style: {SegmentedPickerStyle()}
////            )
////            .tnConditionByType()
//
////            TestSettingsViewPart(
////                value: $settings.cameraType,
////                typeIn: .cameraType,
////                typeOut: $settingsType,
////                label: "Camera Type",
////                style: {SegmentedPickerStyle()}
////            )
////            .tnConditionByType()
//
////            TestSettingsViewPart(typeIn: .cameraType, typeOut: $v).tnConditionByType()
////            TestSettingsViewPart(typeIn: .flash, typeOut: $v).tnConditionByType()
////            TestSettingsViewPart(typeIn: .zoom, typeOut: $v).tnConditionByType()
////            TestSettingsViewPart(typeIn: .position, typeOut: $v).tnConditionByType()
////            TestSettingsViewPart(typeIn: .exposure, typeOut: $v).tnConditionByType()
//        }
//    }
//}
//
