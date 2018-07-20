import Foundation

/**
 bubbleSort는 예를들어서 데이터 개수가 10개이면 2개의 대상씩 비교를하는데, 10x10 비교 하지않고,
 1. 0 -> 0~9
 2. 1 -> 0~8
 3. 2 -> 0~7
 4. ....
 5. 8 -> 0
 
 어레이의 맨 마지막은, 인덱스를 1단계 낮춘부분에서 교환이 이루어지고, 어떤 대상이 비교되어지면서 있어야할 자리에 있게 되면, 그부분은 더이상 정렬하지 않음
 데이터의 길이가 10개이면 총 순회 횟수 9+8+7...0
 데이터 길이가 100개이면 총 순회 횟수 99+98+97...0
 */
public func bubbleSort<T: Comparable>(data: [T]) -> [T] {
    guard data.count > 1 else { return data }
    var totalCounter: Int = 0
    var targetData = data
    for i in 0..<(targetData.count-1) {
        for j in 0..<(targetData.count-i-1) {
            if targetData[j] > targetData[j+1] {
                print("i:\(i), j:\(j), 비교대상: \(data[j]) > \(data[j+1]), 정렬대상: \(data)")
                // 서로의 Index로 값 스왑∑
                targetData.swapAt(j, j+1)
                // Count up
                totalCounter += 1
            }
        }
    }
    print("총순회 횟수: \(totalCounter), 입력 데이터 길이\(data.count), 결과:\(data)")
    return targetData
}
