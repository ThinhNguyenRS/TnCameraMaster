//
//  TestAsync.swift
//  TnCameraMaster
//
//  Created by Thinh Nguyen on 9/15/24.
//

import Foundation

struct TestAsync {
    func funcCompletion(x: Int, completion: @escaping (Int) -> Void) {
        if x > 0 {
            completion(100)
        } else {
            completion(0)
        }
    }

    func funcAsync(x: Int) async -> Int {
        await withCheckedContinuation { continuation in
            funcCompletion(x: x) { v in
                continuation.resume(returning: v)
            }
        }
    }

    func callCompletion(x: Int) {
        print("completion ...", x)
        funcCompletion(x: x) { v in
            print("completion return", v)
        }
    }

    func callAsync(x: Int) {
        print("async ...", x)
        Task {
            let v = await funcAsync(x: x)
            print("async return", v)
        }
    }
}
