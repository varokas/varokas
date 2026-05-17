---
layout: post
title: 'Algorithms: Sorting'
date: '2020-12-30 08:38:19 +0000'
slug: sorting-algorithms
permalink: "/sorting-algorithms/"
author: Varokas Panusuwan
tags: []
feature_image: https://images.unsplash.com/photo-1521192520982-5d6ca468a30f?ixlib=rb-1.2.1&q=80&fm=jpg&crop=entropy&cs=tinysrgb&w=2000&fit=max&ixid=eyJhcHBfaWQiOjExNzczfQ
ghost_id: 5fc436d32a88f40001aa8609
visibility: public
---

<p>High level review of classic sorting algorithms with Haskell. </p><h3 id="what-do-we-mean-by-sorted">What do we mean by Sorted?</h3><p>For a sorted list, every element is smaller or equals to the next one. From this very definition we can check if a list is sorted by</p><ol><li>Checking that the first element is less than or equal to the next one</li><li>Recursively check that the rest is sorted </li></ol><figure class="kg-card kg-image-card"><img src="/assets/images/ghost/2020/12/Screen-Shot-2020-12-05-at-6.55.56-AM.png" class="kg-image" alt loading="lazy"></figure><pre><code class="language-hs">isSorted [] = True
isSorted [x] = True
isSorted (x0:x1:xs) = (x0 &lt;= x1) &amp;&amp; isSorted(x1:xs)</code></pre><h3 id="recursive-sorting-algorithms">Recursive Sorting algorithms</h3><p>These sorting algorithms divide the given list into 2 subproblems of roughly the same size. There are two prominent algorithms in this category.</p><ul><li><strong>Merge sort </strong>- uses a linear time algorithm to combine the two sorted lists</li><li><strong>Quick sort </strong>- uses a linear time algorithm to partition values into left (less than) and right (more than) a pivot. </li></ul><h3 id="merge-sort">Merge Sort</h3><p>Given 2 already sorted lists, compare only the first element from both lists. The smaller value got appended to the result. Repeat this process with that smaller value removed from consideration.</p><figure class="kg-card kg-image-card"><img src="/assets/images/ghost/2020/12/Screen-Shot-2020-12-05-at-7.16.44-AM.png" class="kg-image" alt loading="lazy"></figure><pre><code class="language-hs">merge :: Ord a =&gt; [a] -&gt; [a] -&gt; [a]
merge [] [] = []
merge xs [] = xs
merge [] ys = ys
merge (x:xs) (y:ys) 
  | x &lt;= y    = x : merge xs (y:ys)
  | otherwise = y : merge (x:xs) ys</code></pre><p>The full merge sort algorithm simply halves a given unsorted list, recursive call to sort each half. Afterward, combining the two sorted halves with the merge algorithm defined above. </p><pre><code class="language-hs">split :: [a] -&gt; ([a], [a])
split [] = ([], [])
split xs = splitAt (length(xs) `div` 2) xs

mSort :: Ord a =&gt; [a] -&gt; [a]
mSort [] = []
mSort [x] = [x]
mSort xs = merge (mSort left) (mSort right)
  where 
    (left, right) = split xs</code></pre><h3 id="quicksort">Quicksort</h3><p>Here is a classic intro in showing the expressive power of Haskell. </p><ol><li>Uses the first value <code>x</code> as a pivot point. Loop and separate values into <code>≤ x</code><strong> </strong>group and <code>&gt;x</code> group. </li><li>Recursively calls quick sort into the two groups</li><li>join the <code><code>≤ x</code></code>, <code>x</code>, and <code>&gt;x</code> group together</li></ol><figure class="kg-card kg-image-card"><img src="/assets/images/ghost/2020/12/Screen-Shot-2020-12-30-at-3.04.43-PM.png" class="kg-image" alt loading="lazy"></figure><p>There's no guarantee that the two groups are partitioned into equal sizes. There exists a way to do quick sort in-place without additional memory, however.</p><pre><code class="language-hs">qSort :: Ord a =&gt; [a] -&gt; [a]
qSort [] = []
qSort (x:xs) = qSort(left) ++ [x] ++ qSort(right)
  where
      left  = [y | y &lt;- xs, y &lt;= x]
      right = [y | y &lt;- xs, y &gt;  x]</code></pre><h3 id="quadratic-time-sorting-algorithms">Quadratic time sorting algorithms</h3><p>Also known as O(n^2). These algorithms have a similar outline where the problem size is reduced by 1 per iteration of execution. Each iteration itself takes a linear time, making this O (n^2) in total.</p><h3 id="selection-sort">Selection Sort</h3><p>Finds a min value from a list, adds to answer, repeats on the remaining list excluding the selected min value.</p><pre><code class="language-hs">sSort :: Ord a =&gt; [a] -&gt; [a]
sSort [] = []
sSort xs = min : sSort(remaining)
  where min = minimum xs
        remaining = delete min xs</code></pre><h3 id="insertion-sort">Insertion Sort </h3><p>Maintain a sorted list (the answer), starting from empty. Insert a new value one element at a time from original lists at the right index in the sorted answer.</p><pre><code class="language-hs">orderedInsert :: Ord a =&gt; a -&gt; [a] -&gt; [a]
orderedInsert a [] = [a]
orderedInsert a (x:xs)
  | a &lt; x     = a:x:xs
  | otherwise = x:(orderedInsert a xs)

iSort :: Ord a =&gt; [a] -&gt; [a]
iSort [] = []
iSort (x:xs) = orderedInsert x (iSort xs)
</code></pre><h3 id="bubble-sort">Bubble Sort</h3><p>Closely related to selection sort. Instead of selecting a max value, bubbles the value as we compare each element.</p><pre><code class="language-hs">bSort :: Ord a =&gt; [a] -&gt; [a]
bSort [] = []
bSort xs = bSort(init bubbled) ++ [last bubbled]
  where
    bubbled = bubble xs

bubble :: Ord a =&gt; [a] -&gt; [a]
bubble [] = []
bubble [x] = [x]
bubble (x0:x1:xs)
  | x0 &lt; x1   = x0 : bubble( x1:xs )
  | otherwise = x1 : bubble( x0:xs )</code></pre>
