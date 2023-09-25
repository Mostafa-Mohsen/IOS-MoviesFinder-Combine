//
//  ViewController.swift
//  5-Movies
//
//  Created by M-M-M on 30/05/2023.
//

import UIKit
import Combine

class ViewController: UIViewController {
    @IBOutlet weak var textField: UITextField! {
        didSet {
            textField.delegate = self
        }
    }
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.register(UINib(nibName: "MovieCell", bundle: nil), forCellReuseIdentifier: "MovieCell")
            tableView.dataSource = self
            tableView.delegate = self
        }
    }
    
    private var viewModel = MoviesListViewModel()
    private var cancellable: [AnyCancellable] = []
    private var moviesList: [Movie] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Movies"
        viewModel.moviesPublisher.sink() { [weak self] movies in
            guard let weakSelf = self else { return }
            weakSelf.moviesList = movies
            weakSelf.tableView.reloadData()
        }
        .store(in: &cancellable)
        
        viewModel.movieDetailPublihser.sink() { [weak self] movie in
            guard let weakSelf = self else { return }
            let vc = MovieDetailsViewController.getMovieDetailsViewController(with: movie)
            weakSelf.navigationController?.pushViewController(vc, animated: true)
        }
        .store(in: &cancellable)
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return moviesList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath)
        (cell as? MovieCell)?.configure(with: moviesList[indexPath.row])
        return cell
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let movie = moviesList[indexPath.row]
        viewModel.didSelect(movie: movie)
    }
}

extension ViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let text = textField.text, !text.isEmpty else { return }
        viewModel.getMovies(name: text)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

