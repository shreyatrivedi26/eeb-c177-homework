<h1>Part 1:<h1> 

<h2>Question 4:<h2> 

4.1.1 `cut -d "," -f 3 nobel.csv | grep -c chemistry`
   ..* Output: 181

4.1.2   `cut -d "," -f 3 nobel.csv | grep -c physics`
     ..* Output: 210 

4.1.3   `cut -d "," -f 3 nobel.csv | grep -c peace`
     ..* Output: 133

4.1.4   `cut -d "," -f 3 nobel.csv | grep -c economics`
     ..* Output: 81

4.1.5   `cut -d "," -f 3 nobel.csv | grep -c literature`
     ..* Output: 114

4.1.6   `cut -d "," -f 3 nobel.csv | grep -c medicine`
     ..* Output: 216


4.2  ```python
	cut -d "," -f 5 nobel.csv > firstname.csv
        cut -d "," -f 6 nobel.csv > lastname.csv
	paste firstname.csv lastname.csv -d "-" > fullname.csv
	sort fullname.csv|uniq -d -c
     ```
`paste` command helps in **merging** the two columns into one. 
 
Output:
 
      3 "Comité international de la Croix Rouge (International Committee of the Red Cross)"-NA
      2 "Frederick"-"Sanger"
      2 "John"-"Bardeen"
      2 "Linus Carl"-"Pauling"
      2 "Marie"-"Curie
      2 "Office of the United Nations High Commissioner for Refugees (UNHCR)"-NA

   
4.3   `cut -d "," -f 6 nobel.csv | grep -wo '[[:alnum:]]\+'|sort|uniq -d -c| sort -nr`
     ..* Output: 14 von
      8 Jr
      6 de
      5 Smith
      
      `grep -wo '[[:alnum:]]\+'` command was something I found online. This helped
 me select all the sub-categories within a category column.  

4.4 `cut -d "," -f 3 nobel.csv | grep -wo '[[:alnum:]]\+'|sort|uniq -d -c| sort -nr`

	Nobel Prize in **Medicine** was awarded the most = **216** 
        Nobel Prize in **Economics** was awarded the leastt = **81**  




