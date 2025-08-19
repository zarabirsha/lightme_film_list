// The Swift Programming Language
// https://docs.swift.org/swift-book
import Foundation
public struct LightmeFilmList {
    public static let json: URL = {
            return Bundle.module.url(forResource: "films", withExtension: "json")!
        }()
    
}
