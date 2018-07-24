

public struct AVLTree<Element: Comparable> {

    public private(set) var root: AVLNode<Element>?

    public init() {}
}

extension AVLTree: CustomStringConvertible {

    public var description: String {
        return root?.description ?? "empty tree"
    }
}

extension AVLTree {

    public mutating func insert(_ value: Element) {
        root = insert(from: root, value: value)
    }

    private func insert(from node: AVLNode<Element>?, value: Element) -> AVLNode<Element> {
        guard let node = node else {
            return AVLNode(value: value)
        }
        if value < node.value {
            node.leftChild = insert(from: node.leftChild, value: value)
        } else {
            node.rightChild = insert(from: node.rightChild, value: value)
        }

        // 삽입시에, node자체를 반환하지말고, 균형잡힌 노드를 반환해줍니다. 이렇게하면 삽입시, 모든 노드들의 balanceFactor값을 검사하고, 균형을 조정합니다.
        let balancedNode = balanced(node)
        balancedNode.height = max(balancedNode.leftHeight, balancedNode.rightHeight) + 1

        return balancedNode
    }

    /*
     * 4가지 Rotation Case를 통해서, AVL트리에 값을 삽입시, 균형 검사를 하여서, 자체 균형을 잡는 트리를 생성
     * 1. Left Rotation: 균형 값이 -2인 경우(오른쪽자식 노드가 더 무거운 경우), node 25의 균형은 -2
     *      50                  50
     *     /   \               /   \
     *    25   75             37   75
     *     \          ~>     /   \
     *     37              25    40
     *      \
     *       40
     *
     * 2. Right Rotation: Left Rotation의 데칼코마니 반대의 버전입니다. node 25의 균형이 +2 일때 입니다.
     *         50                  50
     *        /   \               /   \
     *       25   75             20   75
     *      /          ~>      /  \
     *     20                 10  25
     *    /
     *   10
     *
     * 3. Right Left Rotation: 최종적으로 오른쪽 회전을 하기위해서 왼쪽 회전을함. 왼쪽 회전만으로 요소가 해결되지 않을때 사용할수 있음
     *       50                  50                   50
     *      /   \               /   \                /   \
     *     25    55             25   55              25   55
     *      \          ~>        \          ~>       /   \
     *      37                   36                36   37
     *      /                     \
     *    36                     37
     *
     * 4. Left Right Rotation: 최종적으로 오른쪽 회전을 하기 위해서 왼쪽 회전후, 오른쪽 회전 함
     *      50                  50                   50
     *     /   \               /   \                /   \
     *    25    55            25    55              20    55
     *   /           ~>       /            ~>      /   \
     *  10                   20                    10   25
     *   \                  /
     *   20                10
     */

    /**
     * Left Rotation: 균형 값이 -2인 경우(오른쪽자식 노드가 더 무거운 경우), node 25의 균형은 -2
     *     50                  50
     *    /   \               /   \
     *   25   75             37   75
     *    \          ~>     /   \
     *    37              25    40
     *     \
     *     40
     */
    private func leftRotate(_ node: AVLNode<Element>) -> AVLNode<Element> {
        // 1. leftRotation시, 중심 노드
        let pivot = node.rightChild!
        // 2. 회전이후, 노드의 오른쪽 자식 노드는, pivot노드 보다 작으면서, node보다는 큰 값을 가진 노드를 반환
        node.rightChild = pivot.leftChild
        // 3. pivot의 왼쪽 자식으로 불균형 노드를 회전
        pivot.leftChild = node
        // 4 node, pivot의 height 재측정
        node.height = max(node.leftHeight, node.rightHeight) + 1
        pivot.height = max(pivot.leftHeight, pivot.rightHeight) + 1
        // 5. node의 위치와, hegiht 값 변환후, pivot 반환
        return pivot
    }

    /**
     Left Rotate의 반대쪽 버전,
     */
    private func rightRotate(_ node: AVLNode<Element>) -> AVLNode<Element> {
        let pivot = node.leftChild!
        node.leftChild = pivot.rightChild
        pivot.rightChild = node
        node.height = max(node.leftHeight, node.rightHeight) + 1
        pivot.height = max(pivot.leftHeight, pivot.rightHeight) + 1
        return pivot
    }

    /**
     오른쪽 회전후 -> 왼쪽 회전 한 Node를 반환(결과적으로 왼쪽 회전 시키기 위해서 오른쪽 회전을함.)
     */
    private func rightLeftRotate(_ node: AVLNode<Element>) -> AVLNode<Element> {
        guard let rightChild = node.rightChild else { return node }
        // 노드의 오른쪽 자식을 오른쪽 회전 시키고,
        node.rightChild = rightRotate(rightChild)
        return leftRotate(node)
    }

