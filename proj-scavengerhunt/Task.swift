//
//  Task.swift
//  lab-task-squirrel
//
//  Created by Charlie Hieger on 11/15/22.
//

import UIKit
import CoreLocation

class Task {
    let title: String
    let description: String
    var bgimage: URL?
    let difficulty: String
    var image: UIImage?
    var imageLocation: CLLocation?
    var isComplete: Bool {
        image != nil
    }

    init(title: String, description: String, bgimage: URL? = nil, difficulty: String) {
        self.title = title
        self.description = description
        self.bgimage = bgimage
        self.difficulty = difficulty
    }

    func set(_ image: UIImage, with location: CLLocation) {
        self.image = image
        self.imageLocation = location
    }
}

extension Task {
    static var mockedTasks: [Task] {
        return [
            Task(title: "Washington Monument",
                 description: "Take a selfie near the Washington Monument", bgimage: URL(string:"https://i.postimg.cc/59rHXb1d/Rectangle-1-1.png"), difficulty: "Easy"),
            Task(title: "Museum of Natural History",
                 description: "Visit the Smithsonian National Museum of Natural History and take selfies with the giant elephants!", bgimage: URL(string:"https://i.ibb.co/7NCFvJq/Rectangle-8.png"), difficulty: "Medium"),
            Task(title: "Lincoln Memorial",
                             description: "Pay a visit to the Lincoln Memorial and learn about American history.",
                             bgimage: URL(string: "https://i.ibb.co/kSsbNjF/Rectangle-8-1.png"), difficulty: "Hard")
        ]
    }
}
