//
//  Page2VC.swift
//  DowaDog
//
//  Created by 조윤영 on 02/01/2019.
//  Copyright © 2019 wookeon. All rights reserved.
//

import UIKit

class Page2VC: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    var reuseIdentifier = "Page2CVCell"

    
    var knowledgeList = [Education]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        EducationListService.shared.getKnowledgeList(page: 0, limit: 10) { [weak self]
            (data) in
            guard let `self` = self else {return}
            
            
            print("knowledge==============================")
            print("data: ")
            print(data)
            print("knowledge==============================")
            
            
            self.knowledgeList = data
            
            self.collectionView.reloadData()
        }
    }
}

extension Page2VC:UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return knowledgeList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! Page2CVCell
        
        let knowledge = knowledgeList[indexPath.row]
        cell.cardImage.imageFromUrl(gsno(knowledge.imgPath), defaultImgPath: "")
        
        return cell
    }
    
}

extension Page2VC: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let cell = self.collectionView.cellForItem(at: indexPath) as!Page2CVCell
        
        if let dvc = storyboard?.instantiateViewController(withIdentifier: "CardVC") as? CardVC {
            
            //네비게이션 컨트롤러를 이용하여 push를 해줍니다.
            navigationController?.pushViewController(dvc, animated: true)
        }
        
        
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        
        
    }
}

extension Page2VC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width: CGFloat = view.frame.width - 54
        let height: CGFloat = view.frame.height - 121
        
        
        
        
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 28
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 28, left: 28, bottom: 10, right: 28)
    }
    
}


