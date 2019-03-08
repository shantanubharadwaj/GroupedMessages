//
//  ViewController.swift
//  GroupedMessages
//
//  Created by Shantanu Dutta on 07/03/19.
//  Copyright © 2019 Shantanu Dutta. All rights reserved.
//

import UIKit

struct ChatMessage {
    let text: String
    let isIncoming: Bool
    let date: Date
}

extension Date {
    static func dateFromCustomString(customString: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY, d MMM"
        return dateFormatter.date(from: customString) ?? Date()
    }
}

class ViewController: UITableViewController {

    private let cellID = "cellID"
    
//    let chatMessages = [
//        [
//            ChatMessage(text: "Here's my very first message", isIncoming: true, date: Date.dateFromCustomString(customString: "2019, 2 Jan")),
//            ChatMessage(text: "I am going to message another long message that will word wrap", isIncoming: true, date: Date.dateFromCustomString(customString: "2019, 2 Jan"))
//        ],
//        [
//            ChatMessage(text: "We want to provide a long string that is actually going to wrap onto the next line and maybe even a third line, I am going to message another long message that will word wrap, I am going to message another long message that will word wrap", isIncoming: false, date: Date.dateFromCustomString(customString: "2019, 4 Feb")),
//            ChatMessage(text:  "Yo, dawg. Whaddup ?", isIncoming: false, date: Date.dateFromCustomString(customString: "2019, 4 Feb")),
//            ChatMessage(text:  "This message should appear on the left with a white background buuble", isIncoming: true, date: Date.dateFromCustomString(customString: "2019, 4 Feb"))
//        ],
//        [
//            ChatMessage(text: "Here's my very first message", isIncoming: true, date: Date.dateFromCustomString(customString: "2019, 26 Feb")),
//            ChatMessage(text: "I am going to message another long message that will word wrap", isIncoming: true, date: Date.dateFromCustomString(customString: "2019, 26 Feb"))
//        ],
//        [
//            ChatMessage(text: "We want to provide a long string that is actually going to wrap onto the next line and maybe even a third line, I am going to message another long message that will word wrap, I am going to message another long message that will word wrap", isIncoming: false, date: Date.dateFromCustomString(customString: "2019, 3 Mar")),
//            ChatMessage(text:  "Yo, dawg. Whaddup ?", isIncoming: false, date: Date.dateFromCustomString(customString: "2019, 3 Mar")),
//            ChatMessage(text:  "This message should appear on the left with a white background buuble", isIncoming: true, date: Date.dateFromCustomString(customString: "2019, 3 Mar"))
//        ]
//    ]
    
    let messagesFromServer = [
        ChatMessage(text: "Here's my very first message", isIncoming: true, date: Date.dateFromCustomString(customString: "2019, 2 Jan")),
        ChatMessage(text: "I am going to message another long message that will word wrap", isIncoming: true, date: Date.dateFromCustomString(customString: "2019, 2 Jan")),
        ChatMessage(text: "We want to provide a long string that is actually going to wrap onto the next line and maybe even a third line, I am going to message another long message that will word wrap, I am going to message another long message that will word wrap", isIncoming: false, date: Date.dateFromCustomString(customString: "2019, 4 Feb")),
        ChatMessage(text:  "Yo, dawg. Whaddup ?", isIncoming: false, date: Date.dateFromCustomString(customString: "2019, 4 Feb")),
        ChatMessage(text:  "This message should appear on the left with a white background buuble", isIncoming: true, date: Date.dateFromCustomString(customString: "2019, 4 Feb")),
        ChatMessage(text: "Here's my very first message", isIncoming: true, date: Date.dateFromCustomString(customString: "2019, 26 Feb")),
        ChatMessage(text: "I am going to message another long message that will word wrap", isIncoming: true, date: Date.dateFromCustomString(customString: "2019, 26 Feb")),
        ChatMessage(text: "We want to provide a long string that is actually going to wrap onto the next line and maybe even a third line, I am going to message another long message that will word wrap, I am going to message another long message that will word wrap", isIncoming: false, date: Date.dateFromCustomString(customString: "2019, 3 Mar")),
        ChatMessage(text:  "Yo, dawg. Whaddup ?", isIncoming: false, date: Date.dateFromCustomString(customString: "2019, 3 Mar")),
        ChatMessage(text:  "This message should appear on the left with a white background buuble", isIncoming: true, date: Date.dateFromCustomString(customString: "2019, 3 Mar"))
        
    ]

    var chatMessages = [[ChatMessage]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavBar()
        
        attemptToAssembleGroupedMessage()

        tableView.register(ChatMessageCell.self, forCellReuseIdentifier: cellID)
        tableView.separatorStyle = .none
        tableView.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
    }

    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }

    func attemptToAssembleGroupedMessage() {
        let groupedMessages = Dictionary(grouping: messagesFromServer) { $0.date }
        let sortedKeys = groupedMessages.keys.sorted()
        sortedKeys.forEach { chatMessages.append(groupedMessages[$0] ?? []) }
    }
    
    func configureNavBar() {
        navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        navigationController?.navigationBar.barStyle = .blackTranslucent
        navigationItem.title = "Messages"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
    }
}

extension ViewController{
    class DateHeaderLabel: UILabel {
        override init(frame: CGRect) {
            super.init(frame: frame)
            backgroundColor = #colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1)
            textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            textAlignment = .center
            translatesAutoresizingMaskIntoConstraints = false
        }
        
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        override var intrinsicContentSize: CGSize {
            let originalContentSize = super.intrinsicContentSize
            let height = originalContentSize.height + 12
            layer.cornerRadius = height / 2
            layer.masksToBounds = true
            return CGSize(width: originalContentSize.width + 20, height: height)
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return chatMessages.count
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if let firstMessageinSection = chatMessages[section].first {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "YYYY, d MMM"
            let dateString = dateFormatter.string(from: firstMessageinSection.date)
            let label = DateHeaderLabel()
            label.text = dateString
            label.font = UIFont.boldSystemFont(ofSize: 14)
            
            let containerView = UIView()
            containerView.addSubview(label)
            label.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
            label.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
            
            return containerView
        }
        return nil
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
//    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        if let firstMessageinSection = chatMessages[section].first {
//            let dateFormatter = DateFormatter()
//            dateFormatter.dateFormat = "YYYY, d MMM"
//            let dateString = dateFormatter.string(from: firstMessageinSection.date)
//            return dateString
//        }
//
//        return "\(Date())"
//    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chatMessages[section].count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! ChatMessageCell
        cell.chatMessage = chatMessages[indexPath.section][indexPath.row]
        return cell
    }
    
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        tableView.deselectRow(at: indexPath, animated: false)
//    }
}
