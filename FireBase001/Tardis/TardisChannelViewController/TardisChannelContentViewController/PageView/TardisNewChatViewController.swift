//
//  TardisNewChatViewController.swift
//  FireBase001
//
//  Created by Hoang on 7/5/20.
//  Copyright © 2020 Hoang. All rights reserved.
//

import UIKit
import MessageKit
import MessageUI
import Messages
import InputBarAccessoryView
import Photos

class TardisNewChatViewController: MessagesViewController {
    
    @IBOutlet weak var inputTextField: UITextField!
    @IBOutlet weak var inputBlockView: UIView!
    var currentChannel = TardisChannelObject()
    let dataModel = TardisChannelDataModel()
    var messages: [TardisMessageObject] = []
    var user2Name: String?
    var user2ImgUrl: String?
    var user2UID: String?
    var page: TardisChannelPage!
    var firstLoad = true
    override func viewDidLoad() {
        super.viewDidLoad()
        setupMessage()
        self.view.bringSubviewToFront(inputBlockView)
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.view.endEditing(true)
        if firstLoad {
            dataModel.observeChat(onChannel: currentChannel) { (status, listMessage) in
                if status {
                    self.messages = listMessage
                    self.messagesCollectionView.reloadData()
                    self.messagesCollectionView.scrollToBottom()
                }
            }
            firstLoad = false
        }
    }
    deinit {
        
    }
    
    func setupMessage() {
        maintainPositionOnKeyboardFrameChanged = true
        messageInputBar.inputTextView.tintColor = mainColor
        messageInputBar.sendButton.setTitleColor(mainColor, for: .normal)
        
        messageInputBar.delegate = self
        messagesCollectionView.messagesDataSource = self
        messagesCollectionView.messagesLayoutDelegate = self
        messagesCollectionView.messagesDisplayDelegate = self
        
        let cameraItem = InputBarButtonItem(type: .system) // 1
        cameraItem.tintColor = mainColor
        cameraItem.addTarget(
            self,
            action: #selector(cameraButtonPressed), // 2
            for: .primaryActionTriggered
        )
        cameraItem.setSize(CGSize(width: 60, height: 30), animated: false)
        cameraItem.image = UIImage(systemName: "photo")
        messageInputBar.leftStackView.alignment = .center
        messageInputBar.setLeftStackViewWidthConstant(to: 50, animated: false)
        messageInputBar.setStackViewItems([cameraItem], forStack: .left, animated: false) // 3
    }
    @objc func cameraButtonPressed() {
        
    }
    func addMessage(_ message:TardisMessageObject) {
        dataModel.addNewMessage(message,
                                toChannel: currentChannel) { _ in
                                    // Do something
        }
    }
}
// MARK: - MessagesDisplayDelegate
extension TardisNewChatViewController: MessagesDisplayDelegate {
    
    func backgroundColor(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> UIColor {
        return isFromCurrentSender(message: message) ? .primary : .incomingMessage
    }
    
    func shouldDisplayHeader(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> Bool {
        return false
    }
    
    func messageStyle(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> MessageStyle {
        let corner: MessageStyle.TailCorner = isFromCurrentSender(message: message) ? .bottomRight : .bottomLeft
        return .bubbleTail(corner, .curved)
    }
    
}

// MARK: - MessagesLayoutDelegate

extension TardisNewChatViewController: MessagesLayoutDelegate {
    
    func avatarSize(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> CGSize {
        return .zero
    }
    
    func footerViewSize(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> CGSize {
        return CGSize(width: 0, height: 8)
    }
    
    func heightForLocation(message: MessageType, at indexPath: IndexPath, with maxWidth: CGFloat, in messagesCollectionView: MessagesCollectionView) -> CGFloat {
        
        return 0
    }
    
    func configureAvatarView(_ avatarView: AvatarView, for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) {
        TardisBaseRequestModel.shared.getUser(UID: message.sender.senderId) { (status, user) in
            if status {
                if user.imageUrl.count > 0 {
                    let url = URL(string: user.imageUrl)
                    CommonFunction.getData(from: url!, completion: { (data, res, err) in
                        if err != nil {
                            return
                        }
                        DispatchQueue.main.async {
                            avatarView.image = UIImage(data: data!)
                        }
                    })
                }
            }
        }
    }
    
}

// MARK: - MessagesDataSource

extension TardisNewChatViewController: MessagesDataSource {
    func currentSender() -> SenderType {
        return Sender(id: UserInfo.getUID(), displayName: UserInfo.currentUser.displayName)
    }
    func numberOfSections(in messagesCollectionView: MessagesCollectionView) -> Int {
        return 1
    }
    func numberOfItems(inSection section: Int, in messagesCollectionView: MessagesCollectionView) -> Int {
        return messages.count
    }
    func messageForItem(at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> MessageType {
        if messages.count == 0 {
            let message = TardisMessageObject()
            message.content = "HelloSenpai"
            message.senderID = UserInfo.getUID()
            return message
        }
        return messages[indexPath.row]
    }
    func cellTopLabelAttributedText(for message: MessageType, at indexPath: IndexPath) -> NSAttributedString? {
        let name = message.sender.displayName
        let paragraph = NSMutableParagraphStyle()
        if message.sender.senderId == UserInfo.getUID() {
            paragraph.alignment = .right
        } else {
            paragraph.alignment = .left
        }
        return NSAttributedString(
            string: name,
            attributes: [
                .font: UIFont.preferredFont(forTextStyle: .caption1),
                .foregroundColor: UIColor(white: 0.3, alpha: 1),
                .paragraphStyle: paragraph
            ]
        )
        
    }
    func cellTopLabelHeight(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> CGFloat {
        return 16
    }
    
}

// MARK: - MessageInputBarDelegate
extension TardisNewChatViewController: InputBarAccessoryViewDelegate {
    func inputBar(_ inputBar: InputBarAccessoryView, didPressSendButtonWith text: String) {
        let message = TardisMessageObject()
        message.senderID = UserInfo.getUID()
        message.content = text
        message.senderName = UserInfo.currentUser.displayName
        addMessage(message)
        inputBar.inputTextView.text = ""
    }
}

// MARK: - UIImagePickerControllerDelegate

extension TardisNewChatViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        
        if let asset = info[.phAsset] as? PHAsset { // 1
            let size = CGSize(width: 500, height: 500)
            PHImageManager.default().requestImage(for: asset, targetSize: size, contentMode: .aspectFit, options: nil) { result, info in
                guard let image = result else {
                    return
                }
            }
        } else if let image = info[.originalImage] as? UIImage { // 2
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
}

