import Foundation

/**
 1. 정렬이 된곳과, 되지 않는 곳 2공간을 비교하며 정렬합니다.
 2. temp에 비교할 현재 값을 넣어두고, 아래로 내려가며 현재값보다 크거나 작은 값이 나올때까지 다른값들을 변경하여
 3. 비교대상할 값보다 작은 값이 나오면 반복문을 나온후, 해당 값을 반복할때 변경한 인덱스를 이용하여 값을 바꾸어줌.
 */
public func insertionSort<T: Comparable>(data: [T]) -> [T] {
    var targetData = data
    for index in 1..<targetData.count {
        var innerIndex = index
        let temp = targetData[innerIndex]
        while innerIndex > 0 && targetData[innerIndex-1] > temp {
            print("index: \(index), innerIndex: \(innerIndex), temp, temp-1:  \(targetData[innerIndex]):\(targetData[innerIndex-1]) targetData:\(targetData)")
            targetData[innerIndex] = targetData[innerIndex-1]
            print("index: \(index), innerIndex: \(innerIndex), temp, temp-1:  \(targetData[innerIndex]):\(targetData[innerIndex-1]) targetData:\(targetData)")
            innerIndex -= 1
            
        }
        targetData[innerIndex] = temp
        print("index: \(index), innerIndex: \(innerIndex), targetData:\(targetData)")
        
    }
    return targetData
}

public func insertionSortClosure<T:Comparable>(data: [T], isOrderedBefore: (T, T) -> Bool) -> [T] {
    var targetData = data
    var counter: Int = 0
    for index in 1..<targetData.count {
        counter += 1
        var innerIndex = index
        let temp = targetData[innerIndex]
        while innerIndex > 0 && targetData[innerIndex-1] > temp {
            //            while innerIndex > 0 && isOrderedBefore(temp, targetData[innerIndex - 1]) {
            
            print("index: \(index), innerIndex: \(innerIndex), temp, temp-1:  \(targetData[innerIndex]):\(targetData[innerIndex-1]) targetData:\(targetData)")
            targetData[innerIndex] = targetData[innerIndex-1]
            print("index: \(index), innerIndex: \(innerIndex), temp, temp-1:  \(targetData[innerIndex]):\(targetData[innerIndex-1]) targetData:\(targetData)")
            innerIndex -= 1
            counter += 1
        }
        
        targetData[innerIndex] = temp
        print("index: \(index), innerIndex: \(innerIndex), targetData:\(targetData)")
        
    }
    
    print("총 카운터 \(counter)")
    return targetData
}
