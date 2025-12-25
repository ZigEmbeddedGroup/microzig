@/TODO_ANALYSIS_BATCH_01.md
@/TODO_ANALYSIS_BATCH_02.md
@/TODO_ANALYSIS_BATCH_03.md
@/TODO_ANALYSIS_BATCH_04.md
@/TODO_ANALYSIS_BATCH_05.md
@/TODO_ANALYSIS_BATCH_06.md
@/TODO_ANALYSIS_BATCH_07.md
@/TODO_ANALYSIS_BATCH_08.md
@/TODO_ANALYSIS_BATCH_09.md
@/TODO_ANALYSIS_BATCH_10.md
@/TODO_ANALYSIS_BATCH_11.md
@/TODO_ANALYSIS_BATCH_12.md
@/TODO_ANALYSIS_BATCH_13.md
@/TODO_ANALYSIS_BATCH_14.md
@/TODO_ANALYSIS_BATCH_15.md
@/TODO_ANALYSIS_BATCH_16.md
@/TODO_ANALYSIS_BATCH_17.md
@/TODO_ANALYSIS_BATCH_18.md
@/TODO_ANALYSIS_BATCH_19.md
@/TODO_ANALYSIS_BATCH_20.md
@/TODO_ANALYSIS_BATCH_21.md
@/TODO_ANALYSIS_BATCH_22.md
@/TODO_ANALYSIS_BATCH_23.md
@/TODO_ANALYSIS_BATCH_24.md
@/TODO_ANALYSIS_BATCH_25.md
@/TODO_ANALYSIS_BATCH_26.md
@/TODO_ANALYSIS_BATCH_27.md
@/TODO_ANALYSIS_BATCH_28.md
@/TODO_ANALYSIS_BATCH_29.md

# Master Task: TODO/FIXME Analysis Coordinator

## Objective

Analyze the batch files and produce a final report with all the batches analyzed
together detailing all the tickets that should be made, grouping what needs to
be grouped, find duplicates, TODO comments that are no longer needed. This used to be part of the
planner prompt, but I don't want you to plan a task, I want you to execute it
since you have all the files in context.

## Notes

Remember that git can paginate output, this causes you to pause indefinitely.
Ensure git invocations won't do this.

## Phase 1: Discovery & Planning

1. **Search for all TODOs and FIXMEs**
   - Use `search_files` or `grep_search` to find all TODO and FIXME comments
   - Include common variations: TODO, FIXME, @todo, @fixme, XXX, HACK

2. **Create inventory file**: `TODO_INVENTORY.json`
   ```json
   {
     "total_count": 0,
     "batches": [
       {
         "batch_number": 1,
         "directory": "src/components",
         "item_ids": [1, 2, 3, 4, 5],
         "start_id": 1,
         "end_id": 25
       }
     ],
     "items": [
       {
         "id": 1,
         "file": "path/to/file.js",
         "line": 123,
         "type": "TODO",
         "text": "TODO: Fix this edge case"
       }
     ]
   }
```

3. **Group into batches**
   - Create batches of 20-25 TODOs each
   - Group logically by directory/module where possible
   - Assign sequential batch numbers (01, 02, 03, etc.)
   - Store batch information in the inventory file

4. **Create progress tracker**: `TODO_ANALYSIS_PROGRESS.md`
```markdown
   # TODO Analysis Progress

   Total TODOs: [X]
   Total Batches: [Y]
   Batch Tasks Created: 0/[Y]

   ## Batch Status

- [ ] Batch 01: [Directory/Module] (items 1-25) - PENDING
- [ ] Batch 02: [Directory/Module] (items 26-50) - PENDING
   ...
```

## Phase 2: Automatically Create All Batch Analysis Tasks Sequentially

**IMPORTANT**: After Phase 1 completes, you MUST create ALL batch tasks sequentially without stopping. Do NOT wait for user input between batches.

For each batch in the inventory (in order from 01 to N):

1. **Create the batch task** using `new_task` with this exact prompt:

