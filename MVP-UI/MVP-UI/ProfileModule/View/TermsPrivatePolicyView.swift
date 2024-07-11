// TermsPrivatePolicyView.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Экран условий и политики конфиденциальности
final class TermsPrivatePolicyView: UIView {
    // MARK: - Constants

    enum Constants {
        static var fontVerdana = "Verdana"
        static var fontVerdanaBold = "Verdana-Bold"
        static var titleTermsOfUse = "Terms of Use"
        static var titlePrivatePolicy = "Welcome to our recipe app! We're thrilled to\n" +
            "have you on board. To ensure a delightful\n" +
            "experience for everyone, please take a moment to\n" +
            "familiarize yourself with our rules:\n" +
            "User Accounts:\n" +
            "Maintain one account per user.\n" +
            "Safeguard your login credentials; don't share them with others.\n" +
            "Content Usage:\n" +
            "Recipes and content are for personal use only.\n" +
            "Do not redistribute or republish recipes without proper attribution.\n" +
            "Respect Copyright:\n" +
            "Honor the copyright of recipe authors and contributors.\n" +
            "Credit the original source when adapting or modifying a recipe.\n" +
            "Community Guidelines:\n" +
            "Show respect in community features.\n" +
            "Avoid offensive language or content that violates community standards.\n" +
            "Feedback and Reviews:\n" +
            "Share constructive feedback and reviews.\n" +
            "Do not submit false or misleading information.\n" +
            "Data Privacy:\n" +
            "Review and understand our privacy policy regarding data collection and usage.\n" +
            "Compliance with Laws:\n" +
            "Use the app in compliance with all applicable laws and regulations.\n" +
            "Updates to Terms:\n" +
            "Stay informed about updates; we'll notify you of any changes.\n" +
            "By using our recipe app, you agree to adhere to these rules." +
            "Thank you for being a part of our culinary community! Enjoy exploring and cooking up a storm!"
    }

    /// Состояния View
    enum StateView {
        /// Открыта
        case openView
        /// Закрыта
        case closeView
    }

    // MARK: - Visual Components

    private let panelHandleView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let dragHandleImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .penHandle
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private let termsOfUseLabel: UILabel = {
        let label = UILabel()
        label.text = Constants.titleTermsOfUse
        label.font = UIFont(name: Constants.fontVerdanaBold, size: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let descriptionPrivatePolicyLabel: UILabel = {
        let label = UILabel()
        label.text = Constants.titlePrivatePolicy
        label.font = UIFont(name: Constants.fontVerdana, size: 14)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var closeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(.closeButton, for: .normal)
        button.tintColor = .black
        button.addTarget(self, action: #selector(closeViewController), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    // MARK: - Public Properties

    var handler: VoidHandler?

    // MARK: - Private Properties

    private var flagVisibility = false
    private var nextState: StateView { flagVisibility ? .closeView : .openView }
    private var animationProgressWhenInterrupted: CGFloat = 0
    private var runningAnimations: [UIViewPropertyAnimator] = .init()

    private let height: CGFloat = 650
    private let areaHeight: CGFloat = 0

    // MARK: - Initializers

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview()
        setupConstraints()
        setupView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        addSubview()
        setupConstraints()
        setupView()
    }

    // MARK: - Private Methods

    private func setupView() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(viewTap(gestureRecognizer:)))
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(viewPan(gestureRecognizer:)))
        panelHandleView.addGestureRecognizer(tapGestureRecognizer)
        panelHandleView.addGestureRecognizer(panGestureRecognizer)
    }

    private func animateTransitionIfNeeded(state: StateView, duration: TimeInterval) {
        if runningAnimations.isEmpty {
            let animator = UIViewPropertyAnimator(duration: duration, dampingRatio: 1) {
                switch state {
                case .openView:
                    self.frame.origin.y = self.frame.height - self.height
                case .closeView:
                    self.handler?()
                    self.frame.origin.y = self.frame.height - self.areaHeight
                }
            }
            animator.addCompletion { _ in
                self.flagVisibility = !self.flagVisibility
                self.runningAnimations.removeAll()
            }
            animator.startAnimation()
            runningAnimations.append(animator)
        }
    }

    private func startInteractiveTransition(state: StateView, duration: TimeInterval) {
        if runningAnimations.isEmpty {
            animateTransitionIfNeeded(state: state, duration: duration)
        }
        for animator in runningAnimations {
            animator.pauseAnimation()
            animationProgressWhenInterrupted = animator.fractionComplete
        }
    }

    private func updateInteractiveTransition(fractionCompleted: CGFloat) {
        for animator in runningAnimations {
            animator.fractionComplete = fractionCompleted + animationProgressWhenInterrupted
        }
    }

    private func continueInteractiveTransition() {
        for animator in runningAnimations {
            animator.continueAnimation(withTimingParameters: nil, durationFactor: 0)
        }
    }

    private func addSubview() {
        backgroundColor = .white
        layer.cornerRadius = 20
        addSubview(panelHandleView)
        addSubview(dragHandleImageView)
        addSubview(termsOfUseLabel)
        addSubview(descriptionPrivatePolicyLabel)
        addSubview(closeButton)
    }

    private func setupConstraints() {
        panelHandleViewConstraints()
        dragHandleImageViewConstraints()
        termsOfUseLabelConstraints()
        descriptionPrivatePolicyLabelConstraints()
        closeButtonConstraints()
    }

    private func panelHandleViewConstraints() {
        panelHandleView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        panelHandleView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        panelHandleView.widthAnchor.constraint(equalToConstant: bounds.width).isActive = true
        panelHandleView.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }

    private func dragHandleImageViewConstraints() {
        dragHandleImageView.topAnchor.constraint(equalTo: topAnchor, constant: 15).isActive = true
        dragHandleImageView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
    }

    private func termsOfUseLabelConstraints() {
        termsOfUseLabel.topAnchor.constraint(equalTo: topAnchor, constant: 55).isActive = true
        termsOfUseLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 25).isActive = true
    }

    private func descriptionPrivatePolicyLabelConstraints() {
        descriptionPrivatePolicyLabel.topAnchor.constraint(equalTo: termsOfUseLabel.bottomAnchor, constant: 15)
            .isActive = true
        descriptionPrivatePolicyLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 25)
            .isActive = true
        descriptionPrivatePolicyLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -25)
            .isActive = true
    }

    private func closeButtonConstraints() {
        closeButton.topAnchor.constraint(equalTo: topAnchor, constant: 25).isActive = true
        closeButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20).isActive = true
    }

    @objc private func viewTap(gestureRecognizer: UITapGestureRecognizer) {
        switch gestureRecognizer.state {
        case .ended:
            animateTransitionIfNeeded(state: nextState, duration: 0.9)
        default:
            break
        }
    }

    @objc private func viewPan(gestureRecognizer: UIPanGestureRecognizer) {
        switch gestureRecognizer.state {
        case .began:
            startInteractiveTransition(state: nextState, duration: 0.9)
        case .changed:
            let translation = gestureRecognizer.translation(in: panelHandleView)
            var fractionComplete = translation.y / height
            fractionComplete = flagVisibility ? fractionComplete : -fractionComplete
            updateInteractiveTransition(fractionCompleted: fractionComplete)
        case .ended:
            continueInteractiveTransition()
        default: break
        }
    }

    @objc private func closeViewController() {
        handler?()
        animateTransitionIfNeeded(state: nextState, duration: 0.9)
    }
}