    /**
     노드를 왼쪽 회전 후, 오른쪽 회전으로 균형을 잡음.
     */
    private func leftRightRotate(_ node: AVLNode<Element>) -> AVLNode<Element> {
        guard let leftChild = node.leftChild else { return node }
        node.leftChild = leftRotate(leftChild)
        return rightRotate(node)
    }

    /**
     다음 작업은 balanceFactor를 사용하여 노드 균형 조정이 필요한지 여부를 결정하는 방법을 설계하는 것입니다. leftRightRotate 아래에 다음 메소드를 작성하십시오

     1. balanceFactor가 2 이면, 왼쪽 자식이 오른쪽 자식보다 무겁습니다. 이것은 오른쪽, 왼쪽,오른쪽 회전을 사용해야 함을 의미합니다
     - 왼쪽이 무거우면 오른쪽 회전, 왼쪽-오른쪽 회전
     2. balanceFactor가 -2 이면, 오른쪽 자식이 왼쪽 자식보다 무겁다는것을 의미합니다. 왼쪽 또는 오른쪽-왼쪽 회전을 사용해야합니다
     - 오른쪽이 무거우면 왼쪽, 오른쪽-왼쪽 회전
     3. 기본 경우는 특정 노드가 균형을 이룬다는 것을 나타냅니다. 노드를 반환하는 것 외에는 여기서 할일이 없습니다.

     balanceFactor의 신호를 사용하여 한번 혹은 두번 회전이 필요한지 결정할수 있습니다.
     */
    private func balanced(_ node: AVLNode<Element>) -> AVLNode<Element> {
        switch node.balanceFactor {
        // 1. 왼쪽이 더 무거운 경우, 오른쪽 회전 or 왼쪽-오른쪽 회전
            /*
             *        10 balanceFactor: 2              10 balanceFactor: 2
             *       /                                /
             *      5 balanceFactor: 1               5 balanceFactor: -1
             *     /                                  \
             *    2 balanceFactor: 0                   7 balanceFactor: 0
             */
        case 2:
            // 왼쪽-오른쪽 회전을 해야하는 경우
            if let leftChild = node.leftChild, leftChild.balanceFactor == -1 {
                return leftRightRotate(node)
            // 오른쪽 회전만 하는 경우
            }else {
                return rightRotate(node)
            }
        // 2. 오른쪽이 더 무거운 경우, 왼쪽 회전 or 오른쪽-왼쪽 회전
            /*         10 balanceFactor: -2        10 balanceFactor: -2
             *           \                           \
             *           20 balanceFactor: -1         20 balanceFactor: 1
             *             \                          /
             *             30 balanceFactor: 0       15 balanceFactor: 0
             */
        case -2:
            if let rightChild = node.rightChild, rightChild.balanceFactor == 1 {
                return rightLeftRotate(node)
            }else {
                return leftRotate(node)
            }
        // 3. 기본적인 경우, 이때는 노드들이 균형을 이룬다는것을 알수 있습니다.
        default:
            return node
        }
    }
}

extension AVLTree {

    public func contains(_ value: Element) -> Bool {
        var current = root
        while let node = current {
            if node.value == value {
                return true
            }
            if value < node.value {
                current = node.leftChild
            } else {
                current = node.rightChild
            }
        }
        return false
    }
}

private extension AVLNode {

    var min: AVLNode {
        return leftChild?.min ?? self
    }
}

extension AVLTree {

    public mutating func remove(_ value: Element) {
        root = remove(node: root, value: value)
    }

    private func remove(node: AVLNode<Element>?, value: Element) -> AVLNode<Element>? {
        guard let node = node else {
            return nil
        }
        if value == node.value {
            if node.leftChild == nil && node.rightChild == nil {
                return nil
            }
            if node.leftChild == nil {
                return node.rightChild
            }
            if node.rightChild == nil {
                return node.leftChild
            }
            node.value = node.rightChild!.min.value
            node.rightChild = remove(node: node.rightChild, value: node.value)
        } else if value < node.value {
            node.leftChild = remove(node: node.leftChild, value: value)
        } else {
            node.rightChild = remove(node: node.rightChild, value: value)
        }
        
        // 제거작업도 엄청 쉽게 해결할수 있음.. 
        let balancedNode = balanced(node)
        balancedNode.height = max(balancedNode.leftHeight,
                                  balancedNode.rightHeight) + 1
        return balancedNode
    }
}

