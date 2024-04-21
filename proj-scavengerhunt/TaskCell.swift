//
//  TaskCell.swift
//  proj-scavengerhunt
//
//  Created by Nafay on 1/29/24.
//

import UIKit
import Nuke

class TaskCell: UITableViewCell {
    
    
    @IBOutlet var completedImageView: UIImageView!
    
    @IBOutlet var descLabel: UILabel!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var bgImage: UIImageView!
    @IBOutlet var difficultyLabel: UIImageView!
    
    func configure(with task: Task) {
        titleLabel.text = task.title
        descLabel.text = task.description
        
        
        switch task.difficulty {
        case "Easy":
            difficultyLabel.image = UIImage(named: "easy")
        case "Medium":
            difficultyLabel.image = UIImage(named: "med")
        case "Hard":
            difficultyLabel.image = UIImage(named: "hard")
        default:
            difficultyLabel.image = UIImage(named: "TravelDC")
        }
        
        let imageURL: URL = task.bgimage ?? URL(string: "https://salonlfc.com/wp-content/uploads/2018/01/image-not-found-1-scaled-1150x647.png")!
           Nuke.loadImage(with: imageURL, into: bgImage)
        
        //titleLabel.textColor = task.isComplete ? .secondaryLabel : .label
        //completedImageView.image = UIImage(systemName: task.isComplete ? "circle.inset.filled" : "circle")?.withRenderingMode(.alwaysTemplate)
        //completedImageView.tintColor = task.isComplete ? .systemBlue : .tertiaryLabel
    }

}
