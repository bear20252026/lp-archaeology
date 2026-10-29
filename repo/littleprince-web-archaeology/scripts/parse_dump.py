#!/usr/bin/env python3
"""从 Il2CppDumper 的 dump.cs 中切出"游戏本体"类型清单。

判据:命名空间以 B612 / LittlePrince 开头(引擎与第三方类型全部排除)。
对每个类型统计方法数与字段数,输出 Markdown 清单。
本项目实测:337 个类型 / 13 个命名空间 / 9 个自有程序集。
"""
import re, sys
from collections import Counter

GAME_NS = re.compile(r'^// Namespace: ((?:B612|LittlePrince)[A-Za-z0-9_.]*)$', re.M)
DECL = re.compile(
    r'^((?:public|internal|protected|private)[^\n]*?\b(?:class|struct|enum|interface)\s+'
    r'[A-Za-z0-9_@<>,.: ]+?// TypeDefIndex: \d+)\s*\n\{\n(.*?)\n\}', re.S | re.M)

def main():
    dump = sys.argv[1]
    text = open(dump, encoding='utf-8', errors='replace').read()
    game = []
    for b in re.split(r'(?=^// Namespace: )', text, flags=re.M):
        m = GAME_NS.match(b)
        if not m:
            continue
        ns = m.group(1)
        for d in DECL.finditer(b):
            game.append((ns, d.group(1), d.group(2)))
    cnt = Counter(ns for ns, _, _ in game)
    out = [f'# 游戏本体类型全景(dump.cs 解析)\n', f'> 共 {len(game)} 个类型\n']
    for ns, decl, body in sorted(game):
        methods = len(re.findall(r'^\t(?:public|private|protected|internal|static)[^\n]*\(', body, re.M))
        fields = len(re.findall(r'// 0x[0-9A-F]+$', body, re.M))
        out.append(f'- **[{ns}]** `{decl.split("//")[0].strip()}` — 方法 {methods},字段 {fields}')
    dst = sys.argv[2] if len(sys.argv) > 2 else '游戏本体类型全景.md'
    open(dst, 'w', encoding='utf-8').write('\n'.join(out))
    print(f'{len(game)} 个类型:', dict(cnt.most_common()), '->', dst)

if __name__ == '__main__':
    main()
