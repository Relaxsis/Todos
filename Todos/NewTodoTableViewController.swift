//
//  NewTodoTableViewController.swift
//  Todos
//
//  Created by Admin on 14.07.15.
//  Copyright (c) 2015 Admin. All rights reserved.
//

import UIKit
import Alamofire

class NewTodoTableViewController: UITableViewController {

    var projectid : Int?
    var projects:[Project] = []
    var created = false
    var myIndexPath:NSIndexPath?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    
    
    
    @IBAction func backToIndex(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func createTodo(sender: AnyObject) {
        var textCell = tableView.cellForRowAtIndexPath(myIndexPath!)! as! DotextFieldTableViewCell
        var inputText = textCell.textField.text
        var selectedProject = tableView.indexPathForSelectedRow()
        //if inputText == "" {println("!!!!")}
        //println(inputText)
        if selectedProject != nil && inputText != "" {
         var cell:UITableViewCell = (tableView.cellForRowAtIndexPath(selectedProject!) as UITableViewCell!)!
         var id = 0
         if cell.textLabel?.text == "Семья" {
             println("!!!")
             id = 1
         }
         if cell.textLabel?.text == "Работа" {
             id = 2
             println("rabota")
         }
         if cell.textLabel?.text == "Прочее" {
             id = 3
             println("asdaqeqwe")
         }
         let parameters = [
             "todo": [
                 "dotext": inputText,
                 "project_id": id
             ],
             "format": "json"
         ]
         
         
         Alamofire.request(.POST, "https://msrylkin.herokuapp.com/", parameters: parameters)
         self.dismissViewControllerAnimated(true, completion: nil)
         self.tableView.reloadData()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 2
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        if section == 0 {
            return 1
        } else {
            return 3
        }
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell : UITableViewCell
        if indexPath.row==0 && !created{
            cell = tableView.dequeueReusableCellWithIdentifier("DotextField", forIndexPath: indexPath) as! DotextFieldTableViewCell
            created = true
            myIndexPath = indexPath
        }

        else
        {
            cell = tableView.dequeueReusableCellWithIdentifier("SelectProject", forIndexPath: indexPath) as! UITableViewCell
            cell.textLabel?.text = self.projects[indexPath.row].projname
        }
        
        return cell
    }

    
    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        var view = UIView()
        var label = UILabel(frame: CGRectMake(17,10,tableView.frame.size.width/2, 20))
        if section == 0 {
            label.text = "Задача" }
        else {
            label.text = "Категория"
        }
        label.font = UIFont.boldSystemFontOfSize(12.0)
        let views = ["label": label,"view": view]
        view.addSubview(label)
        view.backgroundColor = AppDelegate.UIColorFromRGB(0xD4D4D4)
        return view
    }
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40;
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 47;
    }

    override func tableView(tableView: UITableView, didHighlightRowAtIndexPath indexPath: NSIndexPath) {
        let selectedCell:UITableViewCell = tableView.cellForRowAtIndexPath(indexPath)!
        selectedCell.backgroundColor = UIColor.whiteColor()
        if !selectedCell.isKindOfClass(DotextFieldTableViewCell){
        for i in 0...tableView.numberOfSections()-1{
            for j in 0...tableView.numberOfRowsInSection(i)-1{
                if let resetcell = tableView.cellForRowAtIndexPath(NSIndexPath(forRow: j, inSection: i)) {
                    resetcell.accessoryType = .None
                }
            }
        }
        if selectedCell.accessoryType == UITableViewCellAccessoryType.None{
            selectedCell.accessoryType = UITableViewCellAccessoryType.Checkmark} else {
            selectedCell.accessoryType = UITableViewCellAccessoryType.None
        }
        }
    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
