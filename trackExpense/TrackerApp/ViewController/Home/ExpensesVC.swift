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
    var groupedExpenses: [String: [Expense]] = [:]
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
        groupedExpenses.removeAll()
        print("sort Type in groupExpenses: \(typeSort)")
        switch typeSort {
        case .date:
            // Group by date
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd" // Customize the date format as needed
            
            for expense in dataSources {
                let dateString = dateFormatter.string(from: expense.date)
                
                if var expensesForDate = groupedExpenses[dateString] {
                    expensesForDate.append(expense)
                    groupedExpenses[dateString] = expensesForDate
                } else {
                    groupedExpenses[dateString] = [expense]
                }
            }
            // Sort the section keys (dates) in descending order (newest first)
            let sortedKeys = groupedExpenses.keys.sorted { dateFormatter.date(from: $0)! > dateFormatter.date(from: $1)! }
            groupedExpenses = Dictionary(uniqueKeysWithValues: sortedKeys.map { key in
                return (key, groupedExpenses[key]!)
            })
            
            print("groupedExpenses.count \(groupedExpenses.count)")
            
        case .category:
            // Group by category
            for expense in dataSources {
                let category = expense.category

                if var expensesForCategory = groupedExpenses[category] {
                    expensesForCategory.append(expense)
                    groupedExpenses[category] = expensesForCategory
                } else {
                    groupedExpenses[category] = [expense]
                }
            }
            // Sort the section keys (categories) alphabetically
            let sortedKeys = groupedExpenses.keys.sorted()
            groupedExpenses = Dictionary(uniqueKeysWithValues: sortedKeys.map { key in
                return (key, groupedExpenses[key]!)
            })
            print("groupedExpenses.count \(groupedExpenses.count)")
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
        let sectionKey = Array(groupedExpenses.keys)[indexPath.section]
        
        if let expensesForSection = groupedExpenses[sectionKey] {
            let selectedExpense = expensesForSection[indexPath.row]
            
            print("Selected Expense: \(selectedExpense)")
            let alert = SettingView.instanceFromNib()
            alert.editExpense = selectedExpense
            alert.show(typeView: .kExpense, vm_ : self.vm, self) { (isRefresh) in
                if let isRefresh = isRefresh{
                    if isRefresh{
                        self.callAPI()
                    }
                }
                
            }
            
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return groupedExpenses.keys.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sectionKey = Array(groupedExpenses.keys)[section]
        return groupedExpenses[sectionKey]?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return Array(groupedExpenses.keys)[section]
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withClass: ExpenseTBCell.self)
        let sectionKey = Array(groupedExpenses.keys)[indexPath.section]
        
        if let expensesForSection = groupedExpenses[sectionKey] {
            let expense = expensesForSection[indexPath.row]
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
                                    if let sectionIndex = self.groupedExpenses.keys.firstIndex(of: sectionKey) {
                                        let sectionKey = self.groupedExpenses.keys[sectionIndex]
                                        if var expensesForSection = self.groupedExpenses[sectionKey] {
                                            expensesForSection.remove(at: indexPath.row)
                                            self.groupedExpenses[sectionKey] = expensesForSection
                                            tableView.deleteRows(at: [indexPath], with: .fade)
                                            self.dataSources = self.dataSources.filter{$0.id != expense.id}
                                        }
                                    }
                                }
                            }
                        }
                    })
                }
            }
        }
        
        return cell
    }

    
}

