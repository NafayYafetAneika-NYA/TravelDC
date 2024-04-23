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
                 bgimage: URL(string: "https://i.ibb.co/kSsbNjF/Rectangle-8-1.png"), difficulty: "Hard"),
            Task(title: "Shotted Cafe",
                 description: "Try Arabic chai at Shotted cafe in Tysons corner", bgimage: URL(string: "https://i.ibb.co/DWtRMkg/Rectangle-8-2.png"), difficulty: "Easy"),
            Task(title: "Lincoln Memorial",
                 description: "Take a selfie with Abraham Lincoln’s statue", bgimage: URL(string: "https://i.ibb.co/dBL676K/Rectangle-8-3.png"), difficulty: "Easy"),
            Task(title: "National Mall",
                 description: "Run a 5k around the national mall", bgimage: URL(string: "https://i.ibb.co/v41HYRM/Rectangle-8-4.png"), difficulty: "Hard"),
            Task(title: "DC Wharf",
                 description: "Walk around with a friend on the dc wharf", bgimage: URL(string: "https://i.ibb.co/qxNdG2T/Rectangle-8-5.png"), difficulty: "Medium"),
            Task(title: "Tidal Basin",
                 description: "Sit and meditate near the tidal basin", bgimage: URL(string: "https://i.ibb.co/rGqrVmc/Rectangle-8-6.png"), difficulty: "Medium")

        ]
    }

}
