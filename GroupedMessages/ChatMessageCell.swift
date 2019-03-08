//
//  ChatMessageCell.swift
//  GroupedMessages
//
//  Created by Shantanu Dutta on 07/03/19.
//  Copyright © 2019 Shantanu Dutta. All rights reserved.
//

import UIKit

class ChatMessageCell: UITableViewCell {
    
    let impact = UIImpactFeedbackGenerator()
    
    var chatMessage: ChatMessage! {
        didSet {
            bubbleBackgroundView.backgroundColor = chatMessage.isIncoming ? .white : .darkGray
            messageLabel.textColor = chatMessage.isIncoming ? .black : .white
            messageLabel.text = chatMessage.text
            
            if chatMessage.isIncoming {
                leadingContraint.isActive = true
                trailingContraint.isActive = false
            }else{
                trailingContraint.isActive = true
                leadingContraint.isActive = false
            }
        }
    }
    
    let bubbleBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 5
        return view
    }()

    let messageLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var leadingContraint: NSLayoutConstraint!
    var trailingContraint: NSLayoutConstraint!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = UIColor.clear
        isUserInteractionEnabled = false
        addSubview(bubbleBackgroundView)
        addSubview(messageLabel)
        configureConstraints()
    }
    
    func configureConstraints() {
        let contraints = [
            messageLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            messageLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -32),
            messageLabel.widthAnchor.constraint(lessThanOrEqualToConstant: 250),
            
            bubbleBackgroundView.topAnchor.constraint(equalTo: messageLabel.topAnchor, constant: -16),
            bubbleBackgroundView.leadingAnchor.constraint(equalTo: messageLabel.leadingAnchor, constant: -16),
            bubbleBackgroundView.trailingAnchor.constraint(equalTo: messageLabel.trailingAnchor, constant: 16),
            bubbleBackgroundView.bottomAnchor.constraint(equalTo: messageLabel.bottomAnchor, constant: 16)
        ]
        NSLayoutConstraint.activate(contraints)
        
        leadingContraint = nil
        trailingContraint = nil
        leadingContraint = messageLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 32)
        leadingContraint.isActive = true
        trailingContraint = messageLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -32)
        trailingContraint.isActive = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
