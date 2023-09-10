//
//  ExpensesVC.swift
//  TrackerApp
//
//  Created by duynt0124 on 08/09/2023.
//

import UIKit

enum TypeSortExpense: Int{
    case category = 0
    case date = 1
}

class ExpensesVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //MARK: IBOUTLETS
    @IBOutlet weak var viewEmpty: UIView!
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
            
            tableView.register(nibWithCellClass: ExpenseTBCell.self)
//            tableView.crHeadRefresh {
//                self.callAPI()
//            }
//            tableView.crFootRefresh {
//                if self.datas.count < self.total {
//                    self.page += 1
//                    self.callAPI()
//                }else {
//                    //self.tableView.crEndRefresh()
//                    self.tableView.updateRefreshStatus(self.datas.count, totalPage: self.total)
//                }
//            }
            
            self.tableView.reloadData()
        }
    }
    
    var dataSources:[Expense] = [] {
        didSet {
            viewEmpty.isHidden = true//self.dataSources.count == 0
            self.tableView.reloadData()
        }
    }
    
    var total = 0
    //MARK: OTHER VARIABLES
    let vm = ExpenseViewModel()
    var typeSort: TypeSortExpense = .category
    var categoryName: String?
    
    //MARK: VIEW LIFE CYCLE
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setupVar()
        setupUI()
        callAPI()
    }
    
    //MARK: - SETUP UI & VAR
    func setupVar() {
        self.navigationItem.title = "Expenses"
        let createItem = UIBarButtonItem(title: "Create", style: .done, target: self, action: #selector(self.createAction))
        self.navigationItem.rightBarButtonItem = createItem
        if let categoryName = categoryName{
            
        }else{
            let filterItem = UIBarButtonItem(title: "Sort", style: .done, target: self, action: #selector(self.filterAction))
            self.navigationItem.leftBarButtonItem = filterItem
        }
        
        
    }
    
    func setupUI() {
        
    }
    
    //MARK - CALL API
    func callAPI() {
        if let categoryName = categoryName{
            vm.fetchExpensesForCategory(category: categoryName) { [weak self] datas in
                guard let self = self else{
                    return
                }
                self.dataSources = datas
            }
        }else{
            vm.fetchExpenses { [weak self] datas in
                guard let self = self else{
                    return
                }
                self.dataSources = datas
            }
        }
        
    }
    
    //MARK: - FILL DATA
    func fillData() {
        
    }

    //MARK: - BUTTON ACTIONS
    @objc func createAction() {
        let alert = SettingView.instanceFromNib()
                
        alert.show(typeView: .kExpense, vm_ : self.vm, self) { (isRefresh) in
            if isRefresh!{
                self.vm.fetchExpenses { datas in
                    self.dataSources =  datas
                }
            }
        }
        
    }
    
    @objc func filterAction() {
        let alertController = UIAlertController(title: "Sort Expenses By", message: nil, preferredStyle: .actionSheet)
        
        // Sort by Category action
        let sortByCategoryAction = UIAlertAction(title: "Category", style: .default) { _ in
            // Call a function to sort expenses by category
            self.sortExpensesByCategory()
        }
        
        // Sort by Date action
        let sortByDateAction = UIAlertAction(title: "Date", style: .default) { _ in
            // Call a function to sort expenses by date
            self.sortExpensesByDate()
        }
        
        // Cancel action
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alertController.addAction(sortByCategoryAction)
        alertController.addAction(sortByDateAction)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }

    func sortExpensesByCategory() {
        // Sort your expenses array by category here
        self.dataSources = self.dataSources.sorted(by: {$0.category > $1.category})
    }

    func sortExpensesByDate() {
        // Sort your expenses array by date here
        self.dataSources = self.dataSources.sorted(by: {$0.date > $1.date})
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSources.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withClass: ExpenseTBCell.self)
        cell.fillData(dataSources[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let data = dataSources[indexPath.row]
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            self.vm.deleteExpense(expenseId: self.dataSources[indexPath.row].id) { [weak self] error in
                guard let self = self else { return }
                if let error = error as? CustomError{
                    self.showAlert(title: kErrorTitle, message: error.localizedDescription)
                }else if let error = error {
                    // Handle the error
                    self.showAlert(title: kErrorTitle, message: error.localizedDescription)
                    print("error.localizedDescription: \(error.localizedDescription)")
                } else {
                    let deletedExpense = self.dataSources.remove(at: indexPath.row)
                    tableView.deleteRows(at: [indexPath], with: .fade)
                }

                
                
            }
        }
    }
}

