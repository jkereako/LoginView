//
//  ShakeAnimator.swift
//  LoginView
//
//  Created by Jeff Kereakoglow on 2/11/16.
//  Copyright © 2016 Xmartlabs. All rights reserved.
//
//  Licensed under the MIT license:
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy of this software
//  and associated documentation files (the "Software"), to deal in the Software without
//  restriction, including without limitation the rights to use, copy, modify, merge, publish,
//  distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the
//  Software is furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all copies or
//  substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING
//  BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
//  NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM,
//  DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
import UIKit

struct ShakeAnimator {
    let duration: TimeInterval
    let amplitude: Int
    let view: UIView
    
    init(view: UIView, duration: TimeInterval = 0.4, amplitude: Int = 10) {
      self.duration = duration
      self.amplitude = amplitude
      self.view = view
    }

  /// Shakes a view 3 times from left to right.
    func shake() {
        let animation = CAKeyframeAnimation()
        // "If the calculationMode is set to kCAAnimationLinear, the first value in the array must be
        // 0.0 and the last value must be 1.0. Values are interpolated between the specified keytimes."
        animation.calculationMode = CAAnimationCalculationMode.linear
        animation.keyPath = "position.x"
        animation.values =  [0, amplitude, -amplitude, amplitude / 2, 0]
        animation.keyTimes = [
            NSNumber(integerLiteral: 0),
            NSNumber(floatLiteral:(1 / 6.0)),
            NSNumber(floatLiteral:(3 / 6.0)),
            NSNumber(floatLiteral:(5 / 6.0)),
            NSNumber(integerLiteral: 1)
        ]
        animation.duration = duration
        animation.isAdditive = true
        
        view.layer.add(animation, forKey:"shake")
    }
}
