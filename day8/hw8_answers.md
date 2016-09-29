Student Name: Gabriel Butterick [change to your name]
Check one:
[ ] I completed this assignment without assistance or external resources.
[x] I completed this assignment with assistance from ___
   and/or using these external resources: ___https://www.youtube.com/watch?v=g4e2RElzCSQ


Question 1
For each of the following languages, decide whether it is regular. If it is regular, give a regular expression or finite automaton that recognizes the language. If it is not regular, demonstrate that using the pumping lemma.

a) Strings containing only the symbol a whose length is a power of 2 (i.e. length 2^n)

[The strings a, aa, aaaa, and aaaaaaaa are in this language; the string aaaaa is not.]

Assume the language L is regular. If it is is regular, it must have some pumping length P. Let us assume that the string S is contained in the language and can be defined as S=a^2P. Let us say the pumping length is 2 and the string is now 'aaaa.' We can divide this up into x, the string before the loop, y, the loop itself, and z, the string after the loop. We will say x = a, y = a, and z = aa, such that x(y^i)z is in L. If i=0, the total number of a's would be 3, which is not a power of two, thereby a contradiction has occurred and L is not a regular language.

b) All strings with an equal number of occurrences of the substrings 01 and 10.

[010 is in this language; 000110 is in the language; 0101010 is in the language; but 010101 is not.]

0*(01)+1*(0)+

c) All strings (over {0,1}) consisting of a substring w followed by the reverse of the substring.

[The strings 00100100 and 11110101011010101111 are in this language; the strings 00100 and 010101are not.]

Assume the language L is regular. If it is regular, it must have some pumping length P. Let us assume that the string S is contained in the language and can be defined as S=(0^p)(1^p)(0^p). Let us say the pumping length is 2 and the string is now '001100.' We can divide this up into x, the string before the loop, y, the loop itself, and z, the string after the loop. We will say x = 0, y = 0, and z = 1100, such that x(y^i)z is in L. If i=0, the total number of 0's would be less on the left side than the right, which means the string is not made up of a string followed by its reverse. Thereby, a contradiction has occurred and L is not a regular language.

3)
I used the pumping game's first exercise as the basis for my PDA, which requires that the number of 'a' characters present be less than the number of 'b' characters present.