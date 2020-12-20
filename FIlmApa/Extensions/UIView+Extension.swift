//
//  UIView+Extension.swift
//  FIlmApa
//
//  Created by TMLI IT DEV on 18/12/20.
//

import UIKit
public extension UIView {
    private struct UniqueIdProperies {
        static var id: String?
    }
    
    @IBInspectable
    var id: String? {
        get {
            return objc_getAssociatedObject(self, &UniqueIdProperies.id) as? String
        } set {
            if let unwrappedValue = newValue {
                objc_setAssociatedObject(self, &UniqueIdProperies.id, unwrappedValue as NSString?, .OBJC_ASSOCIATION_COPY_NONATOMIC)
            }
        }
    }
    
    @IBInspectable
    var cornerRadius: CGFloat {
        get {
            return self.layer.cornerRadius
        } set {
            self.layer.cornerRadius = newValue
        }
    }
    
    @IBInspectable
    var halfCornerRadius: Bool {
        get {
            return false
        } set {
            if newValue {
                self.layer.cornerRadius = self.frame.size.height / 2
            } else {
                self.layer.cornerRadius = 0.0
            }
        }
    }
    
    @IBInspectable
    var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        } set {
            self.layer.borderWidth = newValue
        }
    }
    
    @IBInspectable
    var borderColor: UIColor? {
        get {
            if let color = layer.borderColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            if let color = newValue {
                layer.borderColor = color.cgColor
            } else {
                layer.borderColor = nil
            }
        }
    }
    
    @IBInspectable
    var shadowRadius: CGFloat {
        get {
            return layer.shadowRadius
        }
        set {
            layer.shadowRadius = newValue
        }
    }
    
    @IBInspectable
    var shadowOpacity: Float {
        get {
            return layer.shadowOpacity
        }
        set {
            layer.shadowOpacity = newValue
        }
    }
    
    @IBInspectable
    var shadowOffset: CGSize {
        get {
            return layer.shadowOffset
        }
        set {
            layer.shadowOffset = newValue
        }
    }
    
    @IBInspectable
    var shadowColor: UIColor? {
        get {
            if let color = layer.shadowColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            if let color = newValue {
                layer.shadowColor = color.cgColor
            } else {
                layer.shadowColor = nil
            }
        }
    }
    
    func shake(_ shakeDistance: CGFloat = 5) {
        self.transform = CGAffineTransform(translationX: shakeDistance, y: 0)
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.4, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
            self.transform = .identity
        })
    }
    
    func bounceView(_ bounceScale: CGFloat = 0.9) {
        self.transform = CGAffineTransform(scaleX: bounceScale, y: bounceScale)
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.4, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
            self.transform = .identity
        })
    }
    
    func bounce(_ scale: CGFloat = 0.9) {
        UIView.animate(withDuration: 0.1, animations: {
            self.transform = CGAffineTransform(scaleX: scale, y: scale)
        }) { _ in
            UIView.animate(withDuration: 0.1) {
                self.transform = CGAffineTransform.identity
            }
        }
    }
    
    func loadNib() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nibName = type(of: self).description().components(separatedBy: ".").last!
        let nib = UINib(nibName: nibName, bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first as! UIView
    }
    
    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
    
    func fillSuperview(padding: UIEdgeInsets) {
        self.anchor(top: superview?.topAnchor, leading: superview?.leadingAnchor, bottom: superview?.bottomAnchor, trailing: superview?.trailingAnchor, padding: padding)
    }
    
    func fillSuperview() {
        self.fillSuperview(padding: .zero)
    }
    
    func anchorSize(to view: UIView) {
        widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
    }
    
    func anchor(top: NSLayoutYAxisAnchor?, leading: NSLayoutXAxisAnchor?, bottom: NSLayoutYAxisAnchor?, trailing: NSLayoutXAxisAnchor?, padding: UIEdgeInsets = .zero, size: CGSize = .zero) {
        translatesAutoresizingMaskIntoConstraints = false
        
        if let top = top {
            topAnchor.constraint(equalTo: top, constant: padding.top).isActive = true
        }
        
        if let leading = leading {
            leadingAnchor.constraint(equalTo: leading, constant: padding.left).isActive = true
        }
        
        if let bottom = bottom {
            bottomAnchor.constraint(equalTo: bottom, constant: -padding.bottom).isActive = true
        }
        
        if let trailing = trailing {
            trailingAnchor.constraint(equalTo: trailing, constant: -padding.right).isActive = true
        }
        
        if size.width != 0 {
            widthAnchor.constraint(equalToConstant: size.width).isActive = true
        }
        
        if size.height != 0 {
            heightAnchor.constraint(equalToConstant: size.height).isActive = true
        }
    }
    
    func dropShadow(_ shadowColor: CGColor = UIColor.gray.cgColor) {
        self.layer.backgroundColor = UIColor.clear.cgColor
        self.layer.shadowColor = shadowColor
        self.layer.shadowOffset = CGSize(width: 0, height: 4.0)
        self.layer.shadowRadius = 5.0
        self.layer.shadowOpacity = 0.2
        self.layer.masksToBounds = false
    }
    
    enum GlowEffect: Float {
        case small = 0.4, normal = 2, big = 15
    }
    
    func doGlowAnimation(withColor color: UIColor, withEffect effect: GlowEffect = .normal) {
        layer.masksToBounds = false
        layer.shadowColor = color.cgColor
        layer.shadowRadius = 0
        layer.shadowOpacity = 1
        layer.shadowOffset = .zero
        
        let glowAnimation = CABasicAnimation(keyPath: "shadowRadius")
        glowAnimation.fromValue = 0
        glowAnimation.toValue = effect.rawValue
        glowAnimation.beginTime = CACurrentMediaTime() + 0.3
        glowAnimation.duration = CFTimeInterval(0.3)
        glowAnimation.fillMode = CAMediaTimingFillMode.removed
        glowAnimation.autoreverses = true
        glowAnimation.isRemovedOnCompletion = false
        layer.add(glowAnimation, forKey: "shadowGlowingAnimation")
    }
    
    /**
     Rotate a view by specified degrees
     
     - parameter angle: angle in degrees
     */
    func rotate(angle: CGFloat) {
        let radians = angle / 180.0 * CGFloat.pi
        let rotation = self.transform.rotated(by: radians)
        self.transform = rotation
    }
}

