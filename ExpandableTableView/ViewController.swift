//  ViewController.swift
//  ExpandableTableView
//  Created by cyno on 10/18/18.
//  Copyright © 2018 cyno. All rights reserved.


import UIKit

struct cellData {
    var opened = Bool()
    var title = String()
    var subtitle = String()
    var sectionData : [String]?
    //var openString = "See More ▼"
    //var closeString = "See Less ▲"
}


class ViewController: UIViewController {
    
    var tableViewdata = [cellData]()
    @IBOutlet weak var tableViewOutlet: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    
        tableViewdata = [cellData(opened: false, title: "Title 1", subtitle: "", sectionData: []),
                         cellData(opened: false, title: "Title 2", subtitle: "SubTitle 1", sectionData: ["cell1", "cell2", "cell3"]),
                         cellData(opened: false, title: "Title 2", subtitle: "SubTitle 1", sectionData: ["cell1", "cell2", "cell3"]),
                         cellData(opened: false, title: "Title 2", subtitle: "SubTitle 1", sectionData: ["cell1", "cell2", "cell3"])
        ]
    
    }
}


extension ViewController : UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return tableViewdata.count
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableViewdata[section].opened == true {
            print(tableViewdata[section].sectionData!.count)
            if tableViewdata[section].sectionData!.count == 0 {
                if tableViewdata[section].subtitle == "" {
                    return 1
                } else {
                    return 2
                }
            } else {
                 return tableViewdata[section].sectionData!.count + 3
            }
            
           
        } else {
            
            if tableViewdata[section].sectionData!.count == 0 {
                if tableViewdata[section].subtitle == "" {
                    return 1
                } else {
                   return 2
                }
                
            } else {
                return 3
            }
            
        }
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
         let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewDataCell
        
        if indexPath.row == 0 {
            
            //let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewDataCell

            cell.titleLabelOutlet.text = tableViewdata[indexPath.section].title
            
            cell.title2LabelOutlet.isHidden = false
            cell.editButtonOutlet.isHidden = true
            cell.deleteButtonOutlet.isHidden = true
            
            return cell
            
        } else if indexPath.row == 1 {
            
            //let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewDataCell
            cell.titleLabelOutlet?.text = tableViewdata[indexPath.section].subtitle
            
            cell.title2LabelOutlet.isHidden = false
            cell.editButtonOutlet.isHidden = true
            cell.deleteButtonOutlet.isHidden = true
            return cell
            
        }
        
        else if indexPath.row == 2 && !tableViewdata[indexPath.section].opened {
            //let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewDataCell
            cell.titleLabelOutlet?.text = "See More ▼"
            
            cell.title2LabelOutlet.isHidden = false
            cell.editButtonOutlet.isHidden = true
            cell.deleteButtonOutlet.isHidden = true
            
            return cell
        }
        
        else {
            
            if indexPath.row ==  5 {
                
                //let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewDataCell
                
                cell.titleLabelOutlet?.text = "See Less ▲"
                cell.title2LabelOutlet.isHidden = true
                cell.editButtonOutlet.isHidden = false
                cell.deleteButtonOutlet.isHidden = false
                
                return cell
                
            } else {
                //let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewDataCell
                print(tableViewdata[indexPath.section].sectionData?.count)
                print(indexPath.row)
                
                
                if tableViewdata[indexPath.section].sectionData?.count == 0 {
                    return cell
                } else {
                    if let cellValue = tableViewdata[indexPath.section].sectionData?[indexPath.row - 2] {
                        
                        cell.titleLabelOutlet?.text = cellValue
                        cell.title2LabelOutlet.isHidden = false
                        cell.editButtonOutlet.isHidden = true
                        cell.deleteButtonOutlet.isHidden = true
                        
                    }
                    return cell
                }
                
            }
        }
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableViewdata[indexPath.section].opened == true {
            
            tableViewdata[indexPath.section].opened = false
            let section = IndexSet.init(integer: indexPath.section)
            tableView.reloadSections(section, with: .none)
            
        } else {
            
            tableViewdata[indexPath.section].opened = true
            let section = IndexSet.init(integer: indexPath.section)
            tableView.reloadSections(section, with: .none)
            
        }
    }
    
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        if (cell.responds(to: #selector(getter: UIView.tintColor))) {
            
            let cornerRadius: CGFloat = 5
            cell.backgroundColor = UIColor.clear
            let layer: CAShapeLayer  = CAShapeLayer()
            let pathRef: CGMutablePath  = CGMutablePath()
            let bounds: CGRect  = cell.bounds.insetBy(dx: 10, dy: 0)
            var addLine: Bool  = false
            
            if (indexPath.row == 0 && indexPath.row == tableView.numberOfRows(inSection: indexPath.section)-1) {
                pathRef.__addRoundedRect(transform: nil, rect: bounds, cornerWidth: cornerRadius, cornerHeight: cornerRadius)
            } else if (indexPath.row == 0) {
                pathRef.move(to: CGPoint(x:bounds.minX,y:bounds.maxY))
                pathRef.addArc(tangent1End: CGPoint(x:bounds.minX,y:bounds.minY), tangent2End: CGPoint(x:bounds.midX,y:bounds.minY), radius: cornerRadius)
                
                pathRef.addArc(tangent1End: CGPoint(x:bounds.maxX,y:bounds.minY), tangent2End: CGPoint(x:bounds.maxX,y:bounds.midY), radius: cornerRadius)
                pathRef.addLine(to: CGPoint(x:bounds.maxX,y:bounds.maxY))
                addLine = true;
            } else if (indexPath.row == tableView.numberOfRows(inSection: indexPath.section)-1) {
                
                pathRef.move(to: CGPoint(x:bounds.minX,y:bounds.minY))
                pathRef.addArc(tangent1End: CGPoint(x:bounds.minX,y:bounds.maxY), tangent2End: CGPoint(x:bounds.midX,y:bounds.maxY), radius: cornerRadius)
                pathRef.addArc(tangent1End: CGPoint(x:bounds.maxX,y:bounds.maxY), tangent2End: CGPoint(x:bounds.maxX,y:bounds.midY), radius: cornerRadius)
                pathRef.addLine(to: CGPoint(x:bounds.maxX,y:bounds.minY))
                
            } else {
                pathRef.addRect(bounds)
                addLine = true
            }
            
            layer.path = pathRef
            //CFRelease(pathRef)
            layer.strokeColor = UIColor.lightGray.cgColor;
            //set the border width
            layer.lineWidth = 1
            layer.fillColor = UIColor(white: 1, alpha: 1.0).cgColor
            
            if (addLine == true) {
                let lineLayer: CALayer = CALayer()
                let lineHeight: CGFloat  = (1 / UIScreen.main.scale)
                lineLayer.frame = CGRect(x:bounds.minX, y:bounds.size.height-lineHeight, width:bounds.size.width, height:lineHeight)
                lineLayer.backgroundColor = tableView.separatorColor!.cgColor
                layer.addSublayer(lineLayer)
            }
            
            let testView: UIView = UIView(frame:bounds)
            testView.layer.insertSublayer(layer, at: 0)
            testView.backgroundColor = UIColor.clear
            cell.backgroundView = testView
        }
        
    }
    
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10
    }
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
   
    
}
