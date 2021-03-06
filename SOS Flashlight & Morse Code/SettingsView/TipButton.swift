//
//  TipButton.swift
//  SOS Flashlight & Morse Code
//
//  Created by Mark Wong on 3/6/20.
//  Copyright © 2020 Mark Wong. All rights reserved.
//

import UIKit

class TipButton: UIButton {
	
	override init(frame: CGRect) {
		super.init(frame: .zero)
		setupButton()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	func setupButton() {
		self.layer.backgroundColor = Theme.Dark.secondary.cgColor
		self.layer.cornerRadius = 8.0
		self.contentEdgeInsets = UIEdgeInsets(top: 15.0, left: 15.0, bottom: 15.0, right: 15.0)
	}

	func clearButtonTitle() {
		DispatchQueue.main.async {
			UIView.animate(withDuration: 0.2,
			animations: {
				self.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
			},
			completion: { _ in
				UIView.animate(withDuration: 0.2) {
					self.transform = CGAffineTransform.identity
				}
			})
		}
	}
	
	override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
		ImpactFeedbackService.shared.impactType(feedBackStyle: .medium)
		UIView.animate(withDuration: 0.1) {
			self.layer.backgroundColor = Theme.Dark.tertiary.cgColor
		}
		super.touchesBegan(touches, with: event)
	}

	override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
		UIView.animate(withDuration: 0.2) {
			self.layer.backgroundColor = Theme.Dark.secondary.cgColor
		}
		super.touchesEnded(touches, with: event)
	}
}
