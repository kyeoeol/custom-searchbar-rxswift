<div align=center>
  
# Custom SearchBar with RxSwift
<image src="https://user-images.githubusercontent.com/80438047/152357624-21e60011-b3ee-4435-a56e-4a88f8157193.gif" width="200">
</div>
  
## Outlets
```swift
  @IBOutlet weak var logoImageView: UIImageView!
  @IBOutlet weak var backwardButton: UIButton!

  @IBOutlet weak var searchStarckView: UIStackView!
  @IBOutlet weak var searchInputField: UITextField!
  @IBOutlet weak var searhButton: UIButton!

  @IBOutlet weak var searchResultView: UIView!
  @IBOutlet weak var tableView: UITableView!
  @IBOutlet weak var noSearchResultLabel: UILabel!
```
  
## Bind - searchInputField
```swift
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
```
  
## Bind - backwardButton
```swift
  backwardButton.rx.tap
      .subscribe(onNext: {
          self.initializeSearchBar()
      })
      .disposed(by: disposeBag)
  
  func initializeSearchBar() {
        logoImageView.isHidden = false
        backwardButton.isHidden = true
        searchResultView.isHidden = true
        searchInputField.text = nil
        tableView.isHidden = true
        noSearchResultLabel.isHidden = false
        
        view.endEditing(true)
    }
```
