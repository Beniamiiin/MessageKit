/*
 MIT License

 Copyright (c) 2017 MessageKit

 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:

 The above copyright notice and this permission notice shall be included in all
 copies or substantial portions of the Software.

 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 SOFTWARE.
 */

import UIKit

open class MediaMessageCell: MessageCollectionViewCell<UIImageView> {
    open override class func reuseIdentifier() -> String { return "messagekit.cell.mediamessage" }

    // MARK: - Properties

    open lazy var playButtonView: PlayButtonView = {
        let playButtonView = PlayButtonView()
        playButtonView.frame.size = CGSize(width: 35, height: 35)
        return playButtonView
    }()
    
    open lazy var activityIndicatorView: UIActivityIndicatorView = {
        let activityIndicatorView = UIActivityIndicatorView()
        activityIndicatorView.activityIndicatorViewStyle = .gray
        return activityIndicatorView
    }()

    // MARK: - Methods

    private func setupConstraints() {
        playButtonView.translatesAutoresizingMaskIntoConstraints = false

        let playButtonViewCenterX = playButtonView.centerXAnchor.constraint(equalTo: messageContainerView.centerXAnchor)
        let playButtonViewCenterY = playButtonView.centerYAnchor.constraint(equalTo: messageContainerView.centerYAnchor)
        let playButtonViewWidth = playButtonView.widthAnchor.constraint(equalToConstant: playButtonView.bounds.width)
        let playButtonViewHeight = playButtonView.heightAnchor.constraint(equalToConstant: playButtonView.bounds.height)

        NSLayoutConstraint.activate([playButtonViewCenterX, playButtonViewCenterY, playButtonViewWidth, playButtonViewHeight])
        
        activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        
        let activityIndicatorViewCenterX = activityIndicatorView.centerXAnchor.constraint(equalTo: messageContainerView.centerXAnchor)
        let activityIndicatorViewCenterY = activityIndicatorView.centerYAnchor.constraint(equalTo: messageContainerView.centerYAnchor)
        let activityIndicatorViewWidth = activityIndicatorView.widthAnchor.constraint(equalToConstant: activityIndicatorView.bounds.width)
        let activityIndicatorViewHeight = activityIndicatorView.heightAnchor.constraint(equalToConstant: activityIndicatorView.bounds.height)
        
        NSLayoutConstraint.activate([activityIndicatorViewCenterX, activityIndicatorViewCenterY, activityIndicatorViewWidth, activityIndicatorViewHeight])
    }

    override func setupSubviews() {
        super.setupSubviews()
        messageContentView.addSubview(playButtonView)
        messageContentView.addSubview(activityIndicatorView)
        setupConstraints()
    }

    open override func configure(with message: MessageType, at indexPath: IndexPath, and messagesCollectionView: MessagesCollectionView) {
        super.configure(with: message, at: indexPath, and: messagesCollectionView)
        
        dataSource?.setupContentMode(for: messageContentView, in: self)
        
        switch message.data {
        case .photo(let image):
            messageContentView.image = image
            playButtonView.isHidden = true
            activityIndicatorView.isHidden = true
        case .remotePhoto(let url, let image):
            messageContentView.image = image
            playButtonView.isHidden = true
            activityIndicatorView.isHidden = !(image == nil)
            activityIndicatorView.startAnimating()
            dataSource?.downloadImage(by: url, for: messageContentView, in: self) {
                self.activityIndicatorView.stopAnimating()
            }
        case .video(_, let image):
            messageContentView.image = image
            playButtonView.isHidden = false
            activityIndicatorView.isHidden = true
        default:
            break
        }
    }

}
