//
//  TnBinaryCodable.swift
//  TnCameraMaster
//
//  Created by Thinh Nguyen on 10/10/24.
//

import Foundation
import TnIosBase
import BinaryCodable

struct TnBinaryEncoder: TnEncoder {
    private let encoder = BinaryEncoder()
    
    func encode<T>(_ value: T) throws -> Data where T : Encodable {
        try encoder.encode(value)
    }
}

struct TnBinaryDecoder: TnDecoder {
    private let decoder = BinaryDecoder()

    func decode<T>(_ type: T.Type, from data: Data) throws -> T where T : Decodable {
        try decoder.decode(type, from: data)
    }
}
