//
//  FeedTableViewCell.swift
//  proj-scavengerhunt
//
//  Created by Yafet Tedla on 4/20/24.
//

import UIKit
import Alamofire
import AlamofireImage

class FeedTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var userProfileImageView: UIImageView!
    
    @IBOutlet weak var usernameLabel: UILabel!
    
    @IBOutlet weak var captionLabel: UILabel!
    
    
    private var imageDataRequest: DataRequest?

    func configure(with post: Post) {
        // TODO: Pt 1 - Configure Post Cell
        // Username
        if let user = post.user {
            usernameLabel.text = user.username
        }

        // Image
        if let imageFile = post.imageFile,
           let imageUrl = imageFile.url {
            
            // Use AlamofireImage helper to fetch remote image from URL
            imageDataRequest = AF.request(imageUrl).responseImage { [weak self] response in
                switch response.result {
                case .success(let image):
                    // Set image view image with fetched image
                    self?.userProfileImageView.image = image
                case .failure(let error):
                    print("❌ Error fetching image: \(error.localizedDescription)")
                    break
                }
            }
        }

        // Caption
        captionLabel.text = post.caption

        
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        // TODO: P1 - Cancel image download
        // Reset image view image.
        userProfileImageView.image = nil

        // Cancel image request.
        imageDataRequest?.cancel()
    }

}
