# variables are dynamicly typed
n = 0
print("variables are dynamicly typed, n = ", n)
n = "anc"
print("variables are dynamicly typed, n = ", n)

# we can do multiple assignments
n, m = 0, "abc"

# increment
n = n + 1
n += 1

# if statements
n = 1
if n > 2:
    n -= 1
    print("if statements", n)

# while loops
n = 0
while n < 5:
    print("while loops", n)
    n += 1

# for loop
for i in range(5):
    print("for loop", i)

# decrementing for loop
for i in range(5, 1, -1):
    print("decrementing for loop", i)

# division is decimal by default
print("division is decimal by default", 5 / 2)
# double slash rounds down
print("double slash rounds down", 5 // 2)
# even in negative numbers
print("even in negative numbers", -5 // 2)

# modding
print("modding", 10 % 3)

# max / min inf
float("inf")
float("-inf")

# arrays (lists)
arr = [1, 2, 3]
print("arrays (lists)", arr)
# can be used as stack
arr.append(4)
arr.append(5)
print("can be used as stack", arr)
arr.pop()
print("pop", arr)
# we can insert but its O(n)
arr.insert(1, 7)
print("we can insert", arr)
# reassingn
arr[0] = 0
arr[3] = 0
print("reassing", arr)

print("initializing arr of size n with default value of 1")
n = 5
arr = [1] * 5
print(arr)
print(len(arr))

print("sublists aka slicing")
arr = [1, 2, 3, 4]
print(arr[1:3])

print("unpacking")
a, b, c = [1, 2, 3]
print(a, b, c)

print("loop through arrays")
nums = [1, 2, 3]
# using index
for i in range(len(nums)):
    print("loop through arrays using index", nums[i])
# with index and value
for i, n in enumerate(nums):
    print("loop through arrays with index and value", i, n)

print("loop through mulriple arrays simultaneously with unpacking")
nums1 = [1, 3, 5]
nums2 = [2, 4, 6]
for n, m in zip(nums1, nums2):
    print(n, m)

print("reverse array")
nums = [1, 2, 3]
nums.reverse()
print(nums)

print("sorting")
arr = [5, 4, 2, 3, 1]
arr.sort()
print(arr)

print("reverse sort")
arr.sort(reverse=True)
print(arr)

print("custom sort (by length of string)")
arr = ["abc", "fdss", "aaaaa"]
arr.sort()
print(arr)
arr.sort(key=lambda x: len(x))  # lambda is funcrion without a name
print(arr)

print("list comprehension")
arr = [i + i for i in range(5)]
print(arr)

print("2-d lists")
arr = [[0] * 4 for i in range(4)]
print(arr)

print("strings are similar to arrays")
s = "abc"
print(s[0:2])
print("but this creates new string")
s += "def"
print(s)

print("valid numeric strings can be converted to integers")
print(int("123") + int("123"))
print("and numbers can be converted to strings")
print(str(123) + str(123))

print("ASCII value")
print(ord("a"), ord("b"))

print("combain list of strings with an empty string delimetor")
strings = ["ab", "cd", "ef"]
print("".join(strings))

print("queues (double ended queue), pop left in constant time")
from collections import deque
from multiprocessing import heap

queue = deque()
queue.append(1)
queue.append(2)
print(queue)
queue.popleft()
print(queue)
queue.appendleft(3)
print(queue)

print(
    "hashsets, search in constant time, insert in constant time, cannot be duplicates, remove in const"
)
hset = set()
hset.add(1)
hset.add(2)
print(hset)
print(len(hset))

print(1 in hset)
print(3 in hset)

hset.remove(2)
print(hset)

print("list to set")
print(set([1, 2, 3]))

print("set comprehension")
hset = {i for i in range(5)}
print(hset)

print("hashmap aka dict is most common data structure")
hmap = {}
hmap["abc"] = 123
hmap["fsd"] = 312
hmap["fgn"] = 4567
print(hmap)
print(len(hmap))

hmap["abc"] = 111
print(hmap)

print("abc" in hmap)
hmap.pop("abc")

hmap = {"fff": 312, "ddd": 552345}
print(hmap)

print("dict comprehension")
hmap = {i: 2 * i for i in range(3)}
print(hmap)

print("looping through maps")
for key in hmap:
    print(key, hmap[key])

for val in hmap.values():
    print(val)

for key, val in hmap.items():
    print(key, val)

print("tuples are like arrays but immutable, we can't modify them")
tup = (1, 2, 3)
print(tup)
print(tup[0])

print("tuples can be used as key for hash map/set, lists can't be keys")
hmap = {(1, 2): 3}
print(hmap[(1, 2)])

hset = set()
hset.add((1, 2))
print((1, 2) in hset)

print("heaps")
import heapq

print("under the hood heaps are arrays")
minheap = []
heapq.heappush(minheap, 3)
heapq.heappush(minheap, 2)
heapq.heappush(minheap, 4)
print("min is always at index 0")
print(minheap[0])

while len(minheap):
    print(heapq.heappop(minheap))

print(
    "there is no max heaps by default, but we can use min heap and multiply by -1"
)
maxheap = []
heapq.heappush(maxheap, -3)
heapq.heappush(maxheap, -2)
heapq.heappush(maxheap, -4)
print("max is always at index 0")
print(-1 * maxheap[0])

while len(maxheap):
    print(-1 * heapq.heappop(maxheap))

print("we can build heap from initial values for a liniar time")
arr = [2, 1, 3, 5, 4]
heapq.heapify(arr)
while arr:
    print(heapq.heappop(arr))

print("functions")


def myfunc(n, m):
    return n * m


print(myfunc(3, 4))

print("nested functions")


def outer(a, b):
    c = "c"

    def inner():
        return a + b + c

    return inner()


print(outer("a", "b"))

print("we can modify objects but not reassign unless using nonlocal keywords")


def double(arr, val):
    def helper():
        # modifying array works
        for i, n in enumerate(arr):
            arr[i] *= 2
        # will only modify val in the helper scope
        # val *= 2

        # this will modify val outside helper scope
        nonlocal val
        val *= 2

    helper()
    print(arr, val)


nums = [1, 2]
val = 3
double(nums, val)

print("classes")


class MyClass:
    def __init__(self, nums) -> None:
        # create member variable
        self.nums = nums
        self.size = len(nums)

    # self key word required as param
    def get_len(self):
        return self.size

    def get_double_len(self):
        return 2 * self.get_len()
