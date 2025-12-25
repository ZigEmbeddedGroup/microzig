#!/usr/bin/env python3
import json
import re
import subprocess
import sys


def main():
    # Use git grep to find TODO/FIXME variants across tracked files (case-insensitive),
    # then parse into a structured JSON inventory. We filter out generated zig-out content.
    pattern = r'(TODO|FIXME|@todo|@fixme|XXX|HACK)'

    try:
        proc = subprocess.run(
            ['git', 'grep', '-nI', '-i', '-E', pattern],
            stdout=subprocess.PIPE,
            stderr=subprocess.PIPE,
            text=True,
            check=False,
        )
    except FileNotFoundError:
        print('Error: git not found on PATH', file=sys.stderr)
        return 1

    raw_lines = proc.stdout.splitlines()
    # Exclude generated outputs and similar folders commonly committed but not source-of-truth
    exclude_substrings = [
        '/zig-out/',
    ]
    lines = [ln for ln in raw_lines if not any(ex in ln for ex in exclude_substrings)]

    # Extract a normalized "type" and keep the full matched line as "text"
    type_re = re.compile(r'\b(TODO|FIXME|XXX|HACK)\b|@(todo|fixme)', re.IGNORECASE)

    items = []
    next_id = 1

    for ln in lines:
        # git grep -n format: path:line:content
        # Note: content may contain colons, so split only twice
        try:
            file, rest = ln.split(':', 1)
            line_str, text = rest.split(':', 1)
            line_no = int(line_str)
        except ValueError:
            # Skip malformed lines (unlikely)
            continue

        m = type_re.search(text)
        if m:
            t = (m.group(1) or m.group(2) or 'TODO').upper()
        else:
            t = 'TODO'

        # Normalize alias/variants
        if t.startswith('T'):
            norm_type = 'TODO'
        elif t.startswith('F'):
            norm_type = 'FIXME'
        elif t.startswith('X'):
            norm_type = 'XXX'
        elif t.startswith('H'):
            norm_type = 'HACK'
        else:
            norm_type = 'TODO'

        items.append({
            'id': next_id,
            'file': file,
            'line': line_no,
            'type': norm_type,
            'text': text.strip(),
        })
        next_id += 1

    data = {
        'total_count': len(items),
        'items': items,
    }

    with open('TODO_INVENTORY.json', 'w', encoding='utf-8') as f:
        json.dump(data, f, indent=2)
        f.write('\n')

    print(f'Wrote TODO_INVENTORY.json with {len(items)} items.')
    return 0


if __name__ == '__main__':
    raise SystemExit(main())
