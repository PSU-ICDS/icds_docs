// a sample analysis job
version 13
use http://www.stata-press.com/data/r13/census5
// obtain the summary statistics:
tabulate region
summarize marriage_rate divorce_rate median_age if state!="Nevada"
