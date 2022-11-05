# Pewlett Hackard Retirement Analysis

## Overview of Analysis
The human resources department anticipates that it will have a wave of its current employees retire over the next few years and is interested in understanding that specific demographic in order to prepare for succession planning and backfilling.  They have asked us to utilize available employee demographic data and departmental information to answer some specific questions:

1. How many employees will be retiring in the near future?
2. Of that retiree pool, how many are eligible for a retirement package?

## Results
We generated four queries that generated various data:
1. Query 1 generated a list of all employees in the database born betwen 1952 and 1955.  This included employees that might no longer be with the company and duplicate records where the employee had multiple titles during his or her tenure.
2. Query 2 refined that list to remove ex-employees and, for employees that had multiple titles, leave only the most recent title record.
3. Query 3 summarized Query 2 by title and count of retiring employees with that current title.
4. Query 4 generated a list of current employees that were approximately 10 years from retirement (whose birthdates were 10 years earlier than those in Queries 1 through 3).

It wasn't clear what exactly the mentorship program would be but my assumption for the rest of this analysis is that we would want to look to those near retirement to mentor that next group behind them in order to retain a level of leadership immediately after the retirees leave, but also to start thinking about how this next wave of retirees (those born in the 1960's) would be backfilled as well.

Some key takeaways from this first set of analysis:

![Image 1](/Resources/Image1_1.png)

- There are 72,458 current employees that would likely retire in the very near future (those born in the 50s).  Assuming even distribution of retirements across a three-year period, this is still a significant burden on HR to process and onboard approximately 24,000 employees per year.

![Image 2](/Resources/Image1_2.png)

- There are only 1,549 currently employees eligible for the mentorship program (those born in the 60s).

![Image 3](/Resources/Image1_3.png)

- Breaking down the near-term retiree pool by title, we see that 50,842 retirees have a "Senior" title.  This implies these individuals have significant experience in their fields and it might not be as easy to backfill internally without significant development.
- The remaining 21,616 employees in the upcoming retirement wave have lower titles.  These positions might be easier to backfill.  FOr example, "Staff" could imply administrative assistants or other support roles that are more easily filled by temporary or contractors.  This could be a short-term solution: utilize a staffing agency to backfill the positions and effectively outsource the HR while having internal staff focus on filling the core "Senior" roles.

## Summary


