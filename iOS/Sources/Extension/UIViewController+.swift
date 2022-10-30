import UIKit
import AVFoundation

extension UIViewController {

    func hideKeyboardWhenTappedAround() {
        let tapGesture = UITapGestureRecognizer(
            target: self,
            action: #selector(hideKeyboard)
        )
        view.addGestureRecognizer(tapGesture)
    }

    @objc func hideKeyboard() {
        view.endEditing(true)
    }

    func showToast(message: String, font: UIFont) {

        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)

        let toastLabel = UILabel(
            frame: CGRect(
                x: self.view.frame.size.width/2 - 150,
                y: self.view.frame.size.height-100,
                width: 300,
                height: 35))

        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        toastLabel.textColor = UIColor.white
        toastLabel.font = font
        toastLabel.textAlignment = .center
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 15
        toastLabel.clipsToBounds = true

        self.view.addSubview(toastLabel)

        UIView.animate(
            withDuration: 3.0,
            delay: 0.2,
            options: .curveEaseOut,
            animations: { toastLabel.alpha = 0.0 },
            completion: { _ in toastLabel.removeFromSuperview() }) }

    /// 취소와 확인이 뜨는 UIAlertController
    func makeRequestAlert(title: String,
                          message: String,
                          okAction: ((UIAlertAction) -> Void)?,
                          cancelAction: ((UIAlertAction) -> Void)? = nil,
                          completion: (() -> Void)? = nil) {

        let generator = UIImpactFeedbackGenerator(style: .medium)
        generator.impactOccurred()

        let alertViewController = UIAlertController(title: title, message: message,
                                                    preferredStyle: .alert)

        let okAction = UIAlertAction(title: "확인", style: .default, handler: okAction)
        alertViewController.addAction(okAction)
        let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: cancelAction)
        alertViewController.addAction(cancelAction)

        self.present(alertViewController, animated: true, completion: completion)
    }

    /// 확인 버튼만 뜨는 UIAlertController
    func makeOKAlert(title: String?,
                     message: String,
                     okAction: ((UIAlertAction) -> Void)? = nil,
                     completion: (() -> Void)? = nil) {

        let alertViewController = UIAlertController(title: title ?? nil,
                                                    message: message,
                                                    preferredStyle: .alert)

        let okAction = UIAlertAction(title: "확인", style: .default, handler: okAction)
        alertViewController.addAction(okAction)

        self.present(alertViewController, animated: true, completion: completion)
    }

}
