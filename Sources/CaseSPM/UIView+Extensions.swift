//
//  UIView+Extensions.swift
//  CaseSPM
//
//  Created by Baran Güngör on 12.08.2021.
//

#if canImport(UIKit)
import UIKit

public extension UIView {
  enum constraintType {
    case vertically,horizontally,all
  }
  
  func addConstraints(_ format: String, views: UIView...) {
    var viewsDictionary = [String: UIView]()
    for (index, view) in views.enumerated() {
      let key = "v\(index)"
      viewsDictionary[key] = view
      view.translatesAutoresizingMaskIntoConstraints = false
    }
    addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: viewsDictionary))
  }
  
  func fill(_ constraint : constraintType, with space : CGFloat? = nil) {
    guard let superview = superview else { return }
    translatesAutoresizingMaskIntoConstraints = false
    var spaceString = ""
    if let space = space {
      spaceString = "-\(space)-"
    }
    switch constraint {
    case .vertically:
      superview.addConstraints("V:|\(spaceString)[v0]\(spaceString)|", views: self)
    case .horizontally:
      superview.addConstraints("H:|\(spaceString)[v0]\(spaceString)|", views: self)
    case .all:
      superview.addConstraints("H:|\(spaceString)[v0]\(spaceString)|", views: self)
      superview.addConstraints("V:|\(spaceString)[v0]\(spaceString)|", views: self)
    }
  }
  
}

public extension UIView {
  func addSubview(views: UIView...) {
    views.forEach{addSubview($0)}
  }
  
  func addSubview(views: [UIView]) {
    views.forEach{addSubview($0)}
  }
}

#endif
