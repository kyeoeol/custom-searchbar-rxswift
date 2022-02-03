//
//  ViewController.swift
//  SearchBar
//
//  Created by haanwave on 2022/02/03.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {
    private var disposeBag = DisposeBag()
    
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var backwardButton: UIButton!
    
    @IBOutlet weak var searchStarckView: UIStackView!
    @IBOutlet weak var searchInputField: UITextField!
    @IBOutlet weak var searhButton: UIButton!
    
    @IBOutlet weak var searchResultView: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var noSearchResultLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        initializeSearchBar()
        bind()
    }
    
    private func bind() {
        searchInputField.rx.controlEvent(.editingDidBegin)
            .subscribe(onNext: {
                self.logoImageView.isHidden = true
                self.backwardButton.isHidden = false
                self.searchResultView.isHidden = false
            })
            .disposed(by: disposeBag)
        
        searchInputField.rx.controlEvent(.editingDidEndOnExit)
            .map {
                self.searchInputField.text?.isEmpty ?? true
            }
            .subscribe(onNext: { isEmpty in
                self.tableView.isHidden = isEmpty
                self.noSearchResultLabel.isHidden = !isEmpty
            })
            .disposed(by: disposeBag)
        
        backwardButton.rx.tap
            .subscribe(onNext: {
                self.initializeSearchBar()
            })
            .disposed(by: disposeBag)
    }
}

// MARK: - UITableViewDataSource
extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchResultCell",
                                                 for: indexPath)
        return cell
    }
}

// MARK: - Helper
private extension ViewController {
    func initializeSearchBar() {
        logoImageView.isHidden = false
        backwardButton.isHidden = true
        searchResultView.isHidden = true
        searchInputField.text = nil
        tableView.isHidden = true
        noSearchResultLabel.isHidden = false
        
        view.endEditing(true)
    }
}

// MARK: - Configure
private extension ViewController {
    func configureView() {
        searchStarckView.setBorder(color: .systemBlue,
                                   width: 1.0,
                                   radius: searchStarckView.frame.height / 2)
    }
}
