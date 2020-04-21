import UIKit

var str = "Hello, playground"

func saySeeYouSoonRecursively(thisMany times: Int) {
//    print("at this call, the value of times is \(times)")
    guard times > 0 else { return }
//    print("See you all at 2pm for recursion!")
    saySeeYouSoonRecursively(thisMany: times - 1)
}
saySeeYouSoonRecursively(thisMany: 3)

// base case -> this is when to stop. if we don't hit the base case, infinite loop :(
// calls itself -> explicitly use the function inside of itself

// could also do it iteratively -> with a range, using a loop

// we can make any iterative function recursive, but not necessarily the oppopsite (can have recursive functions dealing with a varying number of nested loops)
func saySeeYouSoonIteratively(thisMany times: Int) {
// will it always be greater than zero?
    var num = times //times need to be mutable
    while num > 0 {
//        print("See you all at 2pm for recursion!")
        num -= 1
    }
}

// sometimes with recursion, our function calls might seem out of order

// For fibonacci -> the value of the next number in the sequence is the sum of the two values before it
//           0,1,1,2,3,5,8,13,21,34,55,89,144,233,377,610,
// subscript 1,2,3,4,5,6,7,8 ,9 ,10,11,12

func recursiveFib(term: Int) -> Int {
    // base case(s)
    // account for term being negative or zero
    guard term > 1 else { return 0 }
    guard term != 2 else { return 1 }
    
    // call ourselves (recurse) -> the numbers we need to set the base are there (our base cases)
    // until the first recursive call resolves, i don't even begin the second recursive call ->
    return recursiveFib(term: term - 1) + recursiveFib(term: term - 2)
}

// our pattern is call the function on the sum of the two prior terms, determined by the function.

recursiveFib(term: 3) // what is that the same as calling recursively?
// recursiveFib(term: 2)  + recursiveFib(term: 1)

recursiveFib(term: 5) // what is that the same as calling recursively?
// recursiveFib(term: 4) + recursiveFib(term: 3)
// (recursiveFib(term: 3) + recursiveFib(term: 2))
/*
f(6)
f(5) + f(4)
(f(4)       +  f(3))  + (f(3) + f(2))
((f(3) + 1) + (1) + (1 + 1)
(1 + 0 + 1) + (1 + 0) + (1 + 0 + 1) = 5
f(6) = 5
 */
// what are we doing a lot that we might not have iteratively -> made a lot of function calls. And a bunch were duplicative (f(3) is the same every time)

// Memo: record something, make a note
// Memoization: record the results of our function calls in recursion
// ex: First time i look for the 4th term of my recursive Fibonacci solution, I might put in a dictionary dict[4] = 2 (keeping track of inputs as keys, and outputs as values). dict[3] = 1 (O(1) lookup)


// Call stack: Order that functions are called.
// It's a STACK -> look at top for next function to call.

/*f(5)
 f(4)               +   f(3)
 f(3)        + f(2) +   f(2) + f(1)
 f(2) + f(1) +   1  +    1   +  0
 1    +  0   +   1  +    1   +  0 = 3
 */

// functions: "print 6" keeps calling itself -> infinite loop
func printSix() {
//    printSix()
}
/* first time i call the function (fn call a), the function call isn't done until anything happening inside of it is completed. when it goes and calls itself again (fn call b), a is not complete until b is complete. b is going to call the function yet again (fn call c) -> infinite loop
when function is completed (literally, reaches the end of the block of code), it can be popped from the call stack
ex: printSix() call stack never pops until it's empty

f
e
d
c
b
a
 
 // any functions being called inside our function are pushed on top of the stack to be executed before ours.
 
 
*/
func addThenDivide(addOne: Int, addTwo: Int, divisor: Int) -> Int {
    let sum = addOne + addTwo
    return sum / divisor
}
// every time we call addThenDivide -> +, /, addThenDivide
/*
initially:
addThenDivide

then, when we try to add (we pushed + operation):
+
addThenDivide
 
then when addition is complete:
addThenDivide
 
to divide we push /:
/
addThenDivide
 
we finish dividing:
addThenDivide
 
we finish addThenDivide
[]
 */

