---
layout: post
title: Python Notes
date: '2017-08-21 00:00:00 +0000'
slug: python-notes
permalink: "/python-notes/"
author: Varokas Panusuwan
tags: []
excerpt: |2

  These are my public notes on python 3
canonical_url: https://medium.com/@varokas/python-notes-ccf2410dda2c
ghost_id: 5e929aca9c3d50000174a330
visibility: public
---

<p>These are my public notes on python 3</p><h3 id="list">List</h3><p>Cons operator. Python3 only. Careful that it needs to have value for (a). empty list is fine for (b)</p><pre><code>a, *b = [1,2,3] # a == 1, b == [2,3]
a, *b, c = [1,2,3] #a == 1, b == [2], c == 3</code></pre><h3 id="looping">Looping</h3><pre><code>coord = [(1,2), (4,5)]

for x,y in coord:
  print(x)

for x,_ in coord:
  print(x)

for i, p in enumerate( range(5,9) ):
  print( i, p )</code></pre><h3 id="range">Range</h3><pre><code>range(5) # 0 to 4
range(1,5) # 1 to 4
range(0,4,2) # 0,2

list(range(5)) #convert to list</code></pre><h3 id="slice-function slice() { [native code] }1">Slice</h3><pre><code>l[start:endEx:step]

# start default = 0
# end default = len(l)
# step default = 1

l = [0,1,2,3,4]
l[2:3] = [20,30] # [0,1,20,30,4]
l[0:0] = [-2,-1] # [-2,-1,0,1,2,3,4]

del l[0:2] # [2,3,4]
l[0:2] = [] # [2,3,4]</code></pre><h3 id="concat-function concat() { [native code] }1">Concat</h3><pre><code>a, b = [1,2], [3,4]
a + b # [1,2,3,4]

b += [1] # append (or b.append(1))

a * 2 # [1,2,1,2]
# be careful of using * in nested. It’s the same instance</code></pre><h3 id="sorted">Sorted</h3><pre><code>list.sort() # in-place
sorted(list) # copy any iterable

# key = 1 param function to sort
# reverse = True</code></pre><h3 id="iterable-comprehension">Iterable Comprehension</h3><pre><code>str = ‘abc’

[ord(str) for ch in str]
[ord(str) for ch in str if ch != ‘a’]

[Card(rank,suit) for suit in suits for rank in ranks]

# Also knows to dedup by itself, does not throw
{ k:v for k,v in country_codes if k &lt; 66 or v &lt; 66 }</code></pre><h3 id="dict">Dict</h3><pre><code>#Iterate, python3
for k,v in dict.items():
   print(k, v)

#Get or Default
dict.get(‘key’, 0)
dict.setdefault(‘key’, []).append(new_value)

#DefaultDict
d = collections.defaultdict(list)
d[key].append('a') # no need to instantiate list</code></pre><h3 id="set">Set</h3><pre><code>empty_set = set() # no literal syntax for empty set

new_set = Set(['a','b'])
new_set.add('c')

combinedSet = setA | setB</code></pre><h3 id="boolean-values">Boolean Values</h3><p>These values are False, others are true</p><pre><code>* None
* False
* 0, 0.0
* [], {}, ()
* __len() == 0
* __bool() == 0</code></pre><h3 id="testing">Testing</h3><p>python -m unittest (discover)</p><p>(works without discover for python3, prefix with test in py name, prefix with test_ for method name.</p><pre><code>import unittest

class TestStringMethods(unittest.TestCase):
  def setUp(self): #also: tearDown
    pass

  @classmethod
  def setUpClass(cls): #also: tearDown
    pass

  def test_upper(self):
    self.assertEqual(‘foo’.upper(), ‘FOO’)</code></pre><h3 id="class">Class</h3><pre><code>class NewClass(BaseClass):
  def __init__(self, x, y):
    self.x = x
    self.y = y

  @staticmethod
  def method(no_self):
    pass</code></pre><h3 id="named-tuples">Named Tuples</h3><pre><code>from collections import namedtuple

Student = namedtuple(‘Student’, ‘firstname lastname’)

a = Student(‘first’, ‘last’)
a.firstname
a.lastname

a = Student(first=’first’, last=’last’)
a._make( (‘a’,’b’) )
a._asdict()
a.first</code></pre><h3 id="enum">Enum</h3><p>Don’t forget to import unique, auto keyword. auto is available in python 3.6</p><pre><code>from enum import Enum, unique, auto

@unique
class Color(Enum):
  RED = 1 #auto()
  GREEN = 2 #auto()
  BLUE = 3 #auto()</code></pre><h3 id="swap-values">Swap values</h3><pre><code>a,b = b,a</code></pre><h3 id="tuple-unpacking-for-functions">Tuple unpacking for functions</h3><pre><code>v = (1,2)
sum(*v)</code></pre><h3 id="string-format">String Format</h3><pre><code>'%s %s' % ('one', 'two')

'{} {}'.format('one', 'two')
'{0} {1}'.format('one', 'two')

'{:&gt;10}'.format('test') # right
'{:10}'.format('test') # left

'{:.5}'.format('xylophone') # trunc

'{:d}'.format(42)
'{:06.2f}'.format(3.141592653589793)

'{:%Y-%m-%d %H:%M}'.format(datetime(2001, 2, 3, 4, 5))</code></pre><h3 id="naming-conventions">Naming Conventions</h3><p><a href="https://google.github.io/styleguide/pyguide.html">Google Python Style Guide</a>

</p><pre><code>module_name, package_name
method_name, function_name, function_parameter_name
ClassName, ExceptionName, 
GLOBAL_CONSTANT_NAME, 
instance_var_name, global_var_name, local_var_name</code></pre>
