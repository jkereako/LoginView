//
//  ShakeAnimation.swift
//  LoginView
//
//  Created by Jeff Kereakoglow on 2/11/16.
//  Copyright © 2016 Alexis Digital. All rights reserved.
//

import UIKit

struct TextFieldShakeAnimator {
  let speed: NSTimeInterval
  let amplitude: Int
  let count: Int
  let textField: UITextField

  init(speed: NSTimeInterval, amplitude: Int, count: Int, textField: UITextField) {
    self.speed = speed
    self.amplitude = amplitude
    self.count = count
    self.textField = textField
  }

  func shake() {
    _shake(speed: speed, amplitude: amplitude, times: count, direction: 1, shakeCount: 0)
  }

  private func _shake(speed speed: NSTimeInterval, amplitude: Int, times: Int, direction: Int, shakeCount: Int) {
    UIView.animateWithDuration(speed,
      animations: {
        self.textField.transform = CGAffineTransformMakeTranslation(CGFloat(amplitude * direction), 0)
      },

      completion: {(done: Bool) in
        if shakeCount >= times {
          UIView.animateWithDuration(speed, animations: {
            // Reset the field back to its original position
            self.textField.transform = CGAffineTransformIdentity
            }
          )

          return
        }

        // Recursive call
        self._shake(
          speed: speed, amplitude: amplitude, times: times - 1, direction: direction * -1, shakeCount: shakeCount + 1
        )
      }
    )
  }
}
