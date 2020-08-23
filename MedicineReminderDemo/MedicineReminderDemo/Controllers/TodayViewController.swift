//
//  ViewController.swift
//  ReminderDemo
//
//  Copyright © 2020 Anmol. All rights reserved.
//

import UIKit

class TodayViewController: UIViewController {
    @IBOutlet weak var labelGreeting: UILabel!
    @IBOutlet weak var btnMedicineTaken: UIButton!
    @IBOutlet weak var labelScore: UILabel!
    
    lazy var viewModel : TodayViewModel = {
        let viewModel = TodayViewModel()
        return viewModel
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        prepareTodayViewModel()
        addObservers()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        updateViewModelData()
    }
    
    //MARK: Observer
    func addObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(updateViewModelData), name: UIApplication.willEnterForegroundNotification, object: nil)
    }
    
    //MARK: UI
    func configureUI() {
        //Configuring Nav Bar
        let historyImage = UIImage(named: ImageConstants.IC_HISTORY)
        let historyBarBtn = UIBarButtonItem(image: historyImage, style: .plain, target: self, action: #selector(self.showHistory))
        navigationItem.rightBarButtonItem = historyBarBtn
        self.navigationItem.title = TextConstants.HOME_SCREEN_TITLE
        btnMedicineTaken.applyCardLayout()
    }
    
    @objc func updateViewModelData() {
        viewModel.updateTodayScore()
    }
    
    func prepareTodayViewModel() {
        viewModel.loadDataOnUI = { [weak self] in
            guard let self = self else {
                return
            }
            self.labelGreeting.text = self.viewModel.getGreetingText()
            self.labelScore.text = "\(self.viewModel.getTodayScore())"
            self.labelScore.textColor = self.viewModel.getScoreColor()
        }
        
        viewModel.updateMedicineLog = { [weak self] (success, message) in
            guard let self = self else {
                return
            }
            AppRouter.showAlert(title: nil, message: message, from: self)
        }
    }
    
    //MARK: Actions
    @objc func showHistory() {
        AppRouter.pushHistoryViewController(from: self.navigationController!)
    }
    
    @IBAction func btnMedicineTakenTapped(_ sender: Any) {
        viewModel.takeMedicine()
    }
}

