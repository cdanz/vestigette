#!/usr/bin/env python3
"""
Blanket-fix mojibake in PHRASING.phrasing.

The corruption pattern is UTF-8 text that was decoded as Windows-1252 and then
re-encoded as UTF-8. The most common visible artifact is the em-dash:
  original `—` (U+2014, UTF-8 E2 80 94)
  corrupted bytes in DB: C3 A2  E2 82 AC  E2 80 9D  (renders as `â€"`)

We also see `Â°` for `°`.

Strategy: read every row, attempt the standard "double-encoding" fix
(encode as latin-1, decode as utf-8). If it round-trips cleanly we use the
result. If it raises, we leave the row alone.

Dry-run mode prints proposed changes; --apply runs the UPDATEs.
"""
import argparse, subprocess, sys

MYSQL = ['/Applications/MAMP/Library/bin/mysql', '-u', 'root', '-proot',
         '-h', 'localhost', 'vestigette', '--default-character-set=utf8mb4']


def fetch_rows():
    # Fetch all rows; filter in Python so we don't have to escape bytes
    # through the shell layer. Uses tab as delim; phrasing has no tabs.
    out = subprocess.check_output(
        MYSQL + ['--batch', '--raw', '--skip-column-names', '-e',
                 "SELECT phrasingID, phrasing FROM PHRASING;"]
    )
    rows = []
    for line in out.split(b'\n'):
        if not line.strip():
            continue
        pid, _, phr = line.partition(b'\t')
        rows.append((int(pid), phr.decode('utf-8', errors='replace')))
    return rows


REPLACEMENTS = [
    # The dominant artifact: UTF-8 em-dash (E2 80 94) was decoded as
    # Windows-1252 -> 'â' (E2) + '€' (80) + '"' (94, U+201D) -> re-encoded
    # to UTF-8. So we see U+00E2 U+20AC U+201D and want U+2014 '—'.
    ('â€”', '—'),
    # Other plausible variants in case some rows got slightly different decoding
    ('â€—', '—'),    # em-dash variant
    ('â€“', '–'),    # en-dash --> the same Win-1252 path with 0x93
    ('â€™', '’'),    # right single quote
    ('â€œ', '“'),    # left double quote
    ('â€', '”'),    # right double quote
    ('â€¦', '…'),    # ellipsis
    # Two-byte Latin-1 chars: C2 XX
    ('Â°', '°'),          # °
    ('Â ', ' '),          # nbsp
]


def fix(text):
    new = text
    for bad, good in REPLACEMENTS:
        new = new.replace(bad, good)
    return new, (new != text)


def sql_escape(s):
    return s.replace('\\', '\\\\').replace("'", "''")


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument('--apply', action='store_true')
    ap.add_argument('--show', type=int, default=10,
                    help='How many sample changes to print in dry-run')
    args = ap.parse_args()

    rows = fetch_rows()
    print(f'Fetched {len(rows)} candidate rows.', file=sys.stderr)

    fixes = []
    skipped = 0
    for pid, phr in rows:
        new, changed = fix(phr)
        if changed:
            fixes.append((pid, phr, new))
        else:
            skipped += 1

    print(f'{len(fixes)} rows will be updated; {skipped} unchanged.',
          file=sys.stderr)

    for pid, old, new in fixes[:args.show]:
        print(f'\n  phrasingID={pid}')
        print(f'  OLD: {old!r}')
        print(f'  NEW: {new!r}')

    if not args.apply:
        print('\n(dry-run; pass --apply to commit)', file=sys.stderr)
        return

    # Build one big SQL file
    sql_path = '/tmp/phrasing_mojibake_fix.sql'
    with open(sql_path, 'w', encoding='utf-8') as f:
        f.write('SET NAMES utf8mb4;\nSTART TRANSACTION;\n')
        for pid, _, new in fixes:
            f.write(f"UPDATE PHRASING SET phrasing = '{sql_escape(new)}' "
                    f"WHERE phrasingID = {pid};\n")
        f.write('COMMIT;\n')

    print(f'Wrote {sql_path}; applying...', file=sys.stderr)
    subprocess.check_call(MYSQL + ['-e', f'source {sql_path}'])
    print('Done.', file=sys.stderr)


if __name__ == '__main__':
    main()