//Our recursive calls look like a tree, but they dont occur in that way.

/*             f(5)
         f(4)   +    f(3)
f(3)   + f(2) +    f(2) + f(1)
f(2) + f(1) +   1  +    1   +  0
1    +  0   +   1  +    1   +  0 = 3
*/
/*
 f(2)
 f(1)
 f(3)
 f(2)
 f(4)
 f(2)
 f(1)
 f(3)
 f(5) 2 (from the left) + 1 (from the right)
 */



/*
 Write a function called range which takes in two numbers (num1, num2) as arguments. The function should return an array of numbers between num1 and num2.

 range(2,10); // returns [2, 3, 4, 5, 6,7, 8, 9, 10]
 range(17,20); // returns [17, 18, 19, 20]
 
 */


    // empty array of ints (what we're going to return)
    // let's start iteratively - loop through a range
    // append those #s to array, return array
//    for i in num1...num2 {
//        returnArray.append(i)
//    }
//    return returnArray
        
    // now, recursively ->
    // num1 changes in each function call, and it is what we add to the return array.
    // num2 sets our base case -> we're in a range while num1 is less than num2
    // then make a function call to increment it by one
    // recursive call: range(num1+1, num2)
    
    
    // base case: we stop if num1 == num2 -> return array + num2

//memoization -> if we're going to run into a function call with the same inputs multiple times. does not apply here :(
func range(_ num1: Int, _ num2: Int) -> [Int] {
    if num1 == num2 {
        return [num2]
    }
    
    return [num1] + range(num1 + 1, num2)
}

range(1,5)
/* Space complexity: O(1) (saving 0 variables into memory)
 Time: O(n) (makes n calls)
 [1] + range(2,5)
       [2] + range(3,5)
            [3] + range(4,5)
                   [4] + range(5,5)
                          [5]
*/
range(2,9)
// when we see a pattern saying "do something over and over" that's recursion

/*
 Coin Counting:
 Given an infinite number of quarters, dimes, nickels, and pennies, write code to calculate the number of possible ways of giving exact change for n cents.

 In other words, write a function called coinCombos that takes in one argument: n, which represents the total amount of money (in cents) that you need to make change for. Your function should return the amount of possible combinations you can make to return that exact amount of change.

 For example:

 coinCombos(5); //returns 2
 coinCombos(10); //returns 4
 coinCombos(25); //returns 13
 coinCombos(60); //returns 73
 
 Question for ourselves: what is the base case?
 for zero cents, there are no combinations
 for one cent, there is one combination
 ...
 for four cents, there is one combo
 for five cents, there are two combos (5 penny or 1 nickle)
 ...
 for nine cents, there are two combos
 for ten cents, there are four combos (1 dime, 2 nickles, 1 nickle + 5 pennies, 10 pennies)
 ...
 for fifteen cents, there are six combos (15 pennies, 10 pennies + 1 nickle, 5 pennies + 1 dime, 5 pennies + 2 nickles, 3 nickles, 1 nickle + 1 dime)
 
 There's a pattern???
 More combinations as input gets larger
 Each time we add the value of another coin that's NOT a penny, there are more combinations
 
 Recursively: The number of combinations of coins to get a particular change amount is equal to (pattern above) for some smaller subset.
 25 -> quarter, and any other combos that dont use a quarter
 25 -> quarter, and the dime combinations, and combinations that dont use a dime or quarter
 25 -> quarter, and the dime (with no quarters) combos, and the nickle (with no quarters or dimes) combos, and the penny-only combo
  
 */
class Math {
    // outside of the scope of the function, so that it isn't recreated each time we call it
    static var fibMemo:[Int:Int] = [:]
    
