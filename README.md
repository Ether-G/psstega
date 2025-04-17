# PS-Stega: PowerShell Steganography Tool

A simple yet powerful steganography utility written in PowerShell that allows you to hide ZIP files within images.

## Overview

PS-Stega provides two different steganography methods:

1. **Append Method**: Simply appends ZIP data to the end of any image file
2. **WebP Chunk Method**: Embeds ZIP data as a custom chunk within WebP images

Both methods are designed to be easy to use while effectively hiding your data in plain sight.

## Features

- Hide any ZIP file inside an image
- Two different steganography techniques
- Simple command-line interface
- Cross-platform (works on any system with PowerShell)
- Minimal dependencies (uses only built-in PowerShell functionality)

## Requirements

- PowerShell 5.1 or higher
- No additional modules required

## Installation

1. Clone this repository or download the script files
2. Ensure PowerShell execution policy allows running the scripts

```powershell
Set-ExecutionPolicy -Scope CurrentUser -ExecutionPolicy RemoteSigned
```

## Usage

### Append Method

#### Encoding (Hiding Data)

```powershell
.\encode.ps1 -ImagePath "path\to\cover.jpg" -ZipPath "path\to\secret.zip" -OutputPath "path\to\output.jpg"
```

#### Decoding (Extracting Data)

```powershell
# If you have the original image:
.\decode.ps1 -StegoPath "path\to\stego.jpg" -OriginalImagePath "path\to\original.jpg" -OutputZipPath "path\to\extract.zip"

# If you know the size of the original image:
.\decode.ps1 -StegoPath "path\to\stego.jpg" -ImageSize 123456 -OutputZipPath "path\to\extract.zip"
```

### WebP Chunk Method

#### Encoding (Hiding Data)

```powershell
.\encode.ps1 -ImagePath "path\to\cover.webp" -ZipPath "path\to\secret.zip" -OutputPath "path\to\output.webp"
```

#### Decoding (Extracting Data)

```powershell
.\decode.ps1 -StegoPath "path\to\stego.webp" -OutputZipPath "path\to\extract.zip"
```

## How It Works

### Append Method

The append technique simply:
1. Takes the bytes of the original image file
2. Takes the bytes of the ZIP file
3. Concatenates them together into a new file

This works because most image viewers only read up to where they expect the image data to end, ignoring any trailing data.

### WebP Chunk Method

The WebP chunk technique:
1. Creates a custom chunk with ID "stEG"
2. Embeds the ZIP data into this chunk
3. Updates the file size in the WebP header
4. Appends this chunk to the WebP file

This technique takes advantage of the WebP format's chunk-based structure, allowing for custom data to be embedded while maintaining a valid WebP file.

## Security Considerations

- This tool provides security through obscurity - it is not encryption
- The presence of hidden data may be detectable through file size analysis
- For sensitive data, consider encrypting your ZIP file before embedding

## License

[MIT License](LICENSE)

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## Acknowledgements

This project was inspired by various steganography techniques and the flexibility of the WebP format.
