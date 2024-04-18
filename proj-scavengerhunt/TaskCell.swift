//
//  TaskCell.swift
//  proj-scavengerhunt
//
//  Created by Nafay on 1/29/24.
//

import UIKit

class TaskCell: UITableViewCell {
    
    
    @IBOutlet var completedImageView: UIImageView!
    
    @IBOutlet var titleLabel: UILabel!
    
    func configure(with task: Task) {
        titleLabel.text = task.title
        titleLabel.textColor = task.isComplete ? .secondaryLabel : .label
        completedImageView.image = UIImage(systemName: task.isComplete ? "circle.inset.filled" : "circle")?.withRenderingMode(.alwaysTemplate)
        completedImageView.tintColor = task.isComplete ? .systemBlue : .tertiaryLabel
    }

}
