
---

## Recent Updates (May 15, 2026)

### Database Cleanup Completed
- ✅ Dropped orphaned PUT_FORTH_NEW table (never used)
- ✅ Dropped MOT_JUSTE and QUIBBLES_N_BITS (unused advanced system)
- ✅ Archived legacy PHRASING → PHRASING_ARCHIVE (1,762 phrasings preserved)
- ✅ Archived legacy PUT_FORTH → PUT_FORTH_ARCHIVE (103 cached phrasings)
- ✅ Renamed PHRASING_NEW → PHRASING (cleaner naming)
- ✅ Renamed putForthID → phrasingID (less confusing)

### Weighted Phrasing System Implemented
- ✅ Added weight column to PHRASE_ENDORSE (supports 0-100 weighting)
- ✅ Migrated all 1,762 phrasings from archive to active PHRASING table
- ✅ Added cache columns to ARGUMENT (currentPhrasing, currentPhrasingID)
- ✅ Created populatePhrasingCache() procedure
- ✅ Populated cache for 1,699 of 1,701 arguments

**Cache Statistics:**
- 136 arguments use phrasings from weighted user endorsements
- 1,563 arguments use fallback phrasings (oldest from PHRASING table)

### Updated Table Counts (May 15, 2026)
- ARGUMENT: 1,701 arguments (was 219 - miscount corrected)
- USER_PROFILE: 59 users
- PHRASING: 1,762 phrasings (complete dataset)
- PHRASE_ENDORSE: 249 endorsements (now with weight support)
- ENDORSEMENT: 6,146 weighted connections
- OPINION: 1,276 accept/reject decisions
- EXPLICATION: 11 external links

### Remaining Work for Weighted Phrasings
- Fix getOpinion procedure
- Fix newPutForth procedure
- Update getDetail to use weighted aggregation
- Update getAltPhrasing to show weighted scores
- Create endorsePhrasing() procedure for UI
- Create updatePhrasingCache() procedure
- Update assertOpinion to refresh cache on toggle
- Build UI for weighted phrasing endorsement

