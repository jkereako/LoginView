//
//  BubblePresentationAnimator.swift
//
//  Created by Andrea Mazzini on 04/04/15.
//  Copyright (c) 2015 Fancy Pixel. All rights reserved.
//
//  The MIT License (MIT)
//
//  Copyright (c) 2015 Andrea Mazzini
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.

import UIKit

class BubblePresentationAnimator: NSObject {
  let backgroundColor: UIColor

  init(backgroundColor: UIColor = UIColor.clearColor()) {
    self.backgroundColor = backgroundColor
  }

}

extension BubblePresentationAnimator: UIViewControllerAnimatedTransitioning {
  private func frameForBubble(originalCenter: CGPoint, size originalSize: CGSize, start: CGPoint) -> CGRect {
    let lengthX = fmax(start.x, originalSize.width - start.x);
    let lengthY = fmax(start.y, originalSize.height - start.y)
    let offset = sqrt(lengthX * lengthX + lengthY * lengthY) * 2;
    let size = CGSize(width: offset, height: offset)

    return CGRect(origin: CGPointZero, size: size)
  }

  func transitionDuration(transitionContext: UIViewControllerContextTransitioning?)
    -> NSTimeInterval {

      return 0.5
  }

  func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
    guard let containerView = transitionContext.containerView() else {
      return
    }

    let to = transitionContext.viewForKey(UITransitionContextToViewKey)
    let originalCenter = to?.center ?? CGPointZero
    let originalSize = to?.frame.size ?? CGSizeZero

    let bubble = UIView()
    bubble.frame = frameForBubble(originalCenter, size: originalSize, start: CGPointZero)
    bubble.layer.cornerRadius = bubble.frame.size.height / 2
    bubble.center = containerView.center
    bubble.transform = CGAffineTransformMakeScale(0.001, 0.001)
    bubble.backgroundColor = backgroundColor
    containerView.addSubview(bubble)

    to?.center = containerView.center
    to?.transform = CGAffineTransformMakeScale(0.001, 0.001)
    to?.alpha = 0
    containerView.addSubview(to ?? UIView())

    UIView.animateWithDuration(
      0.5, animations: {
        bubble.transform = CGAffineTransformIdentity
        to?.transform = CGAffineTransformIdentity
        to?.alpha = 1
        to?.center = originalCenter
      },
      completion: { (done: Bool) in
        transitionContext.completeTransition(true)
      }
    )
  }
}