    func fibonacci(term: Int) -> Int {
        guard term > 1 else {return 0}
        guard term != 2 else {return 1}
        
        // memoizing saves us here by letting us look up past inputs, and if they exist, using them. The lookup in fibMemo is O(1)
        if let memoizedTerm = Math.fibMemo[term] {
            return memoizedTerm
        }
        
        //Memoization occurs during the recursive function call
        let currentTerm = fibonacci(term: term-1) + fibonacci(term: term-2)
        Math.fibMemo[term] = currentTerm // O(1)
        return currentTerm
        // anything after the return doesn't get executed
    }
}

Math().fibonacci(term: 12)
/*
 f(5)
 f(4) + f(3)
 (f(3) + f(2)) + f(3)
 ((f(2) + f(1)) + f(2)) + f(3)
 1 + 0 + 0
 */

// Memoization is one of the optimizations you can do to recursion in a process called Dynamic Programming. Tabulation is another approach.








class LLNode<T: Equatable>: Equatable {
  public var value: T
  public var next: LLNode?
  init(value: T) {
    self.value = value
  }
  static func ==(lhs: LLNode, rhs: LLNode) -> Bool {
    return lhs.value == rhs.value &&
      lhs.next == rhs.next
  }
}
struct Queue<T: Equatable> {
  private var head: LLNode<T>? // could be nil
  private var tail: LLNode<T>? // could be nil
  public var isEmpty: Bool {
    return head == nil
  }
  public var peek: T? {
    return head?.value
  }
  public mutating func enqueue(_ value: T) {
    let newNode = LLNode(value: value)
    guard let lastNode = tail else {
      head = newNode
      tail = newNode
      return
    }
    lastNode.next = newNode
    tail = newNode
  }
  @discardableResult
  public mutating func dequeue() -> T? {
    var valueRemoved: T?
    guard !isEmpty else { return valueRemoved }
    valueRemoved = head?.value
    if head == tail { tail = nil }
    head = head?.next
    return valueRemoved
  }
}




/*
 Trees -> Combine a ton of DSA concepts
 - kind of look like a Linked List - different because they can point in many directions. In a LL, a node has a next (pointing to one node), in a Tree a node has children (pointing to many nodes).
 - Whereas a LL is for order (this, this.next is the next thing in our list), a Tree is used to represent HIERARCHY!
 - node has children. Those children have a "parent" node. Each "generation" in the tree is a level. Very top of the tree is the root. Bottom parts of the tree are the leaves.
 - root knows its children, which know their children, which know their children... until there are no more children for a given node. That means... a given child doesn't know what it's parent is (like in a LL, this.next doesn't know what "this" is). Can only go down a tree from a given node
 
 LL:
a -> b -> c -> d -> e
 
 Tree:
      a
    /  \
   b     c
  /\    / \
 d  f  g   e
 
 // Because there are branches, like in a flow chart, i can only access the nodes available from the node i'm currently at. Moving around = "traversing"
 // Since I can't get to all nodes in one branch (unless it's really sparse), there are whole algorithms built around traversing trees.
 
 // 2 categories of traversal algos: Breadth-first, depth-first
 // Breadth-first looks at all the nodes on a given level (starting at the root) before going to the nodes on the next level
 // Depth-first looks at all the nodes on one branch (going down to the leaves) before looking at the next branch. Typically, we traverse to the left before the right
 // We store stuff in trees so that instead of retrieving them in linear time (like in a LL) we can get the back in O(log n)
 
 // Tree with node that has left/right nodes is called a Binary Tree
 // On a binary tree, our ideal would be to be able to search for things in O(log n) time.
 */

// A huge goal of ours for using trees is that we want to be able to move things around based on >, <, >=, <=, and ==
// I want our stored values to be comparable. Gotta make the generic type here conform to comparable


/*
 // top of tree is root -> no parents
         root
          1
         /  \
        2    3
       / \  / \
      4  5  6  7
 */
let root = BinaryTreeNode(1)
let twoNode = BinaryTreeNode(2)
let threeNode = BinaryTreeNode(3)


