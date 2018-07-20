import Foundation

public class BinaryTreeNode<T: Comparable> {
    // 키값과 자식 노드를 위한 변수
    public var value: T
    public var leftChild: BinaryTreeNode?
    public var rightChild: BinaryTreeNode?
    public weak var parent: BinaryTreeNode?
    
    public init(value: T, left: BinaryTreeNode?, right: BinaryTreeNode?, parent: BinaryTreeNode?) {
        self.value = value
        self.leftChild = left
        self.rightChild = right
        self.parent = parent
    }
    
    public convenience init(value: T) {
        self.init(value: value, left: nil, right: nil, parent: nil)
    }
    
    public func insertNodeFromRoot(value: T) {
        if let _ = self.parent {
            // 부모 노드가 있따면 트리의 루트 노드가 아님
            print("You can only add new nodes from the root node of the tree!")
            return
        }
        self._addNode(value: value)
    }
    
    // 재귀적으로 각 노드들을 순회하면서, 노드를 넣을 곳을 찾는다.
    private func _addNode(value: T) {
        // 추가하려는 값이, Root 키값보다 작은 경우: 좌측 서브트리에 삽입
        if value < self.value {
            /*
             1. 노드가 존재하는 경우 좌측 서브트리에 삽입하고
             2. 노드가 없는 경우 새로운 노드를 만들어서 좌측 자식 노드로 삽입
             */
            if let leftChiled = leftChild {
                leftChiled._addNode(value: value)
            }else {
                let newNode = BinaryTreeNode(value: value)
                newNode.parent = self
                leftChild = newNode
            }
            // 추가하려는 값이 Root 키값보다 큰 경우: 우측 서브트리에 삽입
        }else {
            /*
             1. 노드가 존재하는 경우 우측 서브트리에 삽입하고
             2. 노드가 없는 경우 새로운 노드를 만들어서 우측 자식 노드로 삽입
             */
            if let rightChiled = rightChild {
                rightChiled._addNode(value: value)
            }else {
                let newNode = BinaryTreeNode(value: value)
                newNode.parent = self
                rightChild = newNode
            }
        }
    }
    
    /*
     좌측값 -> 루트 노드 값 -> 우측 값: 결과가 오름 차순으로 나옴 ex) 1,2,3,5...
     */
    public class func traverseInOrder(node: BinaryTreeNode?) {
        // nil인 잎에 도달하면 재귀 함수 호출 중단
        guard let node = node else { return }
        BinaryTreeNode.traverseInOrder(node: node.leftChild)
        print(node.value)
        BinaryTreeNode.traverseInOrder(node: node.rightChild)
    }
    
    public class func traversePreOrder(node: BinaryTreeNode?) {
        guard let node = node else { return }
        print(node.value)
        BinaryTreeNode.traversePreOrder(node: node.leftChild)
        BinaryTreeNode.traversePreOrder(node: node.rightChild)
    }
    
    public class func traversePostOrder(node: BinaryTreeNode?) {
        guard let node = node else { return }
        BinaryTreeNode.traversePreOrder(node: node.leftChild)
        BinaryTreeNode.traversePreOrder(node: node.rightChild)
        print(node.value)
    }
    
    public func search(value: T) -> BinaryTreeNode? {
        // 찾으려는 값이 있는경우, 해당 값을 반환
        if value == self.value { return self }
        
        // 해당 키값이 현재 노드의 키값보다 작은 경우
        // 좌측 서브트리에서 재귀적으로 검색을 시작
        if value < self.value {
            /*
             현재 키값보다, 작은값인데 자식 노드가없다면, 찾는값은 없으므로 nil 반환
             현재 키값보다 작은데, 노드가 있는 경우, 자식 노드로 search 호출하여 재귀적으로 실행
             */
            guard let left = leftChild else { return nil }
            return left.search(value: value)
        } else {
            guard let right = rightChild else { return nil }
            return right.search(value: value)
        }
    }
    
    /*
     삭제 작업은 노드 삽입이나 검색에 비해 훨씬 까다로운 편인데, 이는 트리에서 특정 노드를 삭제하기 위해서는 그에 따르는 다양한 상황을 미리 구체적으로 알고 있어야하기 때문임.
     - 삭제 대상 노드가 자식 노드를 가지고 있지 않은 경우
     - 삭제 대상 노드가 단 하나의 자식을 가지고 있는 경우
     - 삭제 대상 노드가 두개의 자식노드를 가지고 있는 경우(이 경우가 까다로움..)
     1. 삭제 대상 노드보다 큰 값 중 가장 작은 요소를 찾는다: 우측 서브트리의 최솟값, 삭제 대상노드보다 작은 값 중 가장 큰 요소를 찾는다: 좌측 서브트리의 최댓값
     2. 트리 내에서, 이들 자손과 후손 노드를 삭제하려는 노드의 위치로 이동 시킨다.
     */
    public func delete() {
        // 1. 삭제하려는 노드가 왼쪽 or 오른쪽 자식이 있는지 확인한다. -> 자식노드가 왼쪽, 오른쪽 단일 노드인지 -> 자식 노드가 없는지
        if let left = leftChild {
            
            /// 1. 삭제대상 노드가 좌측, 및 우측 두개의 자식 요소를 모두 지닌 경우 -> 후손 교환 작업 수행
            if let _ = rightChild {
                self.exchangeWithSuccessor()
                
                /// 2. 삭제 대상 노드가 왼쪽 자식만 있는 경우
                /// 삭제 대상 노드의 self.parent와 self.child를 바로연결함.
                /// 이를 위해서는 먼저 대상 노드가 부모 노드의 우측 서브 트리에 속한 자식의 좌측 노드인지 알아야함
            }else {
                self.connectParentTo(child: left)
            }
            /// 3. 삭제대상 노드가 오른쪽 자식을 가지고 있는 경우 -> 하나의 자식노드만 가지고 있는 경우와 동일함.
        }else if let right = rightChild {
            self.connectParentTo(child: right)
            
            /// 4. 삭제대상 노드가 자식 노드가 없는 경우
        }else {
            // 부모의 왼쪽 혹은 오른쪽 자식 노드를 nil로 할당
            self.connectParentTo(child: nil)
        }
        
        // 삭제 대상 노드의 모든 레퍼런스 해제
        self.parent = nil
        self.leftChild = nil
        self.rightChild = nil
    }
    
