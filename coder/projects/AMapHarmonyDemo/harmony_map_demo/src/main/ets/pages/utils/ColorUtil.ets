export class ColorUtil{
  static colorStringToNumber(hex: string){
    // Remove the leading '#' character
    hex = hex.replace(/^#/, "").toUpperCase();

    let alpha = 255; // Default alpha value for #RRGGBB format
    let color: number;

    if (hex.length === 8) {
      // Format is #AARRGGBB
      alpha = parseInt(hex.slice(0, 2), 16);
      color = parseInt(hex.slice(2), 16);
    } else if (hex.length === 6) {
      // Format is #RRGGBB
      color = parseInt(hex, 16);
    } else {
      // throw new Error("Invalid hex color format");
      return 0;
    }
    // Combine alpha and color in ARGB format
    return ((alpha << 24) | color) >>> 0;
  }
}