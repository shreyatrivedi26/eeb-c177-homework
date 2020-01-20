Part 3:

1. ls ~/Developer/Repos/CSB/unix/data/ | wc -l > pipe_data_lines.txt

2. cat pp*.fasta|wc -c > fasta-cat.txt

Cut command:

2. head -n 11 Pacifici2013_data.csv |cut -d ";" -f 3

Here 11 entries are used as the first column is the header of the file (Family).

Using Tail command:

 tail -n 5 Pacifici2013_data.csv

1. tail -n +2 Pacifici2013_data.csv (This will skip the header of the file)

2. tail -n +2 Pacifici2013_data.csv | head -n 10 > Pacifici_10.txt


