import UIKit

var str = "Hello, playground"
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
class BinaryTreeNode<T: Comparable> {
    // for the children, we point to nodes
    // should these be optional? at some point they could be nil. don't have to initialize them with values!
    var left: BinaryTreeNode?
    var right: BinaryTreeNode?
    
    var isLeaf: Bool {
        return left == nil && right == nil
    }
    // nodes hold values
    var value: T //T is generic
    
    // classes need to be inited
    init(_ value: T) {
        self.value = value
    }
}

/*
 // top of tree is root -> no parents
         root
          1
         /  \
        2    3
       / \  / \
      4  5  6
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

// 1: Refactor Kevin's recursive largestValueInTree to work for negative numbers
// 2: Swap all leaves (on their parent) in a tree
// 3: Insert a new node at the leaf on the smallest level. If all leaves are at the same level, insert that node at the left-most level








// Thursday: BFS and DFS and preview some of the specific kinds of trees out there.
