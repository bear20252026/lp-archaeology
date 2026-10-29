#!/usr/bin/env python3
"""从二进制(IL2CPP data 容器/任意资源)提取可打印 ASCII 字符串。

输出按行写入,供后续 grep 定位:类型名、Tooltip、URL、路径、调试键等。
仅保留 >=6 字符的连续可打印段,与本项目的 data-strings.txt 口径一致。
"""
import re, sys

def main():
    src = sys.argv[1]
    dst = sys.argv[2] if len(sys.argv) > 2 else src + '.strings.txt'
    data = open(src, 'rb').read()
    strs = re.findall(rb'[ -~]{6,}', data)
    open(dst, 'wb').write(b'\n'.join(strs))
    print(f'{src}: {len(strs):,} 行 -> {dst}')

if __name__ == '__main__':
    main()