let fourNode = BinaryTreeNode(4)
let fiveNode = BinaryTreeNode(5)
let sixNode = BinaryTreeNode(6)
let sevenNode = BinaryTreeNode(7)
root.left = twoNode
root.right = threeNode

twoNode.left = fourNode
twoNode.right = fiveNode
threeNode.left = sixNode
threeNode.right = sevenNode

// how many levels? -> 3 (if we count root)
// how can we count the number of levels?
func levelsInTree(from root: BinaryTreeNode<Int>?) -> Int {
    // can't just go down left or right side
    // can't just say "go look for the leaves"
    // let's use recursion
    // use a queue -> enqueue the first node of tree, then use a while loop to look at left/right of each child. if there's a left or a right increment by one. -> breadth-first search, which looks at all the nodes in one level before moving on to the next level.
    // depth-first -> recursively go down levels. Treat child of the root like the root in each recursive call.
    // we'll need to call this function 2x -> once to traverse to the left, and once to traverse to the right.
    
    // base case: stop looking if children are nil
    // should we keep a value that stores the levels? I want to recurse
    guard root != nil else { return 0 }
    
    // why am i okay with forced-unwrapping max here? we return zero for any nil argument to this function
    // DFS goes down the tree recursively, whereas BFS goes down the tree "iteratively"
//    return [levelsInTree(from: root?.left), levelsInTree(from: root?.right)].max()! + 1
    let leftLevels = levelsInTree(from: root?.left)
    let rightLevels = levelsInTree(from: root?.right)
    return leftLevels > rightLevels ? leftLevels + 1 : rightLevels + 1
}
// levelsInTree(from: nil) -> returns zero right now
levelsInTree(from: root)

// Base case for most recursive tree functions will be if the node is nil... variants might be to see if the left/right are nil.
// Recursive call in recursive functions for trees is usually the same function for the left and right side.
// Because from any node there are at most two children in Binary Tree, there's a lot of "either-or"

// Practice:
// 1: Find the value of the left-most node (leaf) in a tree
func leftMostValue(for root: BinaryTreeNode<Int>) -> Int {
    // if let to see if there's a left side
    // if there's a left, return function call on the left
    // if there isn't, return the root
    guard let left = root.left else { return root.value }
    return leftMostValue(for: left)
    // we don't have to worry about right at all
}

leftMostValue(for: root)

// 2: Using DFS, find the largest value in a tree
func largestValueInTree(for root: BinaryTreeNode<Int>) -> Int {
    // base cases are hard.
    // agree.
    // what do we want to look for in this function
    // see if it has left or right to see what to compare it to
    
    // comparison is between the value on the node we see now, and the result of calling this recursively on the children of this node
    // the value we can access as a property (root.value) is an Int, and the return of the recursive call is also an Int.
    // return [root.value, largestValueInTree(for: root.left), largestValueInTree(for: root.right)].max()!
    
    // here are all the logical comparisons
    // base case: if there's no left or right, dont compare to anything
    // what if there's only one leaf?
//    if let left = root.left {
//        if let right = root.right { // optional binding
//            return [root.value, largestValueInTree(for: left), largestValueInTree(for: right)].max()!
//        } else { // if there's no right
//            // compare the left's value to root's value
//            return [root.value, largestValueInTree(for: left)].max()!
//        }
//    } else if let right = root.right {
//        return [root.value, largestValueInTree(for: right)].max()!
//    }
//    return root.value
    
    // here we just look at the maxes we can find
    guard !root.isLeaf else {return root.value}
    var leftMax = Int() //0
    var rightMax = Int() //0
    
    if let left = root.left {
        leftMax = largestValueInTree(for: left)
    }
    
    if let right = root.right {
        rightMax = largestValueInTree(for: right)
    }
    
    return [root.value, leftMax, rightMax].max()!
}

// 2: Swap all leaves (on their parent) in a tree

class BinaryTreeNode<T: Comparable>: Comparable {
    // NodeWithValueSeven < NodeWithValueEight
    static func < (lhs: BinaryTreeNode<T>, rhs: BinaryTreeNode<T>) -> Bool {
        lhs.value < rhs.value
    }
    
