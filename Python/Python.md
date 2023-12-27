# Leetcode problems

## 1.two_sum

``` python
class Solution:
    def twoSum(self, nums: List[int], target: int) -> List[int]:
        htable = {}
        for i in range(len(nums)):
            j = target - nums[i]
            if j in htable:
                return [htable[j], i]
            htable[nums[i]] = i
        return []

```
---
## 49.group_anagram

``` python
class Solution:
    def groupAnagrams(self, strs: List[str]) -> List[List[str]]:
        res = defaultdict(list)
        for s in strs:
            count = [0] * 26

            for c in s:
                count[ord(c) - ord("a")] += 1

            res[tuple(count)].append(s)

        return res.values()


# O(m * n)

```
---
## 217.contains_duplicate

``` python
class Solution:
    def containsDuplicate(self, nums: List[int]) -> bool:
        htable = {}
        for num in nums:
            if num in htable:
                return True
            htable[num] = 1

        return False

```
---
## 242.valid_anagram

``` python
class Solution:
    def isAnagram(self, s: str, t: str) -> bool:
        if len(s) != len(t):
            return False

        htable1, htable2 = {}, {}

        for i in range(len(s)):
            htable1[s[i]] = 1 + htable1.get(s[i], 0)
            htable2[t[i]] = 1 + htable2.get(t[i], 0)

        for j in htable1:
            if htable1[j] != htable2.get(j, 0):
                return False

        return True
# time O(n) = O(s+t) | space O(n)
# can improve space comp by solving via sorting to O(1)
```
---
## 347.top_k_frequent_elements

``` python
class Solution:
    def topKFrequent(self, nums: List[int], k: int) -> List[int]:
        hmap = {}
        frequency = [[] for i in range(len(nums) + 1)]

        for n in nums:
            hmap[n] = 1 + hmap.get(n, 0)

        for n, c in hmap.items():
            frequency[c].append(n)

        res = []

        for i in range(len(frequency) - 1, 0, -1):
            for n in frequency[i]:
                res.append(n)
                if len(res) == k:
                    return res


# time complexity O(n)

```
---
## 

``` python

```
---
## 

``` python

```
---
## 

``` python

```
---
## 

``` python

```
---
## 

``` python

```
---
## 

``` python

```
---
## 

``` python

```
---
## 

``` python

```
---
## 

``` python

```
---
## 

``` python

```
---
