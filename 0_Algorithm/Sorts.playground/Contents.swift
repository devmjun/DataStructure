//: Playground - noun: a place where people can play

import UIKit

example(of: "Bubble Sort") {
    print(bubbleSort(data: createRandomArray(numberOfElements:10)))
}

example(of: "Selection Sort") {
    
    let x = createRandomArray(numberOfElements: 16)
    print(selectionSort(data: x))
}

example(of: "Insertion Sort") {
    let x = createRandomArray(numberOfElements: 16)
    print(insertionSort(data:x))
    
    //insertionSortClosure(data: x) { $0 > $1 }
    
}

example(of: "Merge Sort") {
    let x = createRandomArray(numberOfElements: 10)
    print(mergeSort(data:x))
}

example(of: "Quick Sort") {
    let x = createRandomArray(numberOfElements: 10)
    quicksort(x)
}
