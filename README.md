UIImage-NetPGM
==============

UIImage category to open [PGM image format](http://en.wikipedia.org/wiki/Portable_graymap)

Supports only 'P5' type (binary, .pgm extension) for now.

Usage:

```objc
UIImage *image = [UIImage imageFromPgmFilePath:path];
```