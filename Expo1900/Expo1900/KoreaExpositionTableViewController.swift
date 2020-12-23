//
//  KoreaExposition.swift
//  Expo1900
//
//  Created by zdo on 2020/12/22.
//

import UIKit

class KoreaExpositionTableViewController: UITableViewController {
    var koreaItemList: [KoreaItem]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "한국의 출품작"
        
        let jsonAnalyzer = JSONAnalyzer()
        if let data = jsonAnalyzer.readFile(forName: "items", [KoreaItem].self) {
            koreaItemList = data
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let count = koreaItemList?.count else {
            return 0
        }
        return count
    }
    
    private func setCellData(_ cell: ExpositionTableViewCell, _ itemList: [KoreaItem], _ indexPath: IndexPath) {
        cell.assetImage.image = UIImage(named: itemList[indexPath.row].imageName)
        cell.titleLabel.text = itemList[indexPath.row].name
        cell.summaryLabel.text = itemList[indexPath.row].shortDescription
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ExpositionCell") as? ExpositionTableViewCell else {
            return UITableViewCell()
        }
        
        if let itemList = koreaItemList {
            setCellData(cell, itemList, indexPath)
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if let expositionDescriptionViewController = storyboard?.instantiateViewController(identifier: "ExpositionDescriptionViewController") as? ExpositionDescriptionViewController {
            setExpositionDesciprionViewControllerData(expositionDescriptionViewController, indexPath)
            navigationController?.pushViewController(expositionDescriptionViewController, animated: true)
        }
    }
    
    private func setExpositionDesciprionViewControllerData(_ expositionDescriptionViewController: ExpositionDescriptionViewController, _ indexPath: IndexPath) {
        if let itemList = koreaItemList {
            expositionDescriptionViewController.assetImageData = UIImage(named: itemList[indexPath.row].imageName)
            expositionDescriptionViewController.assetDescriptionData = itemList[indexPath.row].description
        }
    }
}