"""
# Analyze TODO Batch [XX]: [Module/Directory Name]

**Batch Info**: Items [start]-[end] from TODO_INVENTORY.json

## Your Mission
You are analyzing Batch [XX] of the TODO analysis project. This is an independent task that will complete on its own.

## Your Tasks
Analyze each TODO in this batch following these steps:

### For Each TODO:

1. **Locate**: Open the file and read 10 lines before and after the TODO
2. **Git Blame**: Run `git blame -L [line],[line] [file]` to get author, date, and commit hash
3. **Commit Context**: Run `git log -1 [hash] --pretty=format:"%s%n%b"` to get commit message
4. **Code Context**: Identify the function/class/module containing the TODO
5. **Analyze**:
   - What is the TODO asking for?
   - Why might it have been left incomplete? (use commit message + code context)
   - Estimate complexity: Low/Medium/High
   - Are there related TODOs nearby?

### Output Format

For each TODO, write:

```markdown
### TODO #[ID]: [Brief one-line summary]

**Location**: `path/to/file.ext:line`  
**Author**: [Name] ([YYYY-MM-DD])  
**Commit**: [hash] - "[commit message]"

**Original Comment**:
```
[exact TODO text]
```

**Code Context**:
```[language]
[10 lines of surrounding code with the TODO highlighted]
```

**Analysis**:

- **Purpose**: [What needs to be done]
- **Why Incomplete**: [Best guess from commit/context, or "Insufficient context"]
- **Complexity**: Low/Medium/High
- **Related Items**: [Any nearby TODOs or related code]

**Recommendation**: [Specific action to resolve this]

---
```

## Save Results
Save all analyses to: `TODO_ANALYSIS_BATCH_[XX].md` (use zero-padded numbers: 01, 02, 03, etc.)

## Mark Complete
When done:
1. Update `TODO_ANALYSIS_PROGRESS.md` to mark Batch [XX] as COMPLETE
2. Add a checkmark to the batch line
3. Report completion: "Batch [XX] analysis complete - [N] TODOs analyzed"
"""

2. **Immediately after creating the task**, update `TODO_ANALYSIS_PROGRESS.md`:
   - Increment "Batch Tasks Created" counter
   - Change that batch's status from "PENDING" to "CREATED"

3. **Without waiting or pausing**, proceed immediately to create the next batch task

4. **Continue this loop** until ALL batches have been created

5. **After creating all batch tasks**, add a summary to `TODO_ANALYSIS_PROGRESS.md`:
   ```markdown
   ## Coordinator Summary

- All [Y] batch tasks have been created and are running independently
- Created on: [timestamp]
- Each batch will complete independently and update its status
- When all batches show COMPLETE, run Phase 4 consolidation
```

**DO NOT STOP between batch creations. Create all batches in one continuous sequence.**

## Phase 3: Monitor Progress

After creating all batch tasks:

1. Report to the user:
```
✅ Created [Y] batch analysis tasks
📝 Each task is running independently
📊 Track progress in TODO_ANALYSIS_PROGRESS.md
⏳ Estimated completion time: [calculate based on batch count]

When all batches show COMPLETE in the progress file, tell me "consolidate" to merge results.
```

2. Keep this coordinator task open for final consolidation

## Phase 4: Consolidation Task (Run When User Says "consolidate")

When the user confirms all batches are complete, create a final `new_task` to:

"""
# TODO Analysis Consolidation

## Your Mission
Merge all batch analysis files into a comprehensive final document.

## Tasks

1. **Read all batch files**: `TODO_ANALYSIS_BATCH_*.md`

2. **Create comprehensive analysis**: `TODO_ANALYSIS_FINAL.md` with:

### Structure:
```markdown
# TODO/FIXME Analysis - Final Report

## Executive Summary

- Total TODOs analyzed: [X]
- Batches processed: [Y]
- Analysis date: [date]

## Statistics

- By complexity: [Low/Medium/High counts]
- By type: [TODO/FIXME counts]
- By directory: [breakdown]

## Detailed Findings
[All TODO analyses organized by directory/module]

## Suggested Ticket Groupings

### High Priority
**Ticket 1: [Feature/Area]**

- TODOs: #1, #5, #12
- Rationale: [why these should be grouped]
- Estimated effort: [X hours/days]

### Medium Priority
...

### Low Priority
...

## Next Steps
[Recommended actions and priorities]
```

3. **Identify cross-batch relationships**: Look for TODOs that reference each other or relate to the same feature

4. **Create actionable tickets**: Group related TODOs into logical work items

5. **Generate summary statistics**: Count by complexity, type, directory, etc.

"""

## Start Now
Begin Phase 1: Discovery & Planning

**Remember**: In Phase 2, you MUST create ALL batch tasks sequentially without stopping or waiting for user input. Each task runs independently once created.
