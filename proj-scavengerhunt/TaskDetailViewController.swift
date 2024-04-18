//
//  TaskDetailViewController.swift
//  proj-scavengerhunt
//
//  Created by Nafay on 1/29/24.
//

import UIKit
import MapKit
import PhotosUI
import ParseSwift

class TaskDetailViewController: UIViewController {

    @IBOutlet var completedImageView: UIImageView!
    @IBOutlet var completedLabel: UILabel!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var attachPhotoButton: UIButton!
    
    @IBOutlet weak var captionTextField: UITextField!
    
    @IBOutlet weak var feedLabel: UIButton!
    
    
    @IBOutlet var mapView: MKMapView!
    
    private var pickedImage: UIImage?
        var task: Task!
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            mapView.register(TaskAnnotationView.self, forAnnotationViewWithReuseIdentifier: TaskAnnotationView.identifier)
            mapView.delegate = self
            mapView.layer.cornerRadius = 12
            
            updateUI()
            updateMapView()
        }
        
        private func updateUI() {
            titleLabel.text = task.title
            descriptionLabel.text = task.description
            
            let completedImage = UIImage(systemName: task.isComplete ? "circle.inset.filled" : "circle")
            completedImageView.image = completedImage?.withRenderingMode(.alwaysTemplate)
            completedLabel.text = task.isComplete ? "Complete" : "Incomplete"
            
            let color: UIColor = task.isComplete ? .systemBlue : .tertiaryLabel
            completedImageView.tintColor = color
            completedLabel.textColor = color
            
            attachPhotoButton.isHidden = task.isComplete
        }
        
        @IBAction func feedLabelTapped(_ sender: UIButton) {
            print("Feed label tapped")
            performSegue(withIdentifier: "FeedSegue", sender: self)
        }
        
        @IBAction func didTapAttachPhotoButton(_ sender: Any) {
            if PHPhotoLibrary.authorizationStatus(for: .readWrite) != .authorized {
                PHPhotoLibrary.requestAuthorization(for: .readWrite) { [weak self] status in
                    DispatchQueue.main.async {
                        if status == .authorized {
                            self?.presentImagePicker()
                        } else {
                            self?.presentGoToSettingsAlert()
                        }
                    }
                }
            } else {
                presentImagePicker()
            }
        }
        
        private func presentImagePicker() {
            var config = PHPickerConfiguration(photoLibrary: PHPhotoLibrary.shared())
            config.filter = .images
            config.preferredAssetRepresentationMode = .current
            config.selectionLimit = 1
            
            let picker = PHPickerViewController(configuration: config)
            picker.delegate = self
            present(picker, animated: true)
        }
        
        private func savePostWithImage() {
            guard let image = pickedImage,
                  let imageData = image.jpegData(compressionQuality: 0.1) else {
                return
            }
            
            let file = ParseFile(name: "image.jpg", data: imageData)
            
            // Generate random username and password
            let randomUsername = generateRandomUsername()
            let randomPassword = generateRandomPassword()
            
            // Create a User object with random username and password
            let user = User(username: randomUsername, password: randomPassword)
            
            // Create a Post object and set the caption, image file, and user
            var post = Post()
            post.caption = captionTextField.text ?? "No caption" // Use the text from captionTextField or a default value
            post.imageFile = file
            post.user = user
            
            // Save the Post object to the Parse database
            post.save { result in
                switch result {
                case .success(let savedPost):
                    print("Post saved successfully with objectId: \(savedPost.objectId ?? "")")
                    // Handle success (e.g., show success message, refresh UI, etc.)
                case .failure(let error):
                    print("Error saving post: \(error)")
                    // Handle failure (e.g., show error message to the user)
                }
            }
        }
        
        func generateRandomUsername() -> String {
            let adjectives = ["Happy", "Funny", "Lucky", "Clever", "Silly", "Cool"]
            let nouns = ["Cat", "Dog", "Bird", "Fish", "Bear", "Tiger"]
            let randomAdjective = adjectives.randomElement() ?? "Random"
            let randomNoun = nouns.randomElement() ?? "User"
            let randomNumber = Int.random(in: 100...999) // Generate a random number between 100 and 999
            return "\(randomAdjective)\(randomNoun)\(randomNumber)"
        }
        
        private func generateRandomPassword(length: Int = 8) -> String {
            let characters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
            let password = String((0..<length).map { _ in characters.randomElement()! })
            return password
        }
        
        func updateMapView() {
            guard let imageLocation = task.imageLocation else { return }
            let coordinate = imageLocation.coordinate
            let region = MKCoordinateRegion(center: coordinate, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
            mapView.setRegion(region, animated: true)
            
            let annotation = MKPointAnnotation()
            annotation.coordinate = coordinate
            mapView.addAnnotation(annotation)
        }
    }

    extension TaskDetailViewController: PHPickerViewControllerDelegate {
        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            picker.dismiss(animated: true)

            // Get the first result from the picker
            guard let result = results.first else {
                return
            }

            // Check if the item provider can load a UIImage
            if result.itemProvider.canLoadObject(ofClass: UIImage.self) {
                result.itemProvider.loadObject(ofClass: UIImage.self) { [weak self] object, error in
                    // Handle the loaded object (image) on the main queue
                    DispatchQueue.main.async {
                        if let image = object as? UIImage {
                            self?.pickedImage = image
                            self?.savePostWithImage()
                            self?.updateUI()
                        } else if let error = error {
                            self?.showAlert(for: error)
                        }
                    }
                }
            } else {
                // Handle case where item provider cannot load a UIImage
                print("Item provider cannot load UIImage")
            }
        }
    }

    extension TaskDetailViewController: MKMapViewDelegate {
        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
            guard let annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: TaskAnnotationView.identifier, for: annotation) as? TaskAnnotationView else {
                fatalError("Unable to dequeue TaskAnnotationView")
            }
            
            annotationView.configure(with: task.image)
            return annotationView
        }
    }

    extension TaskDetailViewController {
        func presentGoToSettingsAlert() {
            let alertController = UIAlertController(
                title: "Photo Access Required",
                message: "In order to post a photo to complete a task, we need access to your photo library. You can allow access in Settings",
                preferredStyle: .alert)
            
            let settingsAction = UIAlertAction(title: "Settings", style: .default) { _ in
                if let settingsUrl = URL(string: UIApplication.openSettingsURLString),
                   UIApplication.shared.canOpenURL(settingsUrl) {
                    UIApplication.shared.open(settingsUrl)
                }
            }
            
            alertController.addAction(settingsAction)
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            alertController.addAction(cancelAction)
            
            present(alertController, animated: true)
        }
        
        func showAlert(for error: Error) {
            let alertController = UIAlertController(
                title: "Error",
                message: error.localizedDescription,
                preferredStyle: .alert)
            
            let okAction = UIAlertAction(title: "OK", style: .default)
            alertController.addAction(okAction)
            
            present(alertController, animated: true)
        }
    }
