# webpifySH

A lightweight, production-ready Bash script for converting common image formats  
(`jpg`, `jpeg`, `png`, `gif`, `bmp`, `tiff`) to **WebP** using Google’s `cwebp` encoder.

**webpifySH** is designed to be simple, safe, and fast — ideal for local projects,
asset pipelines, and quick image optimization without extra dependencies.

---

## ✨ Features

- ✅ Converts multiple image formats to WebP
- 🎚 Configurable quality level
- 📁 Outputs converted files into a dedicated `converted/` folder
- ⏭ Automatically skips already converted images
- 🛡 Fails fast with clear error messages
- 🧩 Handles filenames with spaces correctly
- 💻 Compatible with macOS and Linux

---

## 📦 Requirements

`webpifySH` depends on **`cwebp`**, part of Google’s WebP tools.

### macOS
```bash
brew install webp
