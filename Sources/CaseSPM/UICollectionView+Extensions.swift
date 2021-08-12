//
//  UICollectionView+Extensions.swift
//  CaseSPM
//
//  Created by Baran Güngör on 12.08.2021.
//

#if canImport(UIKit)
import UIKit

public extension UICollectionView {
  func calculateWidth(for numberOfItemsInRow: CGFloat) -> CGFloat {
    guard let flowLayout = self.collectionViewLayout as? UICollectionViewFlowLayout else {
      assertionFailure("No Flow Layout")
      return 0
    }
    let width = (frame.width - (flowLayout.minimumInteritemSpacing * (numberOfItemsInRow + 1))) / numberOfItemsInRow
    return width.rounded(.down)
  }
}

// MARK: - Methods
public extension UICollectionView {
    
  ///   Dequeue reusable UICollectionViewCell using class name.
  ///
  /// - Parameters:
  ///   - name: UICollectionViewCell type.
  ///   - indexPath: location of cell in collectionView.
  /// - Returns: UICollectionViewCell object with associated class name.
  func dequeueReusableCell<T: UICollectionViewCell>(withClass name: T.Type, for indexPath: IndexPath, identifier: String? = nil) -> T {
    let reuseIdentifier = identifier == nil ? String(describing: name) : identifier!
    guard let cell = dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? T else {
      fatalError("Couldn't find UICollectionViewCell for \(reuseIdentifier)")
    }
    return cell
  }
  
  ///   Dequeue reusable UICollectionReusableView using class name.
  ///
  /// - Parameters:
  ///   - kind: the kind of supplementary view to retrieve. This value is defined by the layout object.
  ///   - name: UICollectionReusableView type.
  ///   - indexPath: location of cell in collectionView.
  /// - Returns: UICollectionReusableView object with associated class name.
  func dequeueReusableSupplementaryView<T: UICollectionReusableView>(ofKind kind: String, withClass name: T.Type, for indexPath: IndexPath) -> T {
    guard let cell = dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: String(describing: name), for: indexPath) as? T else {
      fatalError("Couldn't find UICollectionReusableView for \(String(describing: name))")
    }
    return cell
  }
  
  ///   Register UICollectionReusableView using class name.
  ///
  /// - Parameters:
  ///   - kind: the kind of supplementary view to retrieve. This value is defined by the layout object.
  ///   - name: UICollectionReusableView type.
  func register<T: UICollectionReusableView>(supplementaryViewOfKind kind: String, withClass name: T.Type) {
    register(T.self, forSupplementaryViewOfKind: kind, withReuseIdentifier: String(describing: name))
  }
  
  ///   Register UICollectionViewCell using class name.
  ///
  /// - Parameters:
  ///   - nib: Nib file used to create the collectionView cell.
  ///   - name: UICollectionViewCell type.
  func register<T: UICollectionViewCell>(nib: UINib?, forCellWithClass name: T.Type) {
    register(nib, forCellWithReuseIdentifier: String(describing: name))
  }
  
  ///   Register UICollectionViewCell using class name.
  ///
  /// - Parameter name: UICollectionViewCell type.
  func register<T: UICollectionViewCell>(cellWithClass name: T.Type, identifier: String? = nil) {
     let reuseIdentifier = identifier == nil ? String(describing: name) : identifier!
    register(T.self, forCellWithReuseIdentifier: reuseIdentifier)
  }
  
  ///   Register UICollectionReusableView using class name.
  ///
  /// - Parameters:
  ///   - nib: Nib file used to create the reusable view.
  ///   - kind: the kind of supplementary view to retrieve. This value is defined by the layout object.
  ///   - name: UICollectionReusableView type.
  func register<T: UICollectionReusableView>(nib: UINib?, forSupplementaryViewOfKind kind: String, withClass name: T.Type) {
    register(nib, forSupplementaryViewOfKind: kind, withReuseIdentifier: String(describing: name))
  }
  
  ///   Register UICollectionViewCell with .xib file using only its corresponding class.
  ///               Assumes that the .xib filename and cell class has the same name.
  ///
  /// - Parameters:
  ///   - name: UICollectionViewCell type.
  ///   - bundleClass: Class in which the Bundle instance will be based on.
  func register<T: UICollectionViewCell>(nibWithCellClass name: T.Type, at bundleClass: AnyClass? = nil) {
    let identifier = String(describing: name)
    var bundle: Bundle?
    
    if let bundleName = bundleClass {
      bundle = Bundle(for: bundleName)
    }
    
    register(UINib(nibName: identifier, bundle: bundle), forCellWithReuseIdentifier: identifier)
  }
  
}

#endif
