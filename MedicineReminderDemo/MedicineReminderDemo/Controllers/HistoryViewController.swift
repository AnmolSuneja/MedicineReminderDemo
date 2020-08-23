//
//  HistoryViewController.swift
//  ReminderDemo
//
//  Copyright © 2020 Anmol. All rights reserved.
//

import UIKit

class HistoryViewController: UIViewController, ReusableInterface {
    
    @IBOutlet weak var tableViewHistory: UITableView!

    lazy var viewModel : HistoryViewModel = {
        let viewModel = HistoryViewModel()
        return viewModel
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        
        //ViewModel
        prepareHistoryViewModel()
        viewModel.loadHistoryData()
        addObservers()
    }
    
    //MARK: Observer
    func addObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(updateViewModelData), name: UIApplication.willEnterForegroundNotification, object: nil)
    }
    
    //MARK: UI
    func configureUI() {
        //Configuring Nav Bar
        self.navigationItem.title = TextConstants.HISTORY_SCREEN_TITLE
        
        //Configure Table View
        let nib = UINib(nibName: HistoryTableViewCell.reuseIdentifier, bundle: nil)
        tableViewHistory.register(nib, forCellReuseIdentifier: HistoryTableViewCell.reuseIdentifier)
        tableViewHistory.dataSource = self
        tableViewHistory.delegate = self

    }
    
    @objc func updateViewModelData() {
        viewModel.loadHistoryData()
    }
    
    func prepareHistoryViewModel() {        
        viewModel.loadDataOnUI = { [weak self] in
            self?.tableViewHistory.reloadData()
        }
    }

}

extension HistoryViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfModels(section: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:HistoryTableViewCell = tableView.dequeueReusableCell(withIdentifier: HistoryTableViewCell.reuseIdentifier, for: indexPath) as! HistoryTableViewCell
        cell.configureCell(model: viewModel.getHistoryModel(indexPath: indexPath))
        return cell
    }
}

extension HistoryViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return viewModel.height(indexPath: indexPath)
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return viewModel.height(indexPath: indexPath)
    }
}
