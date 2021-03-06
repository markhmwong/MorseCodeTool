//
//  MainCoordinator.swift
//  SOS Flashlight & Morse Code
//
//  Created by Mark Wong on 20/5/20.
//  Copyright © 2020 Mark Wong. All rights reserved.
//

import UIKit

class MainCoordinator: NSObject, Coordinator, UINavigationControllerDelegate {
	var childCoordinators: [Coordinator] = []
	
	var navigationController: UINavigationController
	
	var rootViewController: ViewController?
	
	init(navigationController: UINavigationController) {
		self.navigationController = navigationController
	}
	
	func start() {
		navigationController.delegate = self
		let vc = ViewController(coordinator: self)
		rootViewController = vc
		vc.viewModel = ViewControllerViewModel(viewController: vc)
		navigationController.pushViewController(vc, animated: false)
		
		// navigation buttons
		navigationController.navigationBar.isHidden = false
		navigationController.navigationBar.isTranslucent = true
		navigationController.navigationBar.setBackgroundImage(UIImage(), for: .default)
		navigationController.navigationBar.shadowImage = UIImage()
		navigationController.navigationBar.backgroundColor = UIColor.clear
		let options = UIBarButtonItem().settingsButton(target: self, action: #selector(showSettings))

		options.tintColor = Theme.Font.DefaultColor
		vc.navigationItem.rightBarButtonItem = options
	}
	
	func showSeizureWarning() {
		let vc = SeizureWarningViewController(coordinator: self)
		navigationController.present(vc, animated: true) {
			//
		}
	}
	
	func showError(error: TextFieldError) {
		let alert = UIAlertController(title: "You're a little quick..", message: "It's empty", preferredStyle: .alert)
		alert.addAction(UIAlertAction(title: "Okay!", style: UIAlertAction.Style.default, handler: nil))
		rootViewController?.present(alert, animated: true, completion: nil)
	}
	
	@objc func showSettings() {
		let coordinator = SettingsCoordinator(navigationController: navigationController)
		coordinator.start()
		childCoordinators.append(coordinator)
	}
	
	/// Show the share panel
	func showShare(textToShare: String = "") {
		let activityViewController = UIActivityViewController(activityItems: [textToShare], applicationActivities: nil)
		activityViewController.popoverPresentationController?.sourceView = navigationController.viewControllers.first?.view
		navigationController.present(activityViewController, animated: true) {
			//
		}
	}
	
	func dismiss() {
		navigationController.dismiss(animated: true, completion: nil)
	}
}
