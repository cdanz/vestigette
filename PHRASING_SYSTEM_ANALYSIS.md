# Phrasing System Analysis

## Current State: Table Usage by Stored Procedures

### Tables in Use:
1. **PHRASING** (legacy - 1,762 rows)
2. **PHRASING_NEW** (current - 233 rows)
3. **PUT_FORTH** (legacy - 103 rows)
4. **PUT_FORTH_NEW** (not referenced in any procedures!)
5. **PHRASE_ENDORSE** (current - 249 rows)
6. **QUIBBLES_N_BITS** (refinement system)
7. **MOT_JUSTE** (winning phrasing text)

### Discovery: PUT_FORTH_NEW is ORPHANED!
**PUT_FORTH_NEW is not used by any stored procedure** - it appears to be a failed migration attempt.

---

## Procedures Analysis

### READ Operations (Display phrasings)

**getAltPhrasing** - Shows alternative phrasings
- Uses: PHRASE_ENDORSE + PHRASING_NEW
- Counts endorsements by profileID
- Returns phrasings ordered by popularity

**getDetail** - Shows main argument phrasing
- Uses: PHRASING_NEW + PHRASE_ENDORSE
- Complex COALESCE logic to pick "winning" phrasing:
  1. Phrasing with score > 1 (most endorsed)
  2. Earliest phrasing with score > 1
  3. Single phrasing (score = 1)
  4. Fallback to oldest phrasing
- **This already does weighted selection!**

**getOpinion** - Shows user's selected phrasing
- Uses: PHRASE_ENDORSE + PHRASING (legacy!)
- **BUG: References old PHRASING table, not PHRASING_NEW**

### WRITE Operations (User actions)

**newPutForth** - User creates new phrasing
- Inserts into: PHRASING (legacy!)
- Updates: PHRASE_ENDORSE
- **BUG: Writing to old PHRASING table**

**promotePhrasing** - Promote existing phrasing (unused?)
- Uses: PHRASING (legacy)
- Appears to be deprecated code

**replacePutForth** - Edit existing phrasing
- Uses: PHRASING (legacy)
- Updates phrasing text directly

### OPINION TOGGLE (Accept/Reject)

**assertOpinion** - When user accepts/rejects argument
- Activates/deactivates PHRASE_ENDORSE records
- Activates/deactivates ENDORSEMENT records
- Activates/deactivates EXPLICATION records
- **Critical: Controls what data counts in aggregates**

### ADVANCED SYSTEM (Mot Juste/Quibbles)

**promoteMotJuste** - Create refined version of phrasing
- Uses: QUIBBLES_N_BITS + MOT_JUSTE
- Allows micro-edits to phrasings
- Calls updateCurrentPhrasing

**cosignMotJuste** - Endorse a refined phrasing
- Uses: QUIBBLES_N_BITS
- Calls updateCurrentPhrasing

**cosignPutForth** - Endorse base phrasing (no refinement)
- Uses: QUIBBLES_N_BITS
- Calls updateCurrentPhrasing

**updateCurrentPhrasing** - Determine winning phrasing
- Uses: QUIBBLES_N_BITS + MOT_JUSTE + PUT_FORTH + PHRASING
- Counts votes for putForthID and quibbleID
- Updates PUT_FORTH.currentPhrasing
- **This is the aggregation logic!**

---

## The REAL System Architecture

### There are TWO separate phrasing systems running!

**System 1: Simple Endorsement (Currently Used)**
- PHRASING or PHRASING_NEW = master phrasing list
- PHRASE_ENDORSE = user endorsements (binary: endorsed or not)
- Used by: getAltPhrasing, getDetail, getOpinion, newPutForth, assertOpinion

**System 2: Quibbles & Mot Juste (Advanced, Partially Implemented)**
- PUT_FORTH = base phrasings
- MOT_JUSTE = refined versions of phrasings
- QUIBBLES_N_BITS = user votes for specific refinements
- Used by: promoteMotJuste, cosignMotJuste, cosignPutForth, updateCurrentPhrasing

### The Confusion:
- **System 1** uses PHRASE_ENDORSE for counting endorsements
- **System 2** uses QUIBBLES_N_BITS for voting on refinements
- **Both try to solve the same problem: aggregate user preferences**
- **Neither supports weighting!**

---

## Critical Bugs Found

1. **getOpinion** references PHRASING (legacy) instead of PHRASING_NEW
2. **newPutForth** writes to PHRASING (legacy) instead of PHRASING_NEW
3. **PUT_FORTH_NEW** exists but is never used (orphaned table)
4. **Mot Juste system** is partially implemented but not integrated with main UI

---

## Migration Strategy for Weighted Phrasings

### Option A: Extend PHRASE_ENDORSE (Simpler)
Add `weight` column to PHRASE_ENDORSE:
```sql
ALTER TABLE PHRASE_ENDORSE 
ADD COLUMN weight INT UNSIGNED DEFAULT 100 AFTER phrasingID;
```

**Pros:**
- Minimal code changes
- Existing procedures mostly still work
- Just update getDetail aggregation logic

**Cons:**
- Still have PHRASE_ENDORSE vs PUT_FORTH_NEW confusion
- Doesn't clean up legacy tables

### Option B: Create New PHRASING_ENDORSEMENT Table (Cleaner)
Drop PUT_FORTH_NEW and PHRASE_ENDORSE, create unified table:
```sql
CREATE TABLE PHRASING_ENDORSEMENT (
    argumentID INT UNSIGNED,
    phrasingID INT UNSIGNED,
    profileID INT UNSIGNED,
    weight INT UNSIGNED DEFAULT 100,
    active TINYINT(1) DEFAULT 1,
    createdDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    lastModified TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (argumentID, phrasingID, profileID),
    FOREIGN KEY (argumentID) REFERENCES ARGUMENT(argumentID),
    FOREIGN KEY (phrasingID) REFERENCES PHRASING_NEW(putForthID),
    FOREIGN KEY (profileID) REFERENCES USER_PROFILE(profileID)
);
```

**Pros:**
- Clean architecture matching ENDORSEMENT table
- Removes confusion between tables
- Supports weighting from day 1

**Cons:**
- Requires rewriting 8+ stored procedures
- Data migration needed
- More disruptive change

### Option C: Fix Bugs First, Then Add Weighting
1. Fix getOpinion and newPutForth to use PHRASING_NEW
2. Drop PUT_FORTH_NEW (unused)
3. Consolidate PHRASING → PHRASING_NEW
4. THEN add weighting to PHRASE_ENDORSE

---

## Recommendation

**Start with Option C (Fix bugs first)**, then choose A or B for weighting.

### Phase 1: Bug Fixes (Immediate)
1. Fix getOpinion: PHRASING → PHRASING_NEW
2. Fix newPutForth: PHRASING → PHRASING_NEW
3. Drop PUT_FORTH_NEW (unused)
4. Test all phrasing functionality

### Phase 2: Data Consolidation
1. Migrate remaining PHRASING data to PHRASING_NEW
2. Drop PHRASING table
3. Update any remaining legacy references

### Phase 3: Add Weighting (Choose A or B)
- Option A if you want quick implementation
- Option B if you want clean architecture

---

## Next Steps

1. Create backup of database
2. Fix getOpinion procedure
3. Fix newPutForth procedure
4. Test phrasing creation/endorsement
5. Decide on Option A vs B for weighting
6. Implement chosen option

