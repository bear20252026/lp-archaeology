#!/usr/bin/env python3
"""验证并使用 dump.cs RVA <-> wasm2wat 函数编号的对应关系。

结论(本项目已验证):dump.cs 中方法的 `RVA: 0x<HEX>` 十六进制值转十进制 N,
即 wasm-all.wat 中的函数 `(func $fN`。由此可以按类查地址、按地址取反汇编。
用法:
  python verify_rva_wat.py <dump.cs> <wasm-all.wat> <类名>      # 列出该类全部方法地址
  python verify_rva_wat.py <dump.cs> <wasm-all.wat> <类名> <方法名>  # 打印方法体(前 200 行)
"""
import re, sys

def methods_of(text, cls):
    pat = re.compile(
        r'// Namespace: ([A-Za-z0-9_.]+)\n((?:public|internal|protected|private)[^\n]*\b(?:class|struct|enum)\s+'
        + re.escape(cls) + r'\b[^\n]*// TypeDefIndex: \d+)\s*\n\{\n(.*?)\n\}', re.S)
    m = pat.search(text)
    if not m:
        sys.exit(f'未找到类 {cls}')
    ns, decl, body = m.groups()
    out = []
    for mm in re.finditer(r'// RVA: (0x[0-9A-Fa-f]+)[^\n]*\n\t((?:public|private|protected|internal|static)[^\n]*)', body):
        out.append((mm.group(1), mm.group(2).strip()))
    return ns, decl, out

def main():
    dump, wat, cls = sys.argv[1], sys.argv[2], sys.argv[3]
    method = sys.argv[4] if len(sys.argv) > 4 else None
    text = open(dump, encoding='utf-8', errors='replace').read()
    ns, decl, methods = methods_of(text, cls)
    print(f'[{ns}] {decl.split("//")[0].strip()}')
    for rva, sig in methods:
        print(f'  {rva:>8s}  -> $f{int(rva, 16)}  {sig[:140]}')
    if method:
        hit = next((rva for rva, sig in methods if method in sig), None)
        if not hit:
            sys.exit(f'{cls} 中未找到方法 {method}')
        idx = int(hit, 16)
        src = open(wat, encoding='utf-8', errors='replace').read()
        i = src.find(f'(func $f{idx} ')
        if i < 0:
            sys.exit(f'wat 中未找到 func $f{idx}')
        print(f'\n===== {method} @ RVA {hit} => (func $f{idx} =====\n')
        print('\n'.join(src[i:i+8000].splitlines()[:200]))

if __name__ == '__main__':
    main()
