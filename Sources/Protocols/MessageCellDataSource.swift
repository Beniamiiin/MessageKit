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

import Foundation

public typealias DownloadImageCompletionClosure = (() -> Void)

/// A protocol used by `MessageCollectionViewCell` subclasses to download content(photo) for cell.
public protocol MessageCellDataSource: class {

    /// A helper method to download image for showing in a cell.
    ///
    /// - Parameters:
    ///   - url: The url for downloading image.
    ///   - imageView: The imageView where will be set the image when it is downloaded.
    ///   - cell: The cell where have to show photo.
    ///   - completion: The completion block will be called when the image is downloaded.
    ///
    /// You have to call the completion block for stoping activityIndicatorView animating.
    func downloadImage(by url: URL, for imageView: UIImageView, in cell: MessageCollectionViewCell<UIImageView>, completion: @escaping DownloadImageCompletionClosure)
    
    /// A helper method to download avatar image for showing in a cell.
    ///
    /// - Parameters:
    ///   - url: The url for downloading image.
    ///   - imageView: The imageView where will be set the image when it is downloaded.
    ///   - cell: The cell where have to show photo.
    func downloadAvatarImage<T>(by url: URL, for imageView: UIImageView, in cell: MessageCollectionViewCell<T>)
    
}

public extension MessageCellDataSource {

    func downloadImage(by url: URL, for imageView: UIImageView, in cell: MessageCollectionViewCell<UIImageView>, completion: @escaping DownloadImageCompletionClosure) {}

    func downloadAvatarImage<T>(by url: URL, for imageView: UIImageView, in cell: MessageCollectionViewCell<T>) {}
    
}
