//
//  AddFlightTableViewController.swift
//  UserInputDemo
//
//  Created by Danylo Kushlianskyi on 07.06.2022.
//

import UIKit

class AddFlightTableViewController: UITableViewController {
    @IBOutlet weak var firstNameField: UITextField!
    @IBOutlet weak var lastNameField: UITextField!
    @IBOutlet weak var frequentFlyer: UITextField!
    @IBOutlet weak var departureDateLabel: UILabel!
    @IBOutlet weak var departurePicker: UIDatePicker!
    @IBOutlet weak var returnPicker: UIDatePicker!
    @IBOutlet weak var returnDateLabel: UILabel!
    @IBOutlet weak var numberOfChilderLabel: UILabel!
    @IBOutlet weak var numberOfAdultsLabel: UILabel!
    @IBOutlet weak var numberOfAdultsStepper: UIStepper!
    @IBOutlet weak var numberOfChildrenStepper: UIStepper!
    @IBOutlet weak var someSwitch: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let midnightToday = Calendar.current.startOfDay(for: Date())
        departurePicker.minimumDate = midnightToday
        updateDateViews()
        updateNumberOfPassengers()
        

       
    }

    @IBAction func donePressed(_ sender: Any) {
        let firstName = firstNameField.text ?? ""
        let lastName = lastNameField.text ?? ""
        let frequentFlyer = frequentFlyer.text ?? ""
        let departureDate = departurePicker.date
        let returnDate = returnPicker.date
        let numberOfAdults = "\(Int(numberOfAdultsStepper.value))"
        let numberOfChildren = "\(Int(numberOfChildrenStepper.value))"
        let hasMeals = someSwitch.isOn
        print(firstName, lastName, frequentFlyer, departureDate, returnDate, numberOfAdults, numberOfChildren, hasMeals)
        
        let alertController = UIAlertController(title: "Confirmation", message: "Confirm your booking", preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .default, handler: {[weak self] action in
            let newAlert = UIAlertController(title: "Confirmed", message: "✅\nFirst Name: \(firstName)\nLast Name: \(lastName)\nFrequent Flyer: \(frequentFlyer)\nDeparture Date: \(departureDate)\nReturn Date: \(returnDate)\nNumber of adults: \(numberOfAdults)\nNumber of children: \(numberOfChildren)\nHave meal: \(hasMeals)", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            newAlert.addAction(okAction)
            self?.present(newAlert, animated: true, completion: nil)
        })
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func switchTriggered(_ sender: Any) {
        print("Switch triggered")
    }
    
    func updateDateViews(){
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        returnPicker.minimumDate = departurePicker.date.addingTimeInterval(86400)
        
        departureDateLabel.text = dateFormatter.string(for: departurePicker.date)
        
        returnDateLabel.text = dateFormatter.string(for: returnPicker.date)
    }
    func updateNumberOfPassengers(){
        numberOfAdultsLabel.text = "\(Int(numberOfAdultsStepper.value))"
        numberOfChilderLabel.text = "\(Int(numberOfChildrenStepper.value))"
    }
    
    @IBAction func stepperValueChanged(_ sender: Any){
        updateNumberOfPassengers()
    }
    
    @IBAction func departureDateChosen(_ sender: Any) {
        updateDateViews()
    }
    
    @IBAction func returnDateChosen(_ sender: Any) {
        updateDateViews()
    }
    
    let departurePickerIndex = IndexPath(row: 1, section: 1)
    let returnPickerIndex = IndexPath(row: 3, section: 1)
    
    var isDepartureShown: Bool = false {
        didSet{
            departurePicker.isHidden = !isDepartureShown
        }
    }
    
    var isReturnShown: Bool = false {
        didSet{
            returnPicker.isHidden = !isReturnShown
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath {
        case departurePickerIndex:
            if isDepartureShown {
                return 216.0
            }
            else {return 0}
        case returnPickerIndex:
            if isReturnShown {
                return 216.0
            }
            else {return 0}
        default:
            return 44.0
        }
    }
    
    let departureLabelIndex = IndexPath(row: 0, section: 1)
    let returnLabelIndex = IndexPath(row: 2, section: 1)
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath {
        case departureLabelIndex:
            if isDepartureShown {
                isDepartureShown = false
            }
            else if isReturnShown{
                isDepartureShown = false
                isReturnShown = false
            }
            else {
                isDepartureShown = true
            
            }
            tableView.beginUpdates()
            tableView.endUpdates()
        case returnLabelIndex:
            if isReturnShown {
                isReturnShown = false
            }
            else if isDepartureShown {
                isDepartureShown = false
                isReturnShown = true
            }
            else {
                isReturnShown = true
            }
            tableView.beginUpdates()
            tableView.endUpdates()
        default:
            break
            
        }
      

    }
    // MARK: - Table view data source

//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 0
//    }
//
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        // #warning Incomplete implementation, return the number of rows
//        return 0
//    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
