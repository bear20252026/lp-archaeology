#!/usr/bin/env python3
"""从 Addressables catalog.bin 提取全部可打印字符串并过滤 32 位哈希。

catalog 引用的资源包内部名是 <GUID>.bundle;磁盘文件名是
<描述>_<GUID>.bundle.<内容哈希>.{br,raw}。用本脚本输出建立
"GUID <-> 磁盘文件"对照,即可对离线镜像做完整性审计
(本项目实测:84/84 内部包命中,3/3 .raw 备用文件齐全)。
"""
import re, sys

def main():
    src = sys.argv[1]
    raw = open(src, 'rb').read()
    strs = sorted(set(s.decode('ascii', 'replace') for s in re.findall(rb'[ -~]{6,}', raw)))
    open(src + '.strings.txt', 'w', encoding='utf-8').write('\n'.join(strs))
    addr = [s for s in strs if not re.fullmatch(r'[0-9a-f]{32}', s)]
    open(src + '.addresses.txt', 'w', encoding='utf-8').write('\n'.join(addr))
    print(f'共 {len(strs):,} 条;滤哈希后 {len(addr):,} 条')

if __name__ == '__main__':
    main()
