#!/usr/bin/env python3
import json
import math
from collections import Counter
from pathlib import Path


INVENTORY_PATH = Path("TODO_INVENTORY.json")
PROGRESS_PATH = Path("TODO_ANALYSIS_PROGRESS.md")
BATCH_SIZE = 25  # within the 20-25 guideline; last batch may be smaller


def longest_common_prefix(parts_list, max_depth=3):
    if not parts_list:
        return None
    min_len = min(len(p) for p in parts_list)
    prefix = []
    for i in range(min_len):
        seg = parts_list[0][i]
        if all(p[i] == seg for p in parts_list):
            prefix.append(seg)
            if len(prefix) >= max_depth:
                break
        else:
            break
    if prefix:
        return "/".join(prefix)
    return None


def label_for_batch(files):
    parts_list = [f.split("/") for f in files if "/" in f]
    # Try longest common prefix up to 3 segments
    lcp = longest_common_prefix(parts_list, max_depth=3) if parts_list else None
    if lcp:
        return lcp
    # Fallback: most common top-level directory
    top_levels = [p[0] if p else f for f, p in zip(files, parts_list)]
    if top_levels:
        return Counter(top_levels).most_common(1)[0][0]
    # Final fallback
    return "Mixed"


def main():
    data = json.loads(INVENTORY_PATH.read_text(encoding="utf-8"))
    items = data.get("items", [])
    total_count = int(data.get("total_count", len(items)))

    # Sanity: ensure ids are 1..N in order
    items_sorted = sorted(items, key=lambda x: int(x["id"]))
    total = len(items_sorted)
    total_batches = math.ceil(total / BATCH_SIZE)

    lines = []
    lines.append("# TODO Analysis Progress\n")
    lines.append(f"Total TODOs: {total}\n")
    lines.append(f"Total Batches: {total_batches}\n")
    lines.append("\n## Batches\n")

    for batch_idx in range(total_batches):
        start_idx = batch_idx * BATCH_SIZE
        end_idx = min(start_idx + BATCH_SIZE, total)
        batch_items = items_sorted[start_idx:end_idx]
        ids = [int(it["id"]) for it in batch_items]
        files = [it["file"] for it in batch_items]
        label = label_for_batch(files)

        # Contiguous range by id as they are already ordered
        start_id, end_id = ids[0], ids[-1]
        batch_num = f"{batch_idx + 1:02d}"
        lines.append(f"- [ ] Batch {batch_num}: [{label}] (items {start_id}-{end_id})\n")

    PROGRESS_PATH.write_text("".join(lines), encoding="utf-8")
    print(f"Wrote {PROGRESS_PATH} with {total_batches} batches from {total} TODOs.")


if __name__ == "__main__":
    main()
