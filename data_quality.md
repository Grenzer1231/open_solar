# Data Quality Report

## Summary of findings

### **id**
-  Not unique. Can't be used as a primary key.
-  Makes sense to not be unique **IF** **ID** represents different versions/revisions/drafts of a proposal (proposal lifecycle)
-  Create two fct tables containing the latest state of the proposals and the historical states of a proposal 

### **address**
-  Only values are **NULL**,  **-**, and **demo**

### **state**
-  Have **NULL** or '' values
-  Need to confirm if this is the correct behavior
-  Not standardized. Some are not using Latin Alphabets. Some are codes (2 or 3 letters) while some are full words.
-  Confirm what countries/states do we need the data from. Are all of these states valid?
-  Assuming we need all the data, retain in the pipeline and try to do the translation at the business layer using translation API (long term)
-  Short term solution would be to use AI to create a mapping table of the states. Cons: what if new states from other countries arrive?

### **proposal_sent_date**
- Some records have **proposal_sent_date** < **created_date**
- This is possible if a proposal was created outside of the system and then later manually entered.
- Make a warning