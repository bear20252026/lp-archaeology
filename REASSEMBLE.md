# 大文件重组说明 / Reassembling Split Files

GitHub 对单个文件有 100MB 的硬性上限。以下 2 个文件超过该限制，已用 `split -b 90M` 拆分为分块上传。
原文件仍保留在本地磁盘上（已通过 `.gitignore` 排除出仓库），从分块可完整还原，还原后哈希与原文件一致（已验证）。

GitHub enforces a hard 100 MB limit per file. The two files below exceed that limit and were uploaded as chunks created with `split -b 90M`. The originals remain on the local disk (excluded via `.gitignore`) and can be rebuilt exactly from the chunks — the concatenated chunks were verified to match the original SHA-256 hashes.

## output/wasm-all.wat

- 原始大小 / Original size: 546,853,461 bytes
- SHA-256: `ef252e85bae6ba006e2351ed80f5c27ceb9002056d947aa4e019bee5aa710eaf`
- 分块 / Chunks: `output/wasm-all.wat.split/part-00` … `part-05`（共 6 块）

还原 / Reassemble:

```bash
# Git Bash / Linux / macOS
cat output/wasm-all.wat.split/part-* > output/wasm-all.wat
```

```bat
:: Windows CMD
copy /b output\wasm-all.wat.split\part-00+output\wasm-all.wat.split\part-01+output\wasm-all.wat.split\part-02+output\wasm-all.wat.split\part-03+output\wasm-all.wat.split\part-04+output\wasm-all.wat.split\part-05 output\wasm-all.wat
```

## tools/ripper/AssetRipper.GUI.Free.exe

- 原始大小 / Original size: 130,120,704 bytes
- SHA-256: `58bb4c6a78507d77ea115db236ae7286b097979fba7f77aa247c16a471499fff`
- 分块 / Chunks: `tools/ripper/AssetRipper.GUI.Free.exe.split/part-00` … `part-01`（共 2 块）

还原 / Reassemble:

```bash
# Git Bash / Linux / macOS
cat tools/ripper/AssetRipper.GUI.Free.exe.split/part-* > tools/ripper/AssetRipper.GUI.Free.exe
```

```bat
:: Windows CMD
copy /b tools\ripper\AssetRipper.GUI.Free.exe.split\part-00+tools\ripper\AssetRipper.GUI.Free.exe.split\part-01 tools\ripper\AssetRipper.GUI.Free.exe
```

## 校验 / Verify

```bash
sha256sum output/wasm-all.wat tools/ripper/AssetRipper.GUI.Free.exe
```

结果应与上方哈希一致 / The hashes must match the values above.
