//
//  NewDogVC.swift
//  DowaDog
//
//  Created by 조윤영 on 31/12/2018.
//  Copyright © 2018 wookeon. All rights reserved.
//

import UIKit

class NewDogVC: UIViewController {
    
    var storyDogList = [EmergenDog]()
    
    @IBOutlet weak var navbar: UINavigationItem!
    @IBOutlet weak var collectionView: UICollectionView!
    var reuseIdentifier = "newdogCell"
    var testImg = [(UIImage(named: "testcat.png")),
                   (UIImage(named: "testcat.png")), (UIImage(named: "testcat.png")), (UIImage(named: "testcat.png")),(UIImage(named: "testcat.png")),(UIImage(named: "testcat.png")),(UIImage(named: "testcat.png")),(UIImage(named: "testcat.png")),(UIImage(named: "testcat.png"))
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
        
        navbar.title = "제 이야기를 들어보실래요?"
        
        self.setBackBtn()
        self.setNavigationBarShadow()
    }
    
    override func viewWillAppear(_ animated: Bool) {

        EmergenDogService.shared.findAnimalList(type: "", region: "", remainNoticeDate: 300, story: true, searchWord: "", page: 0, limit: 10) {
            (data) in
            
            self.storyDogList = data
            
            
        }
    }

}

extension NewDogVC:UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return storyDogList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! NewDogDetailCVCell
        
        let storyDog = storyDogList[indexPath.item]
        
       
        cell.animalImage.imageFromUrl(gsno(storyDog.thumbnailImg), defaultImgPath: "")
        
        
        
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd"
        
            let getDate = gsno(storyDog.noticeEddt)//마감날짜
            var strArray: Array<String> = []
            strArray =  getDate.components(separatedBy:"-")
        
            let endDate  = strArray[2]
        
            let cal = Calendar.current
            let date = Date()
            let currentDate = cal.component(.day, from: date)
        
        
            //
            let dday = Int(endDate) ?? Int() - Int(currentDate)
            let Dday = "D-\(dday)"
            //현재 날짜(currentData)가 분명 int값인데 계산에 먹히지를 않음
        
            //하단에 들어가는 해당 동물 지역과 종
            let region = gsno(storyDog.region)
            let kind = gsno(storyDog.kindCd)
        
            cell.animalImage.imageFromUrl(self.gsno(storyDog.thumbnailImg)   , defaultImgPath: "")
            cell.aboutLabel.text = "[\(region)]\(kind)"
        
            cell.dayLabel.text = Dday
        
            //강아지인지 고양이인지 판단
            if storyDog.type == "개"{
                cell.kindImage.image = UIImage(named: "dogIcon1227")
            }else if storyDog.type == "고양이" {
                cell.kindImage.image = UIImage(named: "catIcon1227")
            }
            //암컷 수컷 판단
            if storyDog.sexCd == "F" {
                cell.genderImage.image = UIImage(named: "womanIcon1227")
            }
            else if storyDog.sexCd == "M" {
                cell.genderImage.image = UIImage(named: "manIcon1227")
            }
        
        
            //하트 클릭여부 판단
            cell.heartBtn.setImage(UIImage(named: "findingHeartBtnFill.png"), for: .selected)
            cell.heartBtn.setImage(UIImage(named:"heartBtn"), for: .normal)
            if storyDog.liked == false{
                
                cell.heartBtn.isSelected = true
                
            }else if storyDog.liked == true{
                
                cell.heartBtn.isSelected = false
                
            }
        
        
        return cell
    }
    
}

extension NewDogVC: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let cell = self.collectionView.cellForItem(at: indexPath) as!NewDogDetailCVCell

        //story있는 상세 정보로 넘어가는 부분
            if let dvc = storyboard?.instantiateViewController(withIdentifier: "AboutNewDogVC") as? AboutNewDogVC {
                
                let storyDog = storyDogList[indexPath.item]
                
                dvc.id = gino(storyDog.id)

                //네비게이션 컨트롤러를 이용하여 push를 해줍니다.
                navigationController?.pushViewController(dvc, animated: true)
            
        }
        
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        
        
    }
}

extension NewDogVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width: CGFloat = (view.frame.width - 45) / 2
        let height: CGFloat = (view.frame.width - 30) / 2 + 15
        
        //TODO: 이미지 사이즈도 view에 맞춰 동적으로 변경
        
        
        
        return CGSize(width: width, height: height)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    
}


