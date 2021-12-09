//
//  TicTacToe.swift
//  Tic
//
//  Created by DCS on 26/11/21.
//  Copyright © 2021 DCS. All rights reserved.
//

import UIKit

class TicTacToe: UIViewController {
    private var state = [2,2,2,2,
                         2,2,2,2,
                         2,2,2,2,
                         2,2,2,2]
    private let winningcombination = [[0,1,2,3], [4,5,6,7], [8,9,10,11], [12,13,14,15], [0,4,8,12], [1,5,9,3], [2,6,10,14], [3,7,11,15], [0,5,10,15], [3,6,9,12]]
    private let myLabel1: UILabel = {
        var label = UILabel()
        //label.backgroundColor = .gray
        label.text = "Player 1 = X"
        label.textColor = .blue
        return label
    }()
    private let myLabel2: UILabel = {
        var label = UILabel()
        //label.backgroundColor = .gray
        label.text = "Player 2 = 0"
        label.textColor = .blue
        return label
    }()
    private let myLabel: UILabel = {
        var label = UILabel()
        label.backgroundColor = .gray
        label.text = ""
        label.textColor = .black
        return label
    }()
    private var zeroflag = false
    private let myCollectionView:UICollectionView =
    {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 120, left: 20, bottom: 20, right: 20)
        layout.itemSize = CGSize(width: 75, height: 75)
        
        let collectionview = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionview.backgroundColor = .white
        return collectionview
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(myCollectionView)
        setupCollectionView()
        view.addSubview(myLabel1)
        view.addSubview(myLabel2)
        
        view.addSubview(myLabel)
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        myCollectionView.frame = view.bounds
        myLabel1.frame = CGRect(x: 40, y: 30, width: view.width, height: 30)
        myLabel2.frame = CGRect(x: 40, y: 65, width: view.width, height: 30)
        //myCollectionView.frame = CGRect(x: 0, y: 50, width: view.width, height: 20)
        
        myLabel.frame = CGRect(x: 125, y: 500, width: 100, height: 40 )
    }
}
extension TicTacToe:UICollectionViewDelegate,UICollectionViewDataSource
{
    private func setupCollectionView()
    {
        myCollectionView.delegate = self
        myCollectionView.dataSource = self
        myCollectionView.register(T3Cell.self, forCellWithReuseIdentifier: "T3Cell")
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       return 16
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "T3Cell", for: indexPath) as! T3Cell
        cell.setupCell(with : state[indexPath.row])
        return cell
    
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if(state[indexPath.row] != 0 && state[indexPath.row] != 1)
        {
            state.remove(at: indexPath.row)
            if(zeroflag)
            {
                state.insert(0, at: indexPath.row)
                 myLabel.text = "Player 1 turn"            }
            else
            {
                state.insert(1, at: indexPath.row)
                 myLabel.text = "Player 2 turn"            }
            zeroflag = !zeroflag
            collectionView.reloadData()
            collectionView.reloadSections(IndexSet(integer : 0))
           checkWinner()
        }
    }
    func checkWinner()
    {
     if !state .contains(2)
     {
        print("Draw")
    }
        else
     {
        for i in winningcombination
        {
            if state [ i[0] ] == state [ i[1] ] &&  state[ i[1] ] == state[ i[2] ] && state[ i[2]] == state[ i[3]]  && state [ i[0] ] != 2{
                print("\(state[ i[0] ]) won")
                myLabel.text = "\(state[ i[0] ]) won"
                myLabel.backgroundColor = .white
                myLabel.textColor = .red
                reset()
                
                						
                    
                }
        }
    }
       
}
        func reset()
        {
            state = [2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2]
            zeroflag = false
            myCollectionView.reloadData()
            myCollectionView.reloadSections(IndexSet(integer : 0))        }

}
