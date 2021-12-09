//
//  Assigmenttictac.swift
//  Tic
//
//  Created by DCS on 09/12/21.
//  Copyright © 2021 DCS. All rights reserved.
//

import UIKit

class Assigmenttictac: UIViewController {

    
        
        private var state = [2,2,2,2,
                             2,2,2,2,
                             2,2,2,2,
                             2,2,2,2]
        private let myLabel1: UILabel = {
            var label = UILabel()
            //label.backgroundColor = .gray
            label.text = "Player 1 = X"
            label.textColor = .red
            return label
        }()
        private let myLabel2: UILabel = {
            var label = UILabel()
            //label.backgroundColor = .gray
            label.text = "Player 2 = 0"
            label.textColor = .red
            return label
        }()
        private let myLabel: UILabel = {
            var label = UILabel()
            //label.backgroundColor = .gray
            label.text = ""
            label.textColor = .green
            return label
        }()
        
        
        
        private let winningCombinations = [[0,1,2,3], [4,5,6,7], [8,9,10,11], [12,13,14,15], [0,4,8,12], [1,5,9,3], [2,6,10,14], [3,7,11,15], [0,5,10,15], [3,6,9,12]]
        
        private var zeroflage = false
        
        private let myCollectionView:UICollectionView = {
            let layout = UICollectionViewFlowLayout()
            layout.sectionInset = UIEdgeInsets(top: 120, left: 20, bottom: 20, right: 20)
            layout.itemSize = CGSize(width: 75, height: 75)
            
            
            let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
            collectionView.backgroundColor = .white
            return collectionView
        }()
        
        override func viewDidLoad() {
            super.viewDidLoad()
            view.addSubview(myCollectionView)
            view.addSubview(myLabel1)
            view.addSubview(myLabel2)
            
            view.addSubview(myLabel)
            setUpCollectionView()
            
            
        }
        override func viewDidLayoutSubviews() {
            super.viewDidLayoutSubviews()
            myCollectionView.frame = view.bounds
            myLabel1.frame = CGRect(x: 40, y: 30, width: view.width, height: 30)
            myLabel2.frame = CGRect(x: 40, y: 65, width: view.width, height: 30)
            //myCollectionView.frame = CGRect(x: 0, y: 50, width: view.width, height: 20)
            
            myLabel.frame = CGRect(x: 125, y: 500, width: view.width-80, height: 40 )
            
        }
        
        
        
    }
    
    extension Assigmenttictac : UICollectionViewDataSource,UICollectionViewDelegate{
        
        private func setUpCollectionView() {
            myCollectionView.dataSource = self
            myCollectionView.delegate = self
            myCollectionView.register(T3Cell.self, forCellWithReuseIdentifier: "T3Cell")
        }
        
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return state.count
        }
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "T3Cell", for: indexPath) as! T3Cell
            cell.setupCell(with :state[indexPath.row])
            return cell
        }
        func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            if state[indexPath.row] != 0 && state[indexPath.row] != 1{
                
                state.remove(at: indexPath.row)
                
                if zeroflage{
                    state.insert(0, at: indexPath.row)
                    myLabel.text = "Player 1 turn"
                    
                    //zeroflage = 1
                }
                else{
                    state.insert(1, at: indexPath.row)
                    myLabel.text = "Player 2 turn"
                    //zeroflage = 0
                }
                zeroflage = !zeroflage
                collectionView.reloadSections(IndexSet(integer: 0))
                CheckWin()
            }
        }
        private func CheckWin(){
            if (!state.contains(2)){
                resetdata()
                print("Draw")
            }
            else{
                for i in winningCombinations{
                    if state[ i[0] ] == state[ i[1]] && state[ i[1] ] == state[ i[2]] && state[ i[2] ] == state[ i[3]] && state[i[0]] != 2{
                        resetdata()
                        print("\(state[ i[0] ]) won")
                        myLabel.text = "\(state[ i[0] ]) won"
                        //_ = UIAlertController(title: "Winner", message: "\(state[ i[0] ]) won", preferredStyle: .alert)
                        //alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel)
                        
                        resetdata()
                        break
                    }
                }
            }
        }
        private func resetdata(){
            state = [2,2,2,2,
                     2,2,2,2,
                     2,2,2,2]
            zeroflage = false
            myCollectionView.reloadData()
            myCollectionView.reloadSections(IndexSet(integer: 0))
            
        }
        
    
    


}