    /// 삭제 대상 노드의 후손을 위해 노드 교환 수행
    private func exchangeWithSuccessor() {
        guard let right = self.rightChild, let left = self.leftChild else { return }
        
        /*
         삭제하려는 노드를 기준으로 오른쪽 노드의 가장 작은 값을 삭제 대상 노드와 교체함.
         */
        let successor = right.minimum()
        // 가장 작은 값이 노드가 있다면(= 오른쪽에 노드가 있는경우..)
        successor.delete()
        
        successor.leftChild = left
        left.parent = successor
        
        /*
         1. 삭제하려고 하는 노드의 우측 자식 노드가, 가장큰 노드와 같지 않으면, 해당 노드아래로 트리의 깊이가 더 있는것.
         2. 삭제하려고 하는 노드의 우측 자식 노드가, 가장큰 노드와 같으면 삭제하려고하는 노드는, 노드가 딱 2개(좌, 우) 있는것
         */
        if right !== successor {
            successor.rightChild = right
            right.parent = successor
        }else {
            successor.rightChild = nil
        }
        
        self.connectParentTo(child: successor)
    }
    
    
    private func connectParentTo(child: BinaryTreeNode?) {
        print("self.parent: \(self.parent)")
        // 여기에서 self.는 삭제하려는 대상의 parent 이기때문에, 삭제하려는 값이 root이 아닐때, 가장큰값의 parent를 설정해줄수있음.
        guard let parent = self.parent else {
            child?.parent = self.parent
            print("child?.parent: \(child?.parent), self.parent: \(self.parent)")
            return
        }
        
        /*
         1. 삭제 대상 부모 노드의 왼쪽 자식, 또는 오른쪽 (내가) 자식이라면
         2. 왼쪽 자식이라면, 부모의 왼쪽 자식을 삭제 대상 자식의 가장 큰 값으로 변경
         3. 삭제 대상 자식의 가장 큰값의 부모를 삭제 대상 노드의 부모로 변경
         */
        if parent.leftChild === self {
            parent.leftChild = child
            child?.parent = parent
            
        }else if parent.rightChild === self {
            parent.rightChild = child
            child?.parent = parent
        }
    }
    
    /*----------------helper function-----------------*/
    
    /// 트리 내(해당 노드 기준으로) 최소 노드 반환
    public func minimum() -> BinaryTreeNode {
        if let left = leftChild {
            return left.minimum()
        }else {
            return self
        }
    }
    /// 트리 내(해당 노드기준으로) 최대 노드 반환
    public func maximum() -> BinaryTreeNode {
        if let right = rightChild {
            return right.maximum()
        }else {
            return self
        }
    }
    
    // 트리 내(해당 노드 기준으로) 최소값 확인
    public func minimumValue() -> T {
        if let left = leftChild {
            return left.minimumValue()
        }else {
            return value
        }
    }
    
    public func maximumValue() -> T {
        if let right = rightChild {
            return right.maximumValue()
        } else {
            return value
        }
    }
    
    /**
     트리의 높이
     하나의 노드에서 가장 멀리 떨어져 있는 잎사귀 노드에 이르는 모서리 수를 가리킨다. 루트 노드밖에 없는 트리의 노드 높이는 0이다.
     */
    public func height() -> Int {
        if leftChild == nil && rightChild == nil {
            return 0
        }
        // 왼쪽 오른쪽 자식중 가장 멀리있는 노드 모서리 수 + 1
        return 1 + max(leftChild?.height() ?? 0, rightChild?.height() ?? 0)
    }
    
    /**
     레벨
     어떤 노드의 레벨이란 깊이 +1을 의미한다
     */
    public func depth() -> Int {
        guard var node = parent else { return 0 }
        var depth = 1
        while let parent = node.parent {
            depth += 1
            node = parent
        }
        return depth
    }
}

extension BinaryTreeNode: CustomStringConvertible {
    public var description: String {
        return "value: \(self.value), left: \(self.leftChild?.value), right: \(self.rightChild?.value), parrent: \(self.parent)"
    }
}

extension BinaryTreeNode: CustomDebugStringConvertible {
    public var debugDescription: String {
        return diagram(for: self)
    }
    private func diagram(for node: BinaryTreeNode?,
                         _ top: String = "",
                         _ root: String = "",
                         _ bottom: String = "") -> String {
        guard let node = node else {
            return root + "nil\n"
        }
        if node.leftChild == nil && node.rightChild == nil {
            return root + "\(node.value)\n"
        }
        return diagram(for: node.rightChild, top + " ", top + "┌──", top + "│ ")
            + root + "\(node.value)\n"
            + diagram(for: node.leftChild, bottom + "│ ", bottom + "└──", bottom + " ")
    }
}
