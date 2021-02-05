# lastzWrapper
Bash shell wrapper to build whole-genome alignments with lastz

# Dependencies
## Install the `lastz` version provided
I added some modification to the source code in lastz to that the MAF output is compatible wth `MutiZ` and `tba`.
Use this branch:
```
git clone https://github.com/santiagosnchez/lastz-1.git
```

## Install `gnu-parallel`
The script requires [GNU `parallel`](https://www.gnu.org/software/parallel/) to be installed in order for the `-threads` argument to work.

# Running the code
## 2 genomes
```
./lastzWrapper -sp1 species1.fas -sp2 species2.fas -threads #
```

## More than 2 genomes
Alignments for more than 2 genomes can be done with pairwise comparisons.
```
./lastzWrapper -sp1 species1.fas -sp2 species2.fas -threads #
./lastzWrapper -sp1 species1.fas -sp2 species3.fas -threads #
./lastzWrapper -sp1 species2.fas -sp2 species3.fas -threads #
```