    static func == (lhs: BinaryTreeNode<T>, rhs: BinaryTreeNode<T>) -> Bool {
        lhs.value == rhs.value
    }
    
    var left: BinaryTreeNode?
    var right: BinaryTreeNode?
    var value: T
    
    var isLeaf:Bool {
        return left == nil && right == nil
    }
    
    init(_ value: T) {
        self.value = value
    }
    
    func swapLeaves() {
        // to store the changes, we can just change self.
        // what's weird about using recursion? it doesn't return anything
        // can also use recursion until we reach a base case, then say to stop.
        // guard thisThingIsCorrect else {return} -> allowed by Void return type
        // base case? calling this on a leaf
        guard !isLeaf else {return}
        
        // base case? both children are leaves
        // what is this evaluating -> seeing if those values exist
        // if self.left?.isLeaf != nil && self.right?.isLeaf != nil {
        
        // one way to do this
        // if let leftLeafiness = self.left?.isLeaf, leftLeafiness == true, let rightLeafiness = self.right?.isLeaf, rightLeafiness == true {
        // if there is Optional.some (aka, there's a value), we can do a direct comparison
        
        // Code preference: if we don't need to optional bind, we should not. the values will be the same, and they'll be unwrapped, but it takes up memory. we should use optional binding if we need that value in the scope
        if left?.isLeaf == true && right?.isLeaf == true {
            // does this work? no... lose the value of left
//            left = right
//            right = left
            
            // using a temporary variable -> only need to store the first value that's going to be replaced
            swapNodes()
            return
        }
        
        if left != nil {
            left!.swapLeaves()
        }
        
        if right != nil {
            right!.swapLeaves()
        }
    }
    
    private func swapNodes() {
        let temp = right
        right = left
        left = temp
    }
}

/* What we gonna do?
 Tia/Liana: we'll want to see if we are at leaves (base case) -> cant swap if they're not leaves, so we'll need to check the lowest possible level. doy, david. might run into issue where all children get swapped, rather than just the leaves
 Sam/Kevin: go to the node before the leaves and check node.left/node.right, swap those. if left is not a leaf, recursively call it on left. if right is not a leaf, recursively call it. base case is if the children of this node are both leaves
 
 /*
 // top of tree is root -> no parents
         root
          1
         /  \
        2    3
       / \  / \
      4  5  6  7
 */

 
 How are we storing and returning?
 Not returning, because we're just mutating a tree
 Doesn't need mutating -> implemented as a class (left and right refer to items of the same kind
 
 
 
*/


// L8R: BFS -> instead of going depth-wise, it hits each node at each level before going to the next level. More iterative. It's going to use a queue to do stuff


//Queue to queue up binary tree nodes

// why doesnt T work here? Needs to know its type when declared. We can't use generics as Any in the global scope. Generics go in our definitions.

extension BinaryTreeNode {
    func breadthFirstSearch(_ value:T) {
        var queue = Queue<BinaryTreeNode<T>>()
        // would be better-suited to be in a Tree class, rather than a TreeNode class, because it's working on the entire structure. where we use self in this, we could use root in a Tree class
        
        // we'll look at the node, and then we'll queue up its children. "Iterative" search
        // hint: iterate until the queue is empty (queue.isEmpty)
        // we'll start at the current node, and then we'll look left, then we'll look right, then we'll remove our current node
        queue.enqueue(self)

        while !queue.isEmpty {
          // we'll dequeue
          let currentNode = queue.dequeue()!

          // check if we've found what we're looking for
          // if so, print yay
          if currentNode.value == value {
            print("yay")
            return
          }
          
          // if not, we enqueue a node's children.
          if currentNode.left != nil {
            queue.enqueue(currentNode.left!)
            //dequeue, look at next thing
          }

          if currentNode.right != nil {
            queue.enqueue(currentNode.right!)
          }
        }
        print("nay")
    }
}
