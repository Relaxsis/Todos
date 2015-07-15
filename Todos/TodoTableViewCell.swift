//
//  TodoTableViewCell.swift
//  Todos
//
//  Created by Admin on 13.07.15.
//  Copyright (c) 2015 Admin. All rights reserved.
//

import UIKit
import Alamofire

class TodoTableViewCell: UITableViewCell {

    var todo:Todo?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    
    }

    
    @IBAction func checkboxClick(sender: AnyObject) {
        if checkbox.checkState.value == 0{
            self.todo?.isComplete = false
        } else {
            self.todo?.isComplete = true
        }
        

        let isc:Bool! = todo?.isComplete
        let id :Int! = todo?.id
        let url = "https://msrylkin.herokuapp.com/\(id)"
        //println(url)
        let parameters = [
            "todo": [
                "isComplete":isc
            ],
            "format": "json",
            "id":id
        ]
        
        
        Alamofire.request(Alamofire.Method.PUT, url, parameters: parameters as? [String : AnyObject])
        setState(self.todo!)
        
    }
    
    
    func setState(todo: Todo) {
        if (todo.isComplete == true){
            self.checkbox.checkState = M13CheckboxStateChecked
            var attrib = [NSStrikethroughStyleAttributeName : 1.0]
            self.checkbox.titleLabel.attributedText = NSAttributedString(string: todo.dotext, attributes: attrib)
        }else {
            self.checkbox.checkState = M13CheckboxStateUnchecked
            self.checkbox.titleLabel.text = todo.dotext
        }

    }
    
    
    func configureCell(todo: Todo) {
        self.todo = todo
        self.checkbox.titleLabel.text = todo.dotext
        self.checkbox.titleLabel.font = UIFont.systemFontOfSize(16.0)
        self.checkbox.checkAlignment = M13CheckboxAlignmentLeft
        self.checkbox.tintColor = AppDelegate.UIColorFromRGB(0x3AAFDA)
        self.checkbox.checkColor = UIColor.whiteColor()
        self.checkbox.radius = 0
        self.checkbox.strokeWidth = 0.5
        checkbox.getDefaultShape()
        setState(todo)
    }
    
    @IBOutlet weak var checkbox: M13Checkbox!
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
