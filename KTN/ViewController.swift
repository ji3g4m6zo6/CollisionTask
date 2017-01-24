//
//  ViewController.swift
//  KTN
//
//  Created by CuGi on 2017/1/24.
//  Copyright © 2017年 Cu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var squareView: UIView = UIView()
    var ballView: UIView = UIView()
    var nowDirection = Direction.右下
    var isClockwise = true //順時針
    
    enum Direction {
        case 右下
        case 左下
        case 左上
        case 右上
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        squareView = createSquareView(size: 350)
        self.view.addSubview(squareView)
        
        ballView = createBallView()
        self.view.addSubview(ballView)
        
        //如果是順時針就右下
        if isClockwise {
            nowDirection = Direction.右下
        }else{
            nowDirection = Direction.左上
        }
        
        moveBall()
    }
    
    func createSquareView(size: Int) -> UIView {
        
        let view = UIView.init(frame: CGRect(x: 0, y: 0, width: size, height: size))
        view.backgroundColor = UIColor.black
        return view
    }
    
    func createBallView() -> UIView {
        
        let view = UIView.init(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
        view.center = CGPoint(x: 350/2, y: 0 + view.frame.width / 2)
        view.backgroundColor = UIColor.white
        view.layer.cornerRadius = view.frame.size.width/2
        view.clipsToBounds = true
        view.layer.borderColor = UIColor.white.cgColor
        view.layer.borderWidth = 5.0
        return view
    }
    
    func moveBall() {
        let when = DispatchTime.now() + 0.01 // 延遲0.01秒
        DispatchQueue.main.asyncAfter(deadline: when) {
            let directionForMove = self.方向偏移()
            self.ballView.center = CGPoint(x: self.ballView.center.x + CGFloat(1 * directionForMove.0), y: self.ballView.center.y + CGFloat(1 * directionForMove.1))
            
            let ballViewX = self.ballView.center.x
            let ballViewY = self.ballView.center.y
            let ballViewWidth = self.ballView.frame.width
            let ballViewHeight = self.ballView.frame.height
            
            let squareViewWith = self.squareView.bounds.width
            let squareViewHeight = self.squareView.bounds.height
            
            //判斷是否碰到邊界
            if  ballViewX + ballViewWidth/2 >= squareViewWith {
                //判斷方向是否為順時針
                if self.isClockwise {
                    self.nowDirection = Direction.左下
                }else{
                    self.nowDirection = Direction.左上
                }
            }
            if  ballViewY + ballViewHeight/2 >= squareViewHeight {
                if self.isClockwise {
                    self.nowDirection = Direction.左上
                }else{
                    self.nowDirection = Direction.右上
                }
            }
            if  ballViewX - ballViewWidth/2 <= 0 {
                if self.isClockwise {
                    self.nowDirection = Direction.右上
                }else{
                    self.nowDirection = Direction.右下
                }
            }
            if  ballViewY - ballViewHeight/2 <= 0 {
                if self.isClockwise {
                    self.nowDirection = Direction.右下
                }else{
                    self.nowDirection = Direction.左下
                }
            }
            
            
            
            //遞迴
            self.moveBall()
        }
    }
    
    func 方向偏移() -> (Int,Int) {
        
        //斜率可以在這邊計算
        switch nowDirection {
        case .右下:
            return (1, 1)
        case .左下:
            return (-1, 1)
        case .左上:
            return (-1, -1)
        case .右上:
            return (1, -1)
        }
    }
    
    //移除上方Status Bar
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
}



