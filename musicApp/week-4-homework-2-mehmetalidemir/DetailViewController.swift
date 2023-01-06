//
//  DetailViewController.swift
//  week-4-homework-2-mehmetalidemir
//
//  Created by Mehmet Ali Demir on 4.01.2023.
//

import UIKit


class DetailViewController: UIViewController {

    @IBOutlet weak var heroLabel: UILabel!

    @IBOutlet weak var attackTypeLabel: UILabel!
    @IBOutlet weak var heroImage: UIImageView!

    // Property to hold the hero data
    var hero: HeroStats?
    override func viewDidLoad() {
        super.viewDidLoad()
        // Set the label text to the hero's name
        heroLabel.text = hero?.localized_name
        // Set the attack type label text to the hero's attack type
        attackTypeLabel.text = "Attack Type: \(String(describing: hero?.attack_type ?? ""))"
        let imgUrl = "https://api.opendota.com" + (hero?.img)!
        print(imgUrl)
        // Download and display the hero image
        heroImage.downloaded(from: imgUrl)
    }
}

// MARK: - Image Downloading Extension

extension UIImageView {
    // Function to download and display an image from a URL
    func downloaded(from url: URL, contentMode mode: ContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            // Check that the response is successful and the data is an image
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            // Update the image on the main queue
            DispatchQueue.main.async() { [weak self] in
                self?.image = image
            }
        }.resume()
    }
    // Function to download and display an image from a string URL
    func downloaded(from link: String, contentMode mode: ContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        // Download and display the image
        downloaded(from: url, contentMode: mode)
    }
}
