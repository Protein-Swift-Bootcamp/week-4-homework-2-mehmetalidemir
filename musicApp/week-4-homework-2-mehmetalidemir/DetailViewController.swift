//
//  DetailViewController.swift
//  week-4-homework-2-mehmetalidemir
//
//  Created by Mehmet Ali Demir on 4.01.2023.
//

import UIKit


class DetailViewController: UIViewController {

    @IBOutlet weak var heroLabel: UILabel!

    @IBOutlet weak var heroImage: UIImageView!
                       
                       
    var hero: HeroStats?
    override func viewDidLoad() {
        super.viewDidLoad()
        heroLabel.text = hero?.localized_name
        let imgUrl = "https://api.opendota.com" + (hero?.img)!
        print(imgUrl)
        heroImage.downloaded(from: imgUrl)
    }
}

extension UIImageView {
    func downloaded(from url: URL, contentMode mode: ContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() { [weak self] in
                self?.image = image
            }
        }.resume()
    }
    func downloaded(from link: String, contentMode mode: ContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
}
