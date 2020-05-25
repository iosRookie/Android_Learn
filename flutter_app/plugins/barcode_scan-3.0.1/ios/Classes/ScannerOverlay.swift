//
//  ScannerOverlay.swift
//  barcode_scan
//
//  Created by Julian Finkler on 20.02.20.
//

import UIKit

class ScannerOverlay: UIView {
    
    let LINE_WIDTH: CGFloat = 4.0
    
    private let line: UIView = UIView()
    
    private var scanLineRect: CGRect {
        let scanRect = calculateScanRect()
        let positionY = scanRect.origin.y + LINE_WIDTH/2.0// + (scanRect.size.height / 2)
        
        return CGRect(x: scanRect.origin.x,
                      y: positionY,
                      width: scanRect.size.width,
                      height: 4
        )
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        line.frame = scanLineRect
        line.backgroundColor = .clear
        line.translatesAutoresizingMaskIntoConstraints = false
        setLineColor(UIColor.init(red: 80/255.0, green: 153/255.0, blue: 204/255.0, alpha: 1))
        addSubview(line)
        
        let scanRect = calculateScanRect()
        let alert = UILabel.init()
        alert.frame = CGRect.init(x: 0, y: scanRect.origin.y + scanRect.size.height + 40, width: self.bounds.size.width, height: 14)
        alert.font = UIFont.systemFont(ofSize: 14)
        alert.textColor = .white
        alert.text = "将二维码放入框内，即可自动扫描"
        alert.textAlignment = .center
        addSubview(alert)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func draw(_ rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()
        
        let overlayColor = UIColor(red: 0.0,
                                   green: 0.0,
                                   blue: 0.0,
                                   alpha: 0.55
        )
        
        context?.setFillColor(overlayColor.cgColor)
        context?.fill(bounds)
        
        // make a hole for the scanner
        let holeRect = calculateScanRect()
        let holeRectIntersection = holeRect.intersection(rect)
        UIColor.clear.setFill()
        UIRectFill(holeRectIntersection)
        
        // draw the green corners
        let cornerSize: CGFloat = 30
        let path = UIBezierPath()
        
        //top left corner
        path.move(to: CGPoint(x: holeRect.origin.x + LINE_WIDTH/2.0, y: holeRect.origin.y + cornerSize))
        path.addLine(to: CGPoint(x: holeRect.origin.x + LINE_WIDTH/2.0, y: holeRect.origin.y + LINE_WIDTH/2.0))
        path.addLine(to: CGPoint(x: holeRect.origin.x + cornerSize, y: holeRect.origin.y + LINE_WIDTH/2.0))
        
        //top right corner
        let rightHoleX = holeRect.origin.x + holeRect.size.width
        path.move(to: CGPoint(x: rightHoleX - cornerSize, y: holeRect.origin.y + LINE_WIDTH/2.0))
        path.addLine(to: CGPoint(x: rightHoleX - LINE_WIDTH/2.0, y: holeRect.origin.y + LINE_WIDTH/2.0))
        path.addLine(to: CGPoint(x: rightHoleX - LINE_WIDTH/2.0, y: holeRect.origin.y + cornerSize))
        
        // bottom right corner
        let bottomHoleY = holeRect.origin.y + holeRect.size.height
        path.move(to: CGPoint(x: rightHoleX - LINE_WIDTH/2.0, y: bottomHoleY - cornerSize - LINE_WIDTH/2.0))
        path.addLine(to: CGPoint(x: rightHoleX - LINE_WIDTH/2.0, y: bottomHoleY - LINE_WIDTH/2.0))
        path.addLine(to: CGPoint(x: rightHoleX - cornerSize - LINE_WIDTH/2.0, y: bottomHoleY - LINE_WIDTH/2.0))
        
        // bottom left corner
        path.move(to: CGPoint(x: holeRect.origin.x + cornerSize + LINE_WIDTH/2.0, y: bottomHoleY - LINE_WIDTH/2.0))
        path.addLine(to: CGPoint(x: holeRect.origin.x + LINE_WIDTH/2.0, y: bottomHoleY - LINE_WIDTH/2.0))
        path.addLine(to: CGPoint(x: holeRect.origin.x + LINE_WIDTH/2.0, y: bottomHoleY - cornerSize - LINE_WIDTH/2.0))
        
        path.lineWidth = LINE_WIDTH
        UIColor.init(red: 80.0/255.0, green: 153.0/255.0, blue: 204.0/255.0, alpha: 1).setStroke()
        path.stroke()
    }
    
    public func startAnimating() {
        layer.removeAnimation(forKey: "move_Y")
        let scanRect = calculateScanRect()
        let startY: Float = Float(LINE_WIDTH/2.0 + 5)
        let endY: Float = Float(scanRect.size.height - LINE_WIDTH/2.0 - 5)
        let flash = CABasicAnimation(keyPath: "transform.translation.y")
        flash.fromValue = NSNumber(value: startY)
        flash.toValue = NSNumber(value: endY)
        flash.duration = 1.5
        flash.autoreverses = true
        flash.repeatCount = HUGE
        line.layer.add(flash, forKey: "move_Y")
    }
    
    public func stopAnimating() {
        layer.removeAnimation(forKey: "move_Y")
    }
    
    private func calculateScanRect() -> CGRect {
        let rect = frame
        
        let frameWidth = rect.size.width
        var frameHeight = rect.size.height
        
        let isLandscape = frameWidth > frameHeight
        let widthOnPortrait = isLandscape ? frameHeight : frameWidth
        let scanRectWidth = widthOnPortrait * 0.6
        let aspectRatio: CGFloat = 4.0 / 4.0
        let scanRectHeight = scanRectWidth * aspectRatio
        
        if isLandscape {
            let navbarHeight: CGFloat = 32
            frameHeight += navbarHeight
        }
        
        let scanRectOriginX = (frameWidth - scanRectWidth) / 2
        let scanRectOriginY = (frameHeight - scanRectHeight) / 2
        return CGRect(x: scanRectOriginX,
                      y: scanRectOriginY - 40,
                      width: scanRectWidth,
                      height: scanRectHeight
        )
    }
    
    private func setLineColor(_ color: UIColor) {
        let lineLayer: CAGradientLayer = CAGradientLayer()
        lineLayer.frame = CGRect.init(x: 0, y: 0, width: self.line.bounds.size.width, height: self.line.bounds.size.height)
        lineLayer.startPoint = CGPoint.init(x: 0, y: 0.5)
        lineLayer.endPoint = CGPoint.init(x: 1, y: 0.5)
        lineLayer.locations = [0.1, 0.5, 0.9]
        let colors = [UIColor.init(red: 80.0/255.0, green: 153.0/255.0, blue: 204.0/255.0, alpha: 0).cgColor,
                      UIColor.init(red: 80.0/255.0, green: 153.0/255.0, blue: 204.0/255.0, alpha: 1).cgColor,
                        UIColor.init(red: 80.0/255.0, green: 153.0/255.0, blue: 204.0/255.0, alpha: 0).cgColor]
        lineLayer.colors = colors
        self.line.layer.addSublayer(lineLayer)
    }
}
