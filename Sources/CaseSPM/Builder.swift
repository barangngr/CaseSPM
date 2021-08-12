//
//  Builder.swift
//  CaseSPM
//
//  Created by Baran Güngör on 12.08.2021.
//

#if canImport(UIKit)
import UIKit

public protocol Builder {}

extension Builder {
  public func with(_ configure: (inout Self) -> Void) -> Self {
    var this = self
    configure(&this)
    return this
  }
}

extension NSObject: Builder {}

public protocol With {}

extension With where Self: AnyObject {
  @discardableResult
  public func with<T>(_ property: ReferenceWritableKeyPath<Self, T>, setTo value: T) -> Self {
    self[keyPath: property] = value
    return self
  }
}

extension UIView: With {}
#endif
