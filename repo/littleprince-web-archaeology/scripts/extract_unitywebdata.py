#!/usr/bin/env python3
"""解析 Unity WebGL 的 UnityWebData1.0 容器(即 Build/*.data.br 的真实格式)。

容器布局:
  [0..16)   魔数 "UnityWebData1.0\0"
  [16..20)  头长度 head(小端 int32)——条目表从偏移 20 开始,到 head 结束
  条目:     offset(i32) size(i32) nameLen(i32) name(nameLen 字节 UTF-8)
  数据区:   各条目的 offset/size 指向的原始字节

用途:从中切出 global-metadata.dat(Il2CppData/Metadata/)与 data.unity3d,
前者交给 Il2CppDumper,后者是 Addressables 主资源归档。
"""
import struct, sys, os

def parse(path):
    data = open(path, 'rb').read()
    assert data[:16] == b'UnityWebData1.0\0', '不是 UnityWebData 容器'
    head = struct.unpack('<i', data[16:20])[0]
    pos = 20
    entries = []
    while pos < head:
        off, size, nlen = struct.unpack('<iii', data[pos:pos+12])
        name = data[pos+12:pos+12+nlen].decode('utf-8')
        entries.append((name, off, size))
        pos += 12 + nlen
    return data, entries

def main():
    src = sys.argv[1] if len(sys.argv) > 1 else 'data.br'
    out = sys.argv[2] if len(sys.argv) > 2 else 'out'
    os.makedirs(out, exist_ok=True)
    data, entries = parse(src)
    for name, off, size in entries:
        print(f'{name:60s} {size:>12,} B')
        blob = data[off:off+size]
        dest = os.path.join(out, name.replace('/', '_'))
        open(dest, 'wb').write(blob)
        if 'global-metadata' in name:
            magic, ver = struct.unpack('<Ii', blob[:8])
            assert magic == 0xfab11baf, f'metadata 魔数异常: {magic:#x}'
            print(f'  -> metadata 版本 {ver} (0xfab11baf 校验通过)')

if __name__ == '__main__':
    main()
