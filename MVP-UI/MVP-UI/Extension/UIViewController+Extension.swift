// UIViewController+Extension.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

extension UIViewController {
    /// Расширение для скрытие клавиатуры по тапу
    func addTapGestureToHideKeyboard() {
        let tapGesture = UITapGestureRecognizer(target: view, action: #selector(view.endEditing))
        view.addGestureRecognizer(tapGesture)
    }

    /// Расширение для вызова алерта
    func callAlert(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Cancel", style: .cancel)
        alert.addAction(action)
        present(alert, animated: true)
    }
}
