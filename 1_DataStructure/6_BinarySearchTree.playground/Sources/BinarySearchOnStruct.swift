import Foundation

/**
 BST 구현을 구조체로 하고 내부 root을 Node로 지정해서 연결하는 방식을 사용함..
 */
public struct BinarySearchTree<Element: Comparable> {
    public private(set) var root: BinaryNode<Element>?
    public init() {}
}

/// Helper: 트리 수형도
extension BinarySearchTree: CustomStringConvertible {
    public var description: String {
        return root?.description ?? "empty tree"
    }
}

/**
 데이터 추가
 */
extension BinarySearchTree {
    /**
     해당 함수는 사용자 인터페이스로 공개되는 함수이고, 내부적으로는 다른 함수의 재귀적인 실행에 의해서 값이 추가 됨
     */
    public mutating func insert(_ value: Element) {
        root = insert(from: root, value: value)
        
    }
    
    /**
     
     */
    private mutating func insert(from node: BinaryNode<Element>?, value: Element) -> BinaryNode<Element> {
        // root에 값이 없는 경우에 값을 추가한 경우에는 root의 값을 추가한다.
        // 혹은 아래의 if, else 구문에서 left,right 자식 노드에 추가될때 호출됨.
        guard let node = node else { return BinaryNode<Element>(value: value)}
        
        // 추가한 값이, 해당 node의 값보다 작으면 해당 노드의 왼쪽 자식 노드에
        if value < node.value {
            node.leftChild = insert(from: node.leftChild, value: value)
        } else {
            node.rightChild = insert(from: node.rightChild, value: value)
        }
        
        /// 트리 안에 같은 값이 들어가면 구분을 어떻게 해야할지 애매해짐.. 이래서 Key, Value 쓰는건가..
        //        print("해당 사항 없음 현재 노드의 값: \(node.value), 추가한 값: Value: \(value)")
        //        debugPrint(node)
        // 만약 같은 값을 계속해서 추가하게되면, 해당 Node를 그대로 반환
        return node
    }
}



extension BinarySearchTree {
    /**
     내부에 값이 있는지 확인합니다. 값을 확인할때 traverseInOrder를 사용합니다.
     */
    //    public func contains(_ value: Element) -> Bool {
    //        guard let root = root else { return false }
    //        var found = false
    //
    //        /// 내가 찾으려고 하는 값이, traverse를 통해서 찾아지는 값들과 대조하여, 값이 존재하면 value 반환 이때 찾으려는 값이 없는 경우 최악의 케이스는 O(n) 이유는 traverse는 모든값들을 순회하기 때문이다.
    //        root.traverseInOrder {
    //            if $0 == value { found = true }
    //        }
    //        return found
    //    }
    
    public func contains(_ value: Element) -> Bool {
        // 1
        var current = root
        // 2
        while let node = current {
            print(current?.value)
            // 3
            if node.value == value {
                return true
            }
            // 4
            if value < node.value {
                current = node.leftChild
            } else {
                current = node.rightChild
            }
        }
        return false
    }
}

/// Remove
private extension BinaryNode {
    // 재귀적으로 해당 노드를 기준으로 가장 작은값 반환, 만약 nil 이라면, 현재의 자기 자신 노드 반환
    var min: BinaryNode {
        return leftChild?.min ?? self
    }
}

extension BinarySearchTree {
    public mutating func remove(_ value: Element) {
        root = remove(node: root, value: value)
    }
    
    /**
     실제 remove의 로직 함수,
     */
    private mutating func remove(node: BinaryNode<Element>?, value: Element) -> BinaryNode<Element>? {
        guard let node = node else { return nil }
        /**
         1. 지우려고 하는 값이, 현재 node의 값과 같은 경우
         - 여기에서 지울수 있는 케이스가 3가지가 나옴
         2. 지우려고 하는 값이, 현재 node의 값보다 작은 경우
         - 현재 node의 왼쪽 자식 노드로 remove 재귀적으로 실행
         3. 지우려고 하는 값이, 현재 node의 값보다 큰 경우
         - 현재 node의 오른쪽 자식 노드로 remove 재귀적으로 실행
         */
        if value == node.value {
            // more to come
            /// 단말 노드인 경우(= 자식 노드 X) -> nil을 반환하여 해당 BinaryNode를 nil로 만들어주어서, 레퍼런스 카운트를 지운다.
            if node.leftChild == nil && node.rightChild == nil { return nil }
            
            /// 왼쪽 자식 노드가 없는 경우, 현재의 해당 node를(이때 노드 독립적으로 가리키는게 아니라, 부모노드의 왼쪽 혹은 오른쪽 으로 가리켜져 있음) 지우려고 하는 노드의 오른쪽 노드를 할당해줌, 부모 노드를 지우고 새로 할당하고 할 필요가 없어짐..
            if node.leftChild == nil { return node.rightChild }
            if node.rightChild == nil { return node.leftChild }
            
            /// 지우려고 하는 노드가 두개의 자식 노드를 가지고 있는 경우
            /// 현재 노드의 값을, 해당 노드의 오른쪽 서브 트리중에서 가장 작은 값으로 대체하고
            node.value = node.rightChild!.min.value
            // 값을 변경하고, 변경한 값을 가지고 있는 Node를 교체하기 위해서 rightChild를 오른쪽 트리의 가장 최솟값으로 remove 재귀호출함..
            node.rightChild = remove(node: node.rightChild, value: node.value)
        }else if value < node.value {
            node.leftChild = remove(node: node.leftChild, value: value)
            
        }else {
            node.rightChild = remove(node: node.rightChild, value: value)
        }
        
        return node
    }
}
