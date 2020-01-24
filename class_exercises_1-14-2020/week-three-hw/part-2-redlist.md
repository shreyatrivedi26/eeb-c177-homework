<h1>Part 2:<h1> 

<h3>Question 3:<h2>

3.1 `cut -d "," -f 10 European_Red_List.csv | grep -wo '[[:alnum:]]\+'|sort|uniq -d -c`

..*Output:
    464 CR
   2409 DD
    687 EN
      4 EW
     29 EX
   5805 LC
    411 NA
      4 NE
    964 NT
      8 PE
      8 RE
    885 VU

3.2 

```python
grep AVES European_Red_List.csv > Aves_data.csv
cut -d "," -f 10 Aves_data.csv | grep -wo '[[:alnum:]]\+'|sort|uniq -d -c
```
..*Output: 

     10 CR
     18 EN
      2 EX
    428 LC
     32 NT
      4 RE
     39 VU

3.3 ```python
	cut -d "," -f 5 Aves_data.csv > Aves_order.csv
	cut -d "," -f 10 Aves_data.csv > Aves_Redlist.csv
	paste Aves_order.csv Aves_Redlist.csv -d "-" > order_redlist.csv
	sort order_redlist.csv | uniq -d -c| grep -w "EX\|RE\|CE"
```

**Output:**

2 CHARADRIIFORMES-EX 

The above result means that there are 2 Bird species with the order CHARADRIIFORMES which are under the Extinct (EX) category of Redlist. 
Rest all the categories i.e. RE and CE are absent in the Bird specie list. However, the entire list looks like following:

2 ACCIPITRIFORMES-EN
     20 ACCIPITRIFORMES-LC
      4 ACCIPITRIFORMES-NT
      3 ACCIPITRIFORMES-VU
      3 ANSERIFORMES-EN
     29 ANSERIFORMES-LC
      3 ANSERIFORMES-NT
      6 ANSERIFORMES-VU
      6 CAPRIMULGIFORMES-LC
      3 CHARADRIIFORMES-CR
      2 CHARADRIIFORMES-EN
      2 CHARADRIIFORMES-EX
     70 CHARADRIIFORMES-LC
      6 CHARADRIIFORMES-NT
      9 CHARADRIIFORMES-VU
      2 CICONIIFORMES-LC
      7 COLUMBIFORMES-LC
      3 CORACIIFORMES-LC
      2 CORACIIFORMES-VU
      3 CUCULIFORMES-LC
      7 FALCONIFORMES-LC
     13 GALLIFORMES-LC
      3 GALLIFORMES-NT
      2 GAVIIFORMES-LC
      2 GAVIIFORMES-VU
      9 GRUIFORMES-LC
      3 PASSERIFORMES-CR
      2 PASSERIFORMES-EN
    201 PASSERIFORMES-LC
      8 PASSERIFORMES-NT
     10 PASSERIFORMES-VU
     13 PELECANIFORMES-LC
     10 PICIFORMES-LC
      4 PODICIPEDIFORMES-LC
      3 PROCELLARIIFORMES-EN
      8 PROCELLARIIFORMES-LC
      2 PROCELLARIIFORMES-VU
      2 PTEROCLIFORMES-EN
     13 STRIGIFORMES-LC
      4 SULIFORMES-LC

