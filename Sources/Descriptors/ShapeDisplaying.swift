
import UIKit

public protocol AbstractShapeDisplaying: AnyObject {
    typealias Update = (CGRect) -> UIBezierPath
}

public enum GenericShape {
    public static func capsule(direction: CapsuleShapeDirection, usesSmoothCurve: Bool) -> AbstractShapeDisplaying.Update {
        return { bounds in
            guard usesSmoothCurve else {
                return UIBezierPath.init(roundedRect: bounds, cornerRadius: .infinity)
            }
            switch direction {
            case .horizontal:
                return UIBezierPath.init(roundedRect: bounds, cornerRadius: bounds.height / 2)
            case .vertical:
                return UIBezierPath.init(roundedRect: bounds, cornerRadius: bounds.width / 2)
            }
        }
    }

    /// Returns an instance that displays rounded corner shape.
    /// Rounded corner uses smooth-curve
    ///
    /// - Parameter radius:
    /// - Returns:
    public static func roundedCorner(radius: CGFloat) -> AbstractShapeDisplaying.Update {
        return { bounds in
            UIBezierPath.init(roundedRect: bounds, cornerRadius: radius)
        }
    }
}

public protocol ShapeDisplaying: AbstractShapeDisplaying {
  init(update: @escaping Update)

  var shapeFillColor: UIColor? { get set }

  var shapeLineWidth: CGFloat { get set }

  var shapeStrokeColor: UIColor? { get set }
}

public protocol MainActorShapeDisplaying: AbstractShapeDisplaying {

    init(update: @escaping Update)

    @MainActor
    var shapeFillColor: UIColor? { get set }

    @MainActor
    var shapeLineWidth: CGFloat { get set }

    @MainActor
    var shapeStrokeColor: UIColor? { get set }
}

extension ShapeDisplaying {

  @discardableResult
  public func setShapeFillColor(_ color: UIColor) -> Self {
    self.shapeFillColor = color
    return self
  }

  @discardableResult
  public func setShapeLineWidth(_ width: CGFloat) -> Self {
    self.shapeLineWidth = width
    return self
  }

  @discardableResult
  public func setStrokeColor(_ color: UIColor) -> Self {
    self.shapeStrokeColor = color
    return self
  }

}

extension MainActorShapeDisplaying {

    @discardableResult
    @MainActor
    public func setShapeFillColor(_ color: UIColor) -> Self {
        self.shapeFillColor = color
        return self
    }

    @discardableResult
    @MainActor
    public func setShapeLineWidth(_ width: CGFloat) -> Self {
        self.shapeLineWidth = width
        return self
    }

    @discardableResult
    @MainActor
    public func setStrokeColor(_ color: UIColor) -> Self {
        self.shapeStrokeColor = color
        return self
    }

}

public enum CapsuleShapeDirection: Sendable {
  case vertical
  case horizontal
}

extension ShapeDisplaying {
    public static func capsule(direction: CapsuleShapeDirection, usesSmoothCurve: Bool) -> Self {
        self.init(update: GenericShape.capsule(direction: direction, usesSmoothCurve: usesSmoothCurve))
    }

    /// Returns an instance that displays rounded corner shape.
    /// Rounded corner uses smooth-curve
    ///
    /// - Parameter radius:
    /// - Returns:
    public static func roundedCorner(radius: CGFloat) -> Self {
        self.init(update: GenericShape.roundedCorner(radius: radius))
    }

}


extension MainActorShapeDisplaying {

    /// Returns an instance that displays capsule shape
    ///
    /// - Parameters:
    ///   - direction:
    ///   - usesSmoothCurve: SmoothCurve means Apple's using corner rouding. For example, Home App Icon's curve.
    /// - Returns: An instance
    ///
    public static func capsule(direction: CapsuleShapeDirection, usesSmoothCurve: Bool) -> Self {
        self.init(update: GenericShape.capsule(direction: direction, usesSmoothCurve: usesSmoothCurve))
    }

    /// Returns an instance that displays rounded corner shape.
    /// Rounded corner uses smooth-curve
    ///
    /// - Parameter radius:
    /// - Returns:
    public static func roundedCorner(radius: CGFloat) -> Self {
        self.init(update: GenericShape.roundedCorner(radius: radius))
    }

}
