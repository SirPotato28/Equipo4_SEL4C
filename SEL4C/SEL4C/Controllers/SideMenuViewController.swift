//
//  SideMenuViewController.swift
//  SEL4C
//
//  Created by Josue on 28/09/23.
//

import UIKit

class SideMenuViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .black

        let settingsLabel = UILabel()
        settingsLabel.text = "Settings"
        settingsLabel.font = .systemFont(ofSize: 24)
        settingsLabel.textColor = .white
        settingsLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(settingsLabel)

        let appleLinkButton = UIButton(type: .system)
        appleLinkButton.setTitle("Apple", for: .normal)
        appleLinkButton.titleLabel?.font = .systemFont(ofSize: 24)
        appleLinkButton.setTitleColor(.white, for: .normal)
        appleLinkButton.addTarget(self, action: #selector(openAppleLink), for: .touchUpInside)
        appleLinkButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(appleLinkButton)

        NSLayoutConstraint.activate([
            settingsLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 32),
            settingsLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),

            appleLinkButton.topAnchor.constraint(equalTo: settingsLabel.bottomAnchor, constant: 16),
            appleLinkButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16)
        ])
    }

    @objc private func openAppleLink() {
        if let url = URL(string: "https://apple.com") {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
}

