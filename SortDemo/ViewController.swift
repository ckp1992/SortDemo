//
//  ViewController.swift
//  SortDemo
//
//  Created by 陈鲲鹏 on 15/4/15.
//  Copyright (c) 2015年 陈鲲鹏. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var array = [Int]()//[7,5,3,1,11,6,9,2,10,8,4]//
    
    override func viewDidLoad() {
        super.viewDidLoad()

        var count = 100000
        for var i = 0;i < count ;i++ {
            array.append(random() - i)//.insert(1000000 - i, atIndex: i)
        }
//        println(self.array)
        var start = NSDate()
        quickSort(0,right: array.count-1)
//        mergeSort(array)
//        shellSort()
//        insertionSort()
        var time = NSDate().timeIntervalSinceDate(start)
        println(time)
//        println(self.array)
    }
    
    //快速排序
    func quickSort(left:Int,right:Int){
        
        //递归出口，当区间已经小于1了就不排序了
        if left >= right {
            return
        }
//        println("pre：\(self.array)")
//        println("left:\(self.array[left]),right:\(self.array[right])")
        
        //选取基点pivot，取基点为每个分区的最后一个数
       
        var pivotIndex = right
        var pivot = self.array[pivotIndex]    //取最右面的作为基点
        var storeIndex = left           //基点最后将要存储的位置变量，初始化为左边界
        
        //把基点值移动到最右面(如果取最有为基点这个交换可以不写)
        var temp = array[right]
        array[right] = array[pivotIndex]
        array[pivotIndex] = temp
        
        
        //分治，对每个区间进行排序
        for i in left..<right {
            if array[i] <= pivot {  //交换开始，把小于或者等于pivot的数都移到基点最后要存储位置的左边
                var temp = array[storeIndex]
                array[storeIndex] = array[i]
                array[i] = temp
                
                storeIndex++        //存储位置++,作为基点最后的位置
            }
        }
        
        //把放在最右面的基点移动到最后确定的中间的位置
        var temp1 = array[storeIndex]
        array[storeIndex] = array[right]
        array[right] = temp1
        
        //递归
//        println(self.array)
//        println("\n")
        
        quickSort(left, right: storeIndex-1)    //分治之后的左区间
        quickSort(storeIndex+1, right: right)
        
    }
    
    //归并排序
    func mergeSort(ary:[Int])->[Int]{
        
        if ary.count <= 1 {
            return ary
        }
        
        var mid = ary.count / 2
        
        var left = [Int]()
        var right = [Int]()
        
        for i in 0..<ary.count {
            if i < mid {
                left.append(ary[i])
            }else{
                right.append(ary[i])
            }
        }
        
        var leftToMerge = mergeSort(left)
        var rightToMerge = mergeSort(right)
        
//        println("left:\(left)")
//        println("right:\(right)")
        
        //进行合并
        var result = [Int]()
        var pL = 0 //左指针
        var pR = 0 //右指针
        
        while pL < leftToMerge.count && pR < rightToMerge.count {
            if leftToMerge[pL] < rightToMerge[pR] {
                result.append(leftToMerge[pL++])
            }else{
                result.append(rightToMerge[pR++])
            }
            
        }
        
        if pL < leftToMerge.count {
            for i in pL..<leftToMerge.count {
                result.append(leftToMerge[i])
            }
        }
        if pR < rightToMerge.count {
            for i in pR..<rightToMerge.count {
                result.append(rightToMerge[i])
            }
            
        }
        
        return result
    }
    
    //希尔排序
    func shellSort(){
        var inc = array.count / 2 //初始步长
        
        while inc > 0 {
            
            //插入排序
            for var i = inc; i < array.count ; i++ {
                var nowNum = array[i] //当前准备往前插入的数
                var index = i         //将要被插入的下标
                
                for var j = i - inc; j >= 0; j -= inc{
                    if array[j] > nowNum {
                        array[j+inc] = array[j]
                        index = j
                    }else{
                        break
                    }
                }
                array[index] = nowNum
            }

            inc = inc/2
        }
//        println(array)
    }
    
    //插入排序
    func insertionSort(){
        
        //从1开始，默认第0个已经排好序
        for var i = 1 ; i < array.count; i++ {
            
            var nowNum = array[i] //当前准备往前插入的数
            var index = i         //将要被插入的下标

            for var j = i - 1 ; j >= 0 ; j-- {  //从后往前扫描已排序的区域，插入
                if array[j] > nowNum {
                    array[j+1] = array[j]
                    index = j
                }else{
                    break
                }
            }
            
            array[index] = nowNum
            
        }
//        println(array)
    }
}

