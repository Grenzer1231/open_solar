# Data Quality Report

## Summary of findings

### **id**
-  Not unique. Can't be used as a primary key.
-  Combination of **id** and **org_id** is unique except for cases when **id** is 0
-  0 value for **id**. Unclear business meaning need more clarification on the business process to produce this id value
-  Use a composite key as a primary key. **id**, **org_id**, **created_date**

### **address**
-  Only values are **NULL**,  **-**, and **demo**

### **state**
-  Have **NULL** or '' values
-  Should the **NULL** values be filtered out?
-  Need to confirm if this is the correct behavior
-  Not standardized. Some are not using Latin Alphabets. Some are codes (2 or 3 letters) while some are full words.
-  Confirm what countries/states do we need the data from. Are all of these states valid?
-  Assuming we need all the data, retain in the pipeline and try to do the translation at the business layer using translation API (long term)
-  Short term solution would be to use AI to create a mapping table of the states. Cons: what if new states from other countries arrive?
