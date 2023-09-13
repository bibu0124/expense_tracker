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
struct ExpenseSection {
    var headerTitle: String
    var expenses: [Expense]
}


class ExpensesVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //MARK: IBOUTLETS
    @IBOutlet weak var viewEmpty: UIView!
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
            
            tableView.register(nibWithCellClass: ExpenseTBCell.self)
            
            self.tableView.reloadData()
        }
    }
    
    var dataSources:[Expense] = [] {
        didSet {
            groupExpenses()
            //self.tableView.reloadData()
        }
    }
    
    var total = 0
    //MARK: OTHER VARIABLES
    let vm = ExpenseViewModel()
    var typeSort: TypeSortExpense = .category
    var categoryName: String?
    var expenseSections: [ExpenseSection] = []
    //MARK: VIEW LIFE CYCLE
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.callAPI()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setupVar()
        setupUI()
        
    }
    
    func groupExpenses() {
        expenseSections.removeAll()
        print("sort Type in groupExpenses: \(typeSort)")
        
        switch typeSort {
        case .date:
            // Group by date
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd" // Customize the date format as needed
            
            for expense in dataSources {
                let dateString = dateFormatter.string(from: expense.date)
                
                if let index = expenseSections.firstIndex(where: { $0.headerTitle == dateString }) {
                    expenseSections[index].expenses.append(expense)
                    // Sort the expenses in the section by date
                    expenseSections[index].expenses.sort { $0.date > $1.date }
                } else {
                    var newSection = ExpenseSection(headerTitle: dateString, expenses: [expense])
                    // Sort the expenses in the new section by date
                    newSection.expenses.sort { $0.date > $1.date }
                    expenseSections.append(newSection)
                }
            }
            
            // Sort sections by date in descending order
            expenseSections.sort { section1, section2 in
                let date1 = dateFormatter.date(from: section1.headerTitle)!
                let date2 = dateFormatter.date(from: section2.headerTitle)!
                return date1 > date2
            }
            
        case .category:
            // Group by category
            for expense in dataSources {
                let category = expense.category
                
                if let index = expenseSections.firstIndex(where: { $0.headerTitle == category }) {
                    expenseSections[index].expenses.append(expense)
                    // Sort the expenses in the section by date
                    expenseSections[index].expenses.sort { $0.date > $1.date }
                } else {
                    var newSection = ExpenseSection(headerTitle: category, expenses: [expense])
                    // Sort the expenses in the new section by date
                    newSection.expenses.sort { $0.date > $1.date }
                    expenseSections.append(newSection)
                }
            }
            
            // Sort sections alphabetically by category title
            expenseSections.sort { section1, section2 in
                return section1.headerTitle < section2.headerTitle
            }
        }

        tableView.reloadData()
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
        self.typeSort = .date
        
    }
    
    func setupUI() {
        
    }
    
    //MARK - CALL API
    func callAPI() {
        print("categoryName \(categoryName)")
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
        alert.categoryName = categoryName // create expense from Category's expenses screen
        alert.show(typeView: .kExpense, vm_ : self.vm, self) { (isRefresh) in
            if let isRefresh = isRefresh{
                if isRefresh{
                    self.callAPI()
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
        
        //self.dataSources = self.dataSources.sorted(by: {$0.category < $1.category})
        self.typeSort = .category
        groupExpenses()
    }

    func sortExpensesByDate() {
        
        //self.dataSources = self.dataSources.sorted(by: {$0.date > $1.date})
        self.typeSort = .date
        groupExpenses()
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedExpense = expenseSections[indexPath.section].expenses[indexPath.row]
        
        print("Selected Expense: \(selectedExpense)")
        let alert = SettingView.instanceFromNib()
        alert.editExpense = selectedExpense
        alert.show(typeView: .kExpense, vm_ : self.vm, self) { (isRefresh) in
            if let isRefresh = isRefresh {
                if isRefresh {
                    self.callAPI()
                }
            }
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return expenseSections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return expenseSections[section].expenses.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return expenseSections[section].headerTitle
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withClass: ExpenseTBCell.self)
        let expense = expenseSections[indexPath.section].expenses[indexPath.row]
        cell.fillData(expense, typeSort: self.typeSort)
        
        // Define a callback for the delete action
        cell.callBackWithAction = { [weak self] (action, value) in
            guard let self = self else {
                return
            }
            if action == 1 {
                self.showAlert(title: kNotificationTitle, message: "Do you want to delete this expense?", buttonTitles: ["No", "Yes"], highlightedButtonIndex: nil, completion: { (index) in
                    if index == 1 {
                        // User confirmed deletion
                        self.vm.deleteExpense(expenseId: expense.id) { [weak self] error in
                            guard let self = self else { return }
                            if let error = error as? CustomError {
                                self.showAlert(title: kErrorTitle, message: error.localizedDescription)
                            } else if let error = error {
                                // Handle the error
                                self.showAlert(title: kErrorTitle, message: error.localizedDescription)
                                print("error.localizedDescription: \(error.localizedDescription)")
                            } else {
                                // Delete the expense from the data source and the table view
                                self.expenseSections[indexPath.section].expenses.remove(at: indexPath.row)
                                tableView.deleteRows(at: [indexPath], with: .fade)
                                self.dataSources = self.dataSources.filter { $0.id != expense.id }
                            }
                        }
                    }
                })
            }
        }
        
        return cell
    }

    
}

