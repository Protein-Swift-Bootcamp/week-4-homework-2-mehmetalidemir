//
//  ViewController.swift
//  week-4-homework-2-mehmetalidemir
//
//  Created by Mehmet Ali Demir on 3.01.2023.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    // Array to hold the hero stats data
    var heroes = [HeroStats]()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Fetch herostats data and reload the table view when finished
        fetchData {
            self.tableView.reloadData()
            self.activityIndicator.stopAnimating()
            self.activityIndicator.isHidden = true
            print("success")
        }

        tableView.dataSource = self
        tableView.delegate = self
        // Register the custom cell class for the table view
        tableView.register(UINib.init(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        // Show the activity indicator while the data is being fetched
        activityIndicator.startAnimating()
    }

}

// MARK: - TableView Data Source and Delegate

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of heroes in the heroes array
        return heroes.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? TableViewCell
        // Get the hero for the current row
        let hero = heroes[indexPath.row]
        // Set the label text to the hero's name
        cell?.lbl.text = hero.localized_name.capitalized

        return cell!

    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Get an instance of the DetailViewController and set the hero property to the selected hero
        let vc = storyboard?.instantiateViewController(withIdentifier: "detail") as? DetailViewController
        let hero = heroes[indexPath.row]
        vc?.hero = hero
        // Set the modal presentation style and present the view controller
        vc?.modalPresentationStyle = .formSheet
        present(vc!, animated: true, completion: nil)
    }


    // MARK: - Data Fetching
    func fetchData(completed: @escaping () -> ()) {
        let url = URL(string: "https://api.opendota.com/api/heroStats")

        URLSession.shared.dataTask(with: url!) { data, response, err in

            if err == nil {
                do {
                    self.heroes = try JSONDecoder().decode([HeroStats].self, from: data!)
                    DispatchQueue.main.async {
                        completed()
                    }
                }
                catch {
                    print("error fetching data from api")
                }
            }
        }.resume()
    }

}